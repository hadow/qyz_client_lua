local require = require
local utils = require "common.utils"
local encoder = require "common.binaryencoder"
local event = require "common.event"
local os = require "common.octets"
local msgmanager = require "common.msgmanager"

local insert = table.insert
local concat = table.concat
local fmt = string.format
local find = string.find
local sub = string.sub
local pairs = pairs
local print = print
local setmetatable = setmetatable
local ipairs = ipairs
local tostring = tostring
local _G = _G
local error = error
local type = type
local unpack = unpack
local dump_table = dump_table

local OctetsStream = OctetsStream

local metas = {}
local metatable_cache = {}
local id2name = {}
local lastsendtime = {} -- {msg.id,Time.time}
local MinSendInterval = 0.2 --最短发送协议时间间隔
local ProtocolCount = 0

local get_or_create = utils.get_or_create


local function add_type(namespace, ttype)
    local tname = ttype.name
    local full_name = not find(tname, ".", 1, true) and (namespace .. "." .. tname) or tname
    local special_name = full_name:gsub("%.", "_")
    if metatable_cache[full_name] then
        error("duplicate message:" .. full_name)
    end
    os.add_type(namespace, ttype)
    ttype.special_name = special_name
    ttype.full_name = full_name

    local id = ttype.id
    if id then
        if id2name[id] then
            error("duplicate message:" .. id .. " " .. special_name)
        end
        id2name[id] = full_name
    end
		
    local new_type = get_or_create(full_name)
	local new_mt = {}
	setmetatable(new_type, new_mt)
	
	new_mt.__index = new_mt
	
	
	new_mt._id = id
	new_mt._name = full_name

    local push_fun = os["push_" .. special_name]
	new_mt._encode = function (self, octs)
		push_fun(octs, self)
    end
    local pop_fun = os["pop_" .. special_name]
	new_mt._decode = function (self, octs)
		local r = pop_fun(octs)
		for k, v in pairs(r) do
			self[k] = v
		end
    end
    -- add const define.
	for k, v in pairs(ttype) do 
		if type(k) == "string" then
			new_type[k] = v
		end
	end	
		
	new_mt.__tostring = function(self)
            return "#" .. full_name .. "#" .. dump_table(self)
        end
    new_mt.__call = function(self, o)
		local msg = o or {}
		setmetatable(msg, new_mt)
		return msg
	end
	metatable_cache[full_name] = new_mt

    --print("message.add", id, full_name)
end

local function add_namespace(namespace_define)
    local namespace_name = namespace_define.name
    --namespace_name = namespace_name:gsub("%.", "_")
    for _, new_type in ipairs(namespace_define) do
        add_type(namespace_name, new_type)
    end
end

local function create(fullname, o)
    if not fullname or not metatable_cache[fullname] then
     --   print("unknown message :" .. fullname)
        return
    end
	return get_or_create(fullname)(o)
end

local function create_by_id(id, o)
	local full_name = id2name[id]
	if not full_name then
        print("unknown message id:" .. id)
    end
    return get_or_create(full_name)(o)
end

local msg_event = event:new("message")
local function add_listener(msg_name, func)
    return msg_event:add(msg_name, func)
end

local function remove_listener(event_id)
    return msg_event:remove(event_id)
end

local function add_listeners(listeners)
    local r = {}
    for _, v in ipairs(listeners) do
        insert(r, add_listener(unpack(v)))
    end
    return r
end

local function remove_listeners(event_ids)
    for _, v in ipairs(event_ids) do
        remove_listener(v)
    end
end

local function dispatch(msg)
    msg_event:trigger(msg._name, msg)
end

local ignore_protos = 
{
	["gnet.KeepAlive"] = true, 
	["map.msg.RoleProtocols"] = true,
	["lx.gs.SPing"] = true,
}

local ToString = Slua.ToString
local function receive(typeid, os)
    print("receive", id, id2name[id],  octs)

    local msg = create_by_id(typeid)
    if not msg then
        error("unknown message. id:" .. typeid .. ", size:" .. #octs)
    end
    msg:_decode(os)
    if not ignore_protos[id2name[typeid]] then
        if Local and Local.LogProtocol then
            print("=== recv.", msg)
        end
    end
	if string.match(id2name[typeid], "lx.gs") then
		if not string.match(id2name[typeid], "lx.gs.login") and not string.match(id2name[typeid], "lx.gs.chat") then
            ProtocolCount = ProtocolCount + 1
		end
	end
    dispatch(msg)
end

local function getProtocolCount()
	return ProtocolCount
end

local function setProtocolCount(count)
    ProtocolCount = count
end

local _send = LuaHelper.Send

-- no resend while resend = true or nil only
local function send(msg, resend)
    if false == msgmanager.CheckMsg(msg) then
        return
    end

    if not ignore_protos[msg._name] then
        if Local and Local.LogProtocol then
	       print(string.format("%.3f",UnityEngine.Time.time),"=== send.", msg)
	    end
	end
    local stream = OctetsStream()
    msg:_encode(stream)
    _send(msg._id, stream, resend ~= false)
end

local function create_and_send(full_name, o, resend)
    local msg = create(full_name, o)
    send(msg, resend)
end

--[[
local function dump_messages()
    local s = {}
    for _, meta in pairs(metas) do
        if meta.id then
            insert(s, meta.full_name .. ".TYPE,")
        end
    end
    print(concat(s, "\n"))
end


local namespace = 
{
	name = "gs.shop",
	{ name = "Shop",
		{ name="id1", type="int"},
	},
	{ name="JuanTuanInfo",
		{ name="id1", type="byte",},
		{ name="id2", type="short"},
		{ name="id3", type="int"},
		{ name="id4", type="long"},
		{ name="id5", type="float"},
		{ name="id6", type="double"},
		{ name="id7", type="string"},
		{ name="id8", type="bool"},
		{ name="x1", type="list", value="int"},
		{ name="x2", type="set", value="double"},
		{ name="x3", type="map", key="int", value="string"},
		{ name="y1", type="Shop"},
	},
	{ name="CShop", id = 1, -- 有id为message, 无id为bean. 不过add_namespace与add_type都未使用到此字段.
		{ name="shop", type="Shop"},
		{ name="info", type="JuanTuanInfo"},
	},
}

add_namespace(namespace)
--]]


return {
    msgs = id2name,
    metas = metas,
	getProtocolCount = getProtocolCount,
    setProtocolCount = setProtocolCount,
    add_type = add_type,
    add_namespace = add_namespace,
    
    create_by_id = create_by_id,
--    create = create,
    send = send,
	create_and_send = create_and_send,
	dispatch = dispatch,
    receive = receive,

    add_listener = add_listener,
    remove_listener = remove_listener,
    add_listeners = add_listeners,
    remove_listeners = remove_listeners,
	
}
