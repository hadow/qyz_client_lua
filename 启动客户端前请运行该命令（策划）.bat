@echo off
echo =================================================
echo 如果运行命令输出错误，发现有cfg.xxx这样的文字提示， 
echo 一般是配置文件问题，请查看SVN日志，找到上传该文件人员来检查上传的配置文件
echo =================================================
java -jar lib/config.jar -lan lua -configxml ../csv/cfg.xml -codedir scripts -datadir ../GameWindows4.2.0/Data/config/csv -group client
java -jar lib/config.jar -lan cs -configxml ../csv/cfg.xml -codedir ../Unity/Assets/Source/Config/csv  -group all
java -jar lib/config.jar -configxml ../csv/cfg.xml -csmarshalcodedir ../Unity/Assets/Source/Config/marshal -group all
pause