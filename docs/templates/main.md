# 最小视觉模板操作说明

源码：`main.tex`。编译：根目录执行 `./scripts/build.ps1 -Target main`，输出 `build/main/main.pdf`。默认 5 张页面，其中 2 张正文页计入页码。共享尺寸、字号、颜色的完整说明见 [自主微调手册](../customization.md)。

## 1. 导言区要改什么

| 位置 | 当前设置与效果 | 如何改 |
| --- | --- | --- |
| documentclass | 16:9；默认 11pt；页面 16×9cm | 加 `12pt` 可整体放大字号，重新检查所有页 |
| style | academic；白底、暖红强调 | 改 warm 切换完整页面为暖红，改 cool 同时得到蓝色页眉／标题栏／页脚 |
| logo / footer | true／standard | false 关闭校徽；minimal 只保留页码，none 隐藏普通页脚 |
| sectionpage | true | section 自动插入章节页；false 后需要时手动 HUASsectionframe |
| language / faculty | zh／湖南文理学院 | en 切换固定标签；faculty 改简短机构名称，显示在普通页脚及章节／结束页 |
| local-assets | 默认透明校徽与建筑图 1 | 在 input 后加 HUASsetlogo／HUASsetbuilding 覆盖；空建筑路径关闭装饰 |
| title / subtitle | 封面主标题／副标题 | 替换文字，标题可用 `\\` 两行；空副标题用 `\subtitle{}` |
| author / institute / date | 封面作者／机构／日期 | 改花括号内文字；date 的 today 每次编译自动更新，可改固定日期 |

## 2. 逐页修改

| 物理页 | 当前效果与修改位置 | 操作方法 |
| --- | --- | --- |
| 1 封面 | 顶部校徽校名、左对齐标题、底部信息与建筑 | 修改导言区五项信息；title top 控制上方附加留白，subtitle gap 控制副标题间距，hero rule width 控制短线长度 |
| 2 章节 | section“研究背景与目标”生成；暖纸底与短线 | 改 section 文本；section rule width／gap 控制短线及到标题的距离；默认不计正文页码 |
| 3 普通内容 | frame 标题“研究背景”；宋体正文与圆点列表 | 改 frame 花括号内标题及 item 文本；添加 item 增加条目。加 `[t]` 让正文靠上，局部 small 缩小字号 |
| 4 双栏图片 | 左侧说明与列表，右侧图片或占位框 | 改两个 column 比例及 includegraphics 路径；下方 scriptsize 文字是图源说明，需一同修改 |
| 5 结束 | HUASclosingframe 的致谢、校训与建筑辅助区 | 固定致谢文字在 inner theme 的 HUAS closing page；校训在 config；hero rule width／closing rule gap 调整短线 |

## 3. 本模板的精确尺寸

默认左右正文边距各 1cm，正文宽 14cm。Academic 普通内容页 **没有章节页眉栏**；正文标题栏色块宽 16cm、padding 1.5mm，标题下细线长 14cm、厚 0.4pt。页脚色块宽 16cm，基线上方 2.5ex、下方 1.2ex，文字缩进与正文边距一致；总高度为二者之和。

封面顶部附加留白 3.6mm，校名文字区宽 10.08cm；封面校徽高度上限 8.2mm。主标题短线长 2.52cm、厚 1.5pt。章节顶部附加留白 6.3mm、短线长 1.12cm。完整页面底部附加留白 2.7mm；辅助区 padding 为 1.5mm，两栏各占框内当前行宽 47%，建筑高度上限 1.8cm。所有数值随页面比例、边距与局部环境变化的规则见共享手册。

双栏内容的左栏 `0.52\textwidth`=**7.28cm**，右栏 `0.43\textwidth`=**6.02cm**；剩余 0.70cm 为水平弹性空白。真实图片 `width=\linewidth` 等于右栏宽，按比例决定高度。占位框 parbox 的内部宽为右栏的 90%=5.418cm、高 2.8cm；外部边框另增加两侧 fboxsep 与 fboxrule，所以不是同一宽度。

具体修改示例放在导言区：

```tex
\HUASsetlayout{frametitle padding=2mm,
  footline height=3.5mm,footline depth=1.3mm,
  hero rule width=3cm,logo title height=9mm}
```

这是 4.8mm 总高度页脚、2mm 标题栏内边距和 3cm 封面短线。双栏比例仍在正文 column 参数中改，不受 hero column width 控制。图太高时在 includegraphics 同时加 `height=4cm,keepaspectratio`，保持比例且限制高度。
