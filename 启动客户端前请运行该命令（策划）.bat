@echo off
echo =================================================
echo �����������������󣬷�����cfg.xxx������������ʾ�� 
echo һ���������ļ����⣬��鿴SVN��־���ҵ��ϴ����ļ���Ա������ϴ��������ļ�
echo =================================================
java -jar lib/config.jar -lan lua -configxml ../csv/cfg.xml -codedir scripts -datadir ../GameWindows4.2.0/Data/config/csv -group client
java -jar lib/config.jar -lan cs -configxml ../csv/cfg.xml -codedir ../Unity/Assets/Source/Config/csv  -group all
java -jar lib/config.jar -configxml ../csv/cfg.xml -csmarshalcodedir ../Unity/Assets/Source/Config/marshal -group all
pause