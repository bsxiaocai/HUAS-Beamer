# Cool 蓝色完整模板操作说明

源码：`examples/cool-demo.tex`。编译：根目录执行 `./scripts/build.ps1 -Target cool`，输出 `build/cool/cool-demo.pdf`。默认 16 张页面、11 张正文计数页。全部尺寸及颜色机制见 [自主微调手册](../customization.md)。

## 1. 导言区操作

- `style=cool`：白底内容、蓝色标题栏、深蓝章节页眉和页脚，封面为居中蓝色标题块，章节／结束页为浅蓝灰底。
- `logo=true,footer=standard`：正文页脚显示校徽及“教学与学术交流”标签；minimal 仅显示页码；none 只隐藏页脚，Cool 页眉仍存在。
- `sectionpage=true`：三个 section 各生成一张章节页。faculty 改院系／活动简称，影响页脚及完整页面辅助标签；页眉右侧学校名称由 config 管理。
- 默认校徽与建筑由 local-assets 加载；替换图片命令放在 input 后。正文图片页有自己的建筑图 2 路径，不随 HUASsetbuilding 改变。
- `title`／`subtitle`／`author`／`institute`／`date` 控制封面五项信息；机构有 faculty 时不覆盖页脚标签。副标题设空可隐藏，日期可固定。

## 2. 逐页效果及修改位置

| 物理页 | 效果／组件 | 如何改 |
| --- | --- | --- |
| 1 封面 | 顶部学校信息，居中蓝色题名块，底部校训、校徽与建筑 | 改导言区信息；cool title padding 控制蓝框四周留白，cool subtitle gap 控制副标题距离 |
| 2 目录 | 三级主题结构 | 改 section 后编译两遍；移除 hideallsubsections 可显示已有小节 |
| 3 章节 | “研究与论证”，浅蓝灰底与短线 | 改 section 文字，section rule width／gap 改短线长度及距离 |
| 4 论证块 | block、alertblock、exampleblock | 各环境的参数改小标题，内部改正文；警告始终用红色语义，其他块跟随蓝色强调 |
| 5 引文 | 原文＋右下出处，下方作者讨论 | 改 HUASquotation 参数与内部原文；环境外文字是汇报者解释，不属于引文 |
| 6 研究流程 | 四步编号列表 | 改 item 文本；textbf 强调每步标题，局部 itemsep 改步间距 |
| 7 章节 | “文本与教学” | 改 section 文字；完整章节页不显示页眉页脚、不计正文数 |
| 8 双栏细读 | 左宋体诗句与出处，右问题块 | 改原文、出处、问题 item；column 比例改左右宽，quote padding 改的是框内留白 |
| 9 教学案例 | 学习目标与任务反馈两块 | 改两个块的标题与条目；块的高随内容增加，不是固定高度 |
| 10 表格 | 编号表题、三列四行 | caption 改题名，tabular 改内容；arraystretch=1.4 调行高，lll 调列对齐／宽度 |
| 11 图片 | 图 1、校园素材及来源，缺图时占位 | 同时改 IfFileExists 检测路径、includegraphics 路径与图源文字；图注两个分支分别修改 |
| 12 代码 | Python 原样短片段与中文解释 | 修改 verbatim 中代码；保持 fragile；局部 small 改代码大小，环境外改说明 |
| 13 章节 | “总结与资料” | 改 section 文字 |
| 14 重点 | 普通标题栏与黑体两行主句 | 改 HUASkeypoint 两参数；第二参数 `\\` 控制换行，命令写在 frame 外 |
| 15 文献 | 三条数字编号参考资料 | 增删 bibitem／newblock，键唯一；{9} 超过个位条目时改 {99} |
| 16 致谢 | 浅蓝灰底，双语致谢与校训建筑区 | 固定文字在 inner/config；hero rule width 与 closing rule gap 调短线和距离 |

## 3. 页眉、标题栏、页脚的长度与高度

默认 16×9cm、正文左右边距各 1cm、正文宽 14cm。普通内容页有 **三个不同色块**：

| 区域 | 默认宽／高 | 控制键与效果 |
| --- | --- | --- |
| 深蓝章节页眉 | 宽 16cm；基线上方 2.5ex，下方 1.2ex | headline width／height／depth；总高 3.7ex，左显示当前章节、右显示校名 |
| 蓝色正文标题栏 | 宽 16cm；padding 1.5mm，高度随标题变化 | frametitle width／padding；宽度不等于正文宽，不能把 1.5mm 当总高度 |
| 深蓝普通页脚 | 宽 16cm；基线上方 2.5ex，下方 1.2ex | footline width／height／depth；总高 3.7ex，内部机构／页码受 footer 配置控制 |

这三块的文字左右缩进跟随正文边距。标题栏无正文下分隔细线，frametitle rule 在 Cool 无效果。封面、章节、结束页使用 plain，不显示上述三栏；底部校训／建筑区属于 hero 辅助区。

精确毫米尺寸的修改放在导言区：

```tex
\HUASsetlayout{headline width=\paperwidth,
  headline height=3mm,headline depth=1.3mm,
  frametitle padding=2mm,
  footline width=\paperwidth,
  footline height=3.5mm,footline depth=1.3mm,
  cool title padding=0.8em}
```

页眉总高 **4.3mm**，页脚总高 **4.8mm**；标题栏上下各留 **2mm**。设 headline width=15cm 会缩窄深蓝色块且不自动居中，也不会把下面标题栏一起改短。若想三块都短，应分别改三个 width；同时检查右校名／机构是否被挤到下一行。标题栏位置由 Beamer 标题容器管理，缩窄后不保证与页眉同一左端，特别是左右边距不相等时；通常保持全宽、只改文字边距。不要用小于文字所需高度的 ht／dp，校徽上限默认 3.4mm。

## 4. 封面与内容尺寸

Cool 封面标题块宽 **14cm**，四周 padding **0.6em**；副标题间距 **0.4em**，作者／机构／日期在中间居中排列。标题块上方与下方的 vfill 都是弹性空间，不是固定坐标。title top 默认附加 **3.6mm**，hero bottom 附加 **2.7mm**；底部辅助区 padding **1.5mm**，两栏各占框内行宽 47%，校徽高度上限 **6.2mm**、建筑上限 **1.8cm**。章节顶部附加 **6.3mm**，短线长 **1.12cm**、厚 **1.5pt**。

第 8 页左右栏各 `0.48\textwidth`=**6.72cm**，剩余约 **0.56cm** 为水平弹性间隙；引文框宽跟随当前左栏 linewidth。第 11 页正文图宽 `0.65\textwidth`=**9.1cm**，高度等比；缺图占位框内部宽 `0.6\textwidth`=**8.4cm**、高 **2.2cm**，框外还要加边框与内距。这张正文图不受 building max height 控制。

表格行高系数 **1.4**，列宽由文字自然撑开，没写固定 cm；改 tabcolsep 控制单元格左右内距。代码使用局部 small，修改长行时手动拆分，不能删除 fragile。主句框默认 keypoint padding=1em，引文框默认 quotation padding=0.8em。

## 5. 调整蓝色、字号与固定文字

默认蓝／深蓝／浅蓝灰分别为 `3333B2`／`191959`／`E9E9F3`。先改色再刷新 setup：

```tex
\definecolor{HUASBlue}{HTML}{245A81}
\definecolor{HUASNavy}{HTML}{16364E}
\HUASsetup{style=cool}
\setbeamerfont{frametitle}{size=\Large}
\setbeamerfont{footline}{size=\scriptsize}
```

页眉与页脚文字共用 footline 字体；只增大正文标题使用 frametitle。主标题、章节标题、重点句默认黑体，正文和引文默认宋体。改变颜色令牌不会使建筑 PNG 自动变蓝。固定校名与校训在 config，结束页致谢在 inner；其余内容由这份示例自行修改。
