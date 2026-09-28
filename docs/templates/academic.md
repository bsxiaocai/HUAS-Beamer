# Academic 学术汇报模板操作说明

源码：`examples/academic-demo.tex`。编译：根目录执行 `./scripts/build.ps1 -Target academic`，输出 `build/academic/academic-demo.pdf`。默认 10 张页面、6 张正文计数页。全部共享设置见 [自主微调手册](../customization.md)。

## 1. 导言区操作

- `style=academic`：完整封面白底，章节／结束页暖纸底；正文白底暖红强调。换成 cool 后才显示蓝色章节页眉。
- `logo=true`：显示可选校徽；未指定 footer 时默认 standard，机构、页码与校徽同处页脚。设 `footer=minimal` 只保留页码，设 none 隐藏。
- `sectionpage=true`：两个 section 自动生成两张章节页。faculty“学术交流”控制页脚机构文字和章节／结束页辅助标签；可改为院系简称。
- `\input{examples/local-assets.tex}`：可选图片。替换校徽或建筑的命令写在它之后，微调尺寸也放在导言区。
- `\title`、`\subtitle`、`\author`、`\institute`、`\date`：分别为主标题、副标题、作者、封面机构与日期。institute 不会覆盖非空 faculty 的页脚标签。日期可固定，长主标题用 `\\` 手动换行。

## 2. 逐页效果与改法

| 物理页 | 效果／位置 | 具体操作 |
| --- | --- | --- |
| 1 封面 | 校徽、校名、题名和汇报信息 | 改五项导言区信息及素材；title top／subtitle gap／hero rule width 分别改上方附加留白、副标题间距、短线长度 |
| 2 目录 | 自动列出“问题与方法、分析与讨论” | 增删 section 后编译两遍；移除 hideallsubsections 才显示已添加的 subsection |
| 3 章节 | 第一个 section，暖纸底与章节标题 | 改 section 文本；section rule width／gap 调线长和间距 |
| 4 研究问题 | 一个 block 与三个圆点条目 | block 的参数改小标题，环境内改描述；每个 item 改研究问题、材料或边界 |
| 5 方法与公式 | 三步 enumerate、说明与显示公式 | 增删 item；修改 fraction 的分子、分母及下标文字，同时改下面符号解释。`\mathrm` 使英文下标直立 |
| 6 章节 | 第二个 section | 改 section 文本；自动章节页不要再手工插入 |
| 7 分析框架 | 编号表格与 alertblock | caption 改表题，tabular 改行；alertblock 改适用范围。红色警告底由 color theme 控制 |
| 8 关键结论 | HUASkeypoint 的页标题＋两行主句 | 第一参数改页标题，第二参数改结论，`\\` 断行；必须在 frame 外调用，计入页码 |
| 9 参考资料 | 数字编号的手工参考文献 | 增删 bibitem，键保持唯一；newblock 分段。正文加 cite 后两遍编译，超过 9 条把编号样本 `{9}` 改 `{99}` |
| 10 致谢 | 双语致谢、校训与建筑 | 字样在 inner/config 中修改；hero rule width／closing rule gap 改短线与距离 |

正文默认垂直居中；将某页改成 `\begin{frame}[t]{标题}` 可顶部对齐。字号与边距会影响文字换行，不要在表格过长时依赖 shrink 缩成不可读小字。

## 3. 宽高、表格与字体

默认页宽 16cm、高 9cm；正文左右各留 1cm，宽 **14cm**。无章节页眉，正文标题栏宽 16cm、四周 padding **1.5mm**；总高度由字体、行数及 padding 共同决定。下细线长 14cm、厚 **0.4pt**。standard 页脚宽 16cm、height=2.5ex、depth=1.2ex；校徽高度上限 3.4mm，放大校徽要同步检查页脚高度。

封面校名文字区宽 **10.08cm**、校徽高度上限 **8.2mm**；封面／结束页短线 **2.52cm×1.5pt**，章节短线 **1.12cm×1.5pt**。辅助区宽为正文宽，padding 1.5mm，左右栏各占框内行宽 47%；图片按右栏宽和 1.8cm 高两个上限等比缩放。

表格 `lll` 是三个自然宽左对齐列，**没有固定总宽度**；单元格文字、tabcolsep 和字体共同决定宽度。`arraystretch=1.5` 为行高系数，不是 1.5cm。在 table 内设置 `\setlength{\tabcolsep}{8pt}`，每个单元格左右内距为 8pt；相邻列的文字间距通常叠加为 16pt。长文字可以把列改成 `p{3cm}`，其内容宽为 3cm，但总宽还包括各列内距与线条。行间 `\\` 结束一行，hline 添加横线。

论文式细调示例（导言区）：

```tex
\HUASsetlayout{text margin left=12mm,text margin right=12mm,
  frametitle padding=2mm,frametitle rule=0.6pt,
  hero rule width=3cm,keypoint padding=1.2em}
\setbeamerfont{frametitle}{size=\Large}
\setbeamerfont{caption}{size=\small}
```

此时正文宽缩为 **13.6cm**，正文标题下细线跟随缩短，主句框内距增大。标题变大后可能占两行并挤压正文。封面标题／章节标题／重点句默认 LARGE 黑体；正文和公式解释是宋体；不改变颜色时只写字号参数即可。
