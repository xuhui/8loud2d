all: love terminal-dep

love: smart-game.love

smart-game.love: conf.lua keyboard.lua main.lua render.lua runengine.lua thegame.lua
	zip -9 smart-game.love conf.lua keyboard.lua main.lua render.lua runengine.lua thegame.lua

terminal-dep: msleep.so

msleep.so: msleep.c
	gcc -shared -o msleep.so msleep.c -fPIC -I/usr/include/lua5.1 -llua5.1
