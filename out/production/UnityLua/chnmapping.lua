--region *.lua
--Date
--此文件由[BabeLua]插件自动生成



--endregion


local mapping = {
    concatStr =  { "服","-【","】","点击选服"},  --不能删
    serverState = {"[00CC00]畅通[-]   ","[CC0000]爆满[-]   ","[808080]维护[-]   "}
}

local FlyText = {
    Fortune = "幸运一击",
    Excellent = "卓越一击",
    Crit = "致命一击",
    Miss = "闪避",
    MissPunch = "未击中",
} 
return {
    mapping = mapping,
    FlyText = FlyText,
}