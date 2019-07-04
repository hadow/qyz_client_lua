cd ../../../luxian/branches/release
java -jar lib/rpcgen.jar -lua -luaOutputPath ../../../luxianres/trunk/code/scripts/msg protocol.client.xml
java -jar lib/rpcgen.jar -cs -csOutputPath ../../../luxianres/trunk/Unity/Assets/Source/RoleMsg cs.protocol.client.xml
pause
