local unpack = unpack
local print = print
local math = math
local EventHelper = UIEventListenerHelper
local uimanager = require("uimanager")
local network = require("network")
local login = require("login")

local gameObject
local name

local fields
local DlgInfo

local SliderMax

local function destroy()
    -- print(name, "destroy")
end

local function show(params)
    DlgInfo = params and params or { title = LocalString.TipText, content = "" }
    if DlgInfo.title then
        fields.UILabel_Title.text = DlgInfo.title
    end
    if DlgInfo.inputtext then
        fields.UILabel_Input.text = DlgInfo.title
    end
	
	if DlgInfo.slider then
		fields.UIGroup_Slider.gameObject:SetActive(true)
		if DlgInfo.slidermax then
			SliderMax = DlgInfo.slidermax 
		end
		
		EventHelper.AddSliderValueChange(fields.UISlider_Amount, function()
			fields.UILabel_Input.text = math.floor(fields.UISlider_Amount.value*SliderMax)
		end)
	end

	fields.UIGroup_Button_1.gameObject:SetActive(false)
	fields.UIGroup_Button_2.gameObject:SetActive(false)
	
	if #params.buttons==1 then 
		fields.UIGroup_Button_1.gameObject:SetActive(true)
		local buttonData = buttons[1]
		fields.UILabel_OK.text = buttonData.text
		EventHelper.SetClick(fields.UIButton_CoinAction, function()
        -- printyellow("UIButton_ClearUp cliked")
			local amount = fields.UILabel_CoinAmount.text;
			buttonData.callFunc(amount)
		end )
	elseif #params.buttons==2 then
		fields.UIGroup_Button_2.gameObject:SetActive(true)
	end
	
    if DlgInfo.callBackFunc then
        EventHelper.SetClick(fields.UIButton_Sure, function()
            uimanager.hide(name)
            DlgInfo.callBackFunc()
        end )
    end
    if DlgInfo.callBackFunc1 then
        EventHelper.SetClick(fields.UIButton_Return,function()
            uimanager.hide(name)
            DlgInfo.callBackFunc1()
        end)
    end
    if DlgInfo.sureText then
        fields.UILabel_Sure.text=DlgInfo.sureText
    end
    if DlgInfo.cancelText then
        fields.UILabel_Return.text=DlgInfo.cancelText
    end
    -- print(name, "show")
end

local function hide()
    -- print(name, "hide")
end

local function update()

    -- print(name, "update")
end

local function refresh(params)
    --gameObject.transform.position = Vector3.forward * -1000
    --  fields.UIButton_Sure.Label_Sure.text = "OK"
    --  fields.UIButton_Return.Label_Return.text = "Return"
    -- fields.UILabel_Content.text = params
end


local function init(params)
    name, gameObject, fields = unpack(params)

    EventHelper.SetClick(fields.UIButton_Close, function()
        uimanager.hide(name)
    end )
end

return {
    init = init,
    show = show,
    hide = hide,
    update = update,
    destroy = destroy,
    refresh = refresh,
}
