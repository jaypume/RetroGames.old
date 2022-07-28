# RetroGames

This repository is used to organize retro games: 

- Collect and manage ROMs from various sources such as [oldmanemu.net], [no-intro], [r-roms], and so on 

- Support different operation systems, such as IOS, Android, Windows, Sony PSV, Nintendo Switch, and so on.

- Support different simulator platforms, such as RetroArch, Lakka, Pegasus and so on.


[oldmanemu.net]: https://www.oldmanemu.net/
[no-intro]: https://datomatic.no-intro.org/
[r-roms]: https://r-roms.github.io/megathread/nintendo/



## 为什么要做这个？
- 当前rom的管理很混乱，没有版本的概念，
- 无法协作
- 无法跨多个平台。比如我希望在Switch、IOS上等各个平台玩耍，rom现在需要大量工作。
- ROM文件存储浪费空间。
- 如果ROM都丢失了也不会修改维护好的列表和游戏，只需要从网上任意可以收集游戏的地方下载ROM，更新到库里即可全部恢复。



## 如何下载游戏、拷贝游戏
```
cp -L
```

需要开启便携列表

## 有新的ROM提交和更新的流程
## 有新的ROM如何更新？
- 不要使用系统浏览器来拷贝或操作相对路径，最好使用linux 命令



rom/Sega/1988 - MD/_source/MD.老街巷子游戏厅_咸鱼

TODO
清理: N64咸鱼文件夹，因为里面有很多cmd等文件。

编写天马 -> RA格式的转换
- Nintendo - N64
- Nintendo - NDS
- Sega - Naomi
- Sega - Saturn
- SNK - NGPC

TODO:
NeoGeo改成咸鱼的ROM


TODO:
[x] GBA几个文件改名
[x] 自动更新Switch ROM文件夹（如果改名了的话）
[x] 不用保留unsorted的csv
<!-- [-] 在-和·前后添加空格， -->
[x] 增加Switch列表，
[ ] CSV英文中有逗号... 待修改分隔符
[ ] 封面中的中文改怎么修改？
[ ] .Test合集等自动化



3. 思考文件夹类型的rom
    - 中文名/xx.cue,xx.bin
    - 中文名/xxx.zip
    - 中文名/xxx.zip 一堆系列的，NEOGEO，要改成咸鱼