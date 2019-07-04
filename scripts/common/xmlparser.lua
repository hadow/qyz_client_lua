--[[
	一个简单的 xml 解析器,将xml数据转换成相应的table
	如 
	警告:不能正确处理相同tag嵌套的情形,如 <a> <a> </a></a>
============================
	<?xml version="1.0" encoding="GBK"?>
	<app>
		<bean name="xxx">
			<field name="value" type="int"/>
		</bean>
	</app>
============================		
	被解析成table
    { __tag__ =  "app", { __tag__ = "bean", name="xxx", { {__tag__ = "field", name="value", type="int"}}}}

--]]

local find = string.find
local sub = string.sub
local gsub = string.gsub
local insert = table.insert
local gmatch = string.gmatch
local setmetatable = setmetatable

local function trip_header_and_comments(xml)
	xml = gsub(xml, "%<%?xml.*%?%>", "")
	xml = gsub(xml, "%<!%-%-.-%-%-%>", "")
	return xml
end

local function read_attrs(attrs, xml)
	local pat = '(%w+)%s*=%s*"([^"]-)"'
	for k, v in gmatch(xml, pat) do
		attrs[k] = v
	end
	return attrs
end

local function read_tag(xml, head)
	local pat = "%<(%w+)(.-)(/?)%>"
	local hs, he, tagname, attrs, closetag = find(xml, pat, head)
	--print(s, e, tagname, attrs, closetag)
	if not hs then return end
	local t = { __tag__ = tagname }
	read_attrs(t, attrs)
	if closetag == "/" then
		return t, he
	end
	local close_pat = "%</" .. tagname .. "%>"
	local cs, ce = find(xml, close_pat, he + 1)
	--print("tagend", cs, ce)
	if not cs then
		error("error: tag ".. tagname .. " not close!")
	end
	
	local content_xml = sub(xml, he + 1, cs - 1)
	if content_xml then
		local content_start = 1
		while true do
			local subtag, subtagend = read_tag(content_xml, content_start)
			if subtag then
				--print("subtag", subtag.name, subtag)
				insert(t, subtag)
				content_start = subtagend + 1
			else
				break
			end
		end
	end
	return t, ce
end

local function parse(xml)
	xml = trip_header_and_comments(xml)
	return read_tag(xml, 1)
end

return {
	parse = parse,
} 