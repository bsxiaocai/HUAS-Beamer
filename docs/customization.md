# HUAS-Beamer 自主微调操作说明

本说明对应 Phase 6 源码。四份示例分别有逐页指南：[最小模板](templates/main.md)、[Academic 学术模板](templates/academic.md)、[Warm 研讨模板](templates/seminar.md)、[Cool 蓝色模板](templates/cool.md)。请先复制要使用的示例，再在导言区修改；根目录的五个主题文件和 theme 目录为共享实现。

如果尚未使用过 LaTeX，先读[零基础使用手册](user-manual.md)，其中解释编辑、保存、终端命令、完整文档与正文片段。项目整体完成情况见[五阶段开发总评](development-overview.md)。

## 1. 配置位置与编译

配置顺序如下。尺寸参数只在导言区设置，可分多次调用，后一次只覆盖指定项：

```tex
\documentclass[aspectratio=169]{ctexbeamer}
\usetheme{HUAS}
\HUASsetup{style=cool,logo=true,footer=standard,sectionpage=true}
\input{examples/local-assets.tex} % 可选：加载本地校徽和建筑图
\HUASsetlayout{
  text margin left=1cm,
  text margin right=1cm,
  headline width=\paperwidth,
  headline height=3mm,
  headline depth=1.3mm,
  frametitle padding=1.5mm,
  footline height=3.5mm,
  footline depth=1.3mm
}
% 此处再写 title、author 等信息，之后才 begin{document}。
```

上面的页眉色块总高度为 **4.3mm**，页脚为 **4.8mm**，不是默认值；正文标题栏没有固定总高度。若只想改一种尺寸，删除其他项即可。拼错键名会报 PGF 错误。尺寸不带单位、负尺寸或超出页面的尺寸可能报错或破坏布局，主题不自动修正。

在项目根目录执行 `./scripts/build.ps1 -Target main`／`academic`／`seminar`／`cool`；默认 all 编译四份。XeLaTeX 不在 PATH 时加 `-Engine '可执行文件完整路径'`。两遍编译用于更新目录、页数和引用。手动编译同样从根目录运行两遍：

```sh
xelatex -interaction=nonstopmode -halt-on-error -output-directory=build examples/cool-demo.tex
```

手动方式先创建 build，输出 `build/cool-demo.pdf`；脚本输出 `build/cool/cool-demo.pdf`。自建文件可手动编译，脚本 Target 只接受现有四种名字。

## 2. 页面尺寸与长度单位

默认 `aspectratio=169` 对应 Beamer **16cm×9cm** 的 PDF 页面；不是 PowerPoint 的 33.867cm×19.05cm。投影时按比例放大。默认左右边距均为 **1cm**，正文宽 `\textwidth` 为 **14cm**。改字体大小不会改变页面尺寸；改 aspectratio 后请重新核对所有页面，本项目当前只验证 16:9。

| 写法 | 具体含义 | 何时用 |
| --- | --- | --- |
| `1cm`／`3mm`／`1pt` | 绝对长度；1cm=10mm，TeX 的 1pt≈0.35146mm | 希望明确某处物理尺寸 |
| `\paperwidth`／`\paperheight` | 整张页面宽／高，默认 16cm／9cm | 页眉页脚全宽、按页面比例留白 |
| `\textwidth` | 去除左右边距后的正文宽，默认 14cm | 标题短线、完整内容框 |
| `\linewidth` | 当前环境的行宽；双栏中是该栏宽 | 栏内图片、引文框 |
| `em` | 当前字体字号对应的排版宽度单位 | 随字号变化的间距 |
| `ex` | 当前字体的 x 高度，不等于字号或固定 mm | 页眉页脚的相对高度 |

`em/ex` 在具体使用处求值。页眉、页脚先建立 colorbox 再选择内部文字字体，所以修改 `footline` 字体不保证 ex 尺寸按同一字体同比变化；希望精确控制时用 mm。`\vfill` 分配剩余垂直空间，不能换算为固定高度。封面顶部的参数是“附加留白”，不是标题到纸张上沿的最终坐标。

## 3. 页眉、正文标题栏、页脚和正文边距

修改入口为 `\HUASsetlayout{键=值}`；默认值集中在 `theme/huas-layout.tex`，实际使用位置在 `beamerouterthemeHUAS.sty`。

| 键／对象 | 默认值 | 效果与修改方法 |
| --- | --- | --- |
| `text margin left` | Beamer 默认 1cm | 正文左边距；页眉、标题栏和页脚的文字左缩进同步变化。设 `12mm` 向右收窄正文 |
| `text margin right` | Beamer 默认 1cm | 正文右边距及各栏文字右缩进；正文宽=纸宽−左右边距 |
| `headline width` | `\paperwidth`，16cm | **仅 Cool** 顶部深蓝章节提示栏的色块宽度；设 `15cm` 缩窄，原左端锚点保持不变，不自动居中 |
| `headline height` | `2.5ex` | 页眉文字基线上方高度；设 `3mm` 得到明确的上半部高度 |
| `headline depth` | `1.2ex` | 页眉基线下方深度；总高度为 height+depth；设 `1.3mm` 增加下方空间 |
| `frametitle width` | `\paperwidth`，16cm | 正文标题栏色块宽度，所有模式有效；缩窄不会同步缩窄下方正文，水平位置还受 Beamer 标题框和左右边距影响 |
| `frametitle padding` | `0.15cm`，1.5mm | 标题栏四周内边距；增大时标题栏更厚，左右有效标题宽也变小 |
| `frametitle rule` | `0.4pt`，约 0.141mm | Academic/Warm 普通内容页标题下细线厚度；线长仍为正文宽。设 `0pt` 隐藏；Cool 不显示此线 |
| `footline width` | `\paperwidth`，16cm | 页脚色块宽度，不控制页数格式；缩窄后机构与页码仍共用此框 |
| `footline height` | `2.5ex` | 页脚基线上方高度；校徽较大时需要一起增加 |
| `footline depth` | `1.2ex` | 页脚基线下方深度；与 height 合成色块总高度 |

**正文标题栏总高度**由标题行数、字体 strut 高度／深度、段落行距和上下 padding 共同决定。不能把 padding 当作总高度，也不能给多行标题写死单行高度。标题一行的近似关系是“该行排版高度＋2×padding”，实际以 PDF 为准。

所有栏的宽度不宜超过 `\paperwidth`，也要足够容纳左右缩进与文字；缩窄色块后出现换行，要减小字号／缩短文字，或恢复全宽。标题栏由 Beamer 的 frame 标题容器放置，缩窄后不保证与页眉／页脚具有相同左端位置，非对称边距下更需检查；通常保留三栏全宽，只调文字边距即可。增高页眉页脚会减少正文可用高度。普通 `frame` 默认垂直居中，可改 `\begin{frame}[t]{标题}` 让正文靠上；不要用负间距掩盖内容过多的问题。

`footer=standard` 显示机构、页码和可选校徽；`minimal` 只显示页码；`none` 隐藏页脚，**不会隐藏 Cool 页眉**。封面、章节、结束页的完整页面命令使用 plain，不显示这些栏，也不计入正文页码。当前标题栏不输出 `\framesubtitle`；需要第二层文字时写入正文或自行扩展模板。

## 4. 封面、章节和结束页的全部布局参数

实际模板位于 `beamerinnerthemeHUAS.sty`。Academic/Warm 共享左对齐封面，Cool 使用居中标题块。完整页面底部辅助区不是普通页脚。

| 键 | 默认值及默认 16:9 下的换算 | 效果／适用位置 |
| --- | --- | --- |
| `title top` | `0.04\paperheight`，3.6mm | 三种封面顶部附加留白；增大使内容分配区域缩小 |
| `divider top` | `0.07\paperheight`，6.3mm | 章节／结束页顶部附加留白 |
| `hero bottom` | `0.03\paperheight`，2.7mm | 三类完整页面底部附加留白 |
| `identity width` | `0.72\textwidth`，10.08cm | Academic/Warm 顶部校名文字区；过小会使英文校名换行 |
| `subtitle gap` | `0.6em` | Academic/Warm 主标题与副标题的额外竖向间距 |
| `title rule gap` | `1.2em` | Academic/Warm 副标题后的短线前间距 |
| `hero rule width` | `0.18\textwidth`，2.52cm | Academic/Warm 封面、全部结束页短线长度；Cool 封面不使用短线 |
| `hero rule thickness` | `1.5pt`，约 0.527mm | 封面、章节、结束页短线厚度，不控制正文标题下细线 |
| `section rule width` | `0.08\textwidth`，1.12cm | 章节页短线长度 |
| `section rule gap` | `1em` | 章节短线到章节标题的额外间距 |
| `closing subtitle gap` | `0.5em` | 中文“谢谢聆听”到英文 Thank you 的间距；en 模式不显示第二行英文 |
| `closing rule gap` | `1em` | 结束页致谢文字到短线的间距 |
| `cool title padding` | `0.6em` | Cool 封面蓝色标题块四周内边距；标题块宽固定为正文宽 |
| `cool subtitle gap` | `0.4em` | Cool 封面主标题到副标题的额外间距 |
| `hero padding` | `0.15cm`，1.5mm | 完整页面底部辅助区四周内边距；框宽为正文宽，增大时框内可用宽减少 |
| `hero column width` | `0.47\linewidth` | 辅助区左右两栏分别占框内当前行宽的 47%；剩余空间由 hfill 分配。不要超过 `0.5\linewidth` |

示例：拉长封面短线、扩大辅助区内边距，保持页面其他部分不变：

```tex
\HUASsetlayout{hero rule width=3cm,hero padding=2mm}
```

微调绝对对齐时，源码仍有三组就地对齐常量：Academic 顶部校徽 `\raisebox{-0.12cm}`（下移 1.2mm）与 `\hspace{0.8em}`（校徽到校名）；Warm 辅助区校徽 `\raisebox{-0.15cm}`（下移 1.5mm）与 `\hspace{0.4em}`（校徽到作者）；标准页脚校徽前 `\hspace{0.5em}`。这些已加注释，若只需极细的基线校正，在 inner／outer 对应位置调整即可。正的 raisebox 值上移，负值下移。

标题、作者信息、图片尺寸变化都会改变辅助区实际高度，vfill 会重新分配留白。当前没有独立“封面标题 y 坐标”参数。需要标题换行时可在 `\title{第一行\\第二行}` 中显式断行，优先控制在两行内。

## 5. 校徽与建筑图片

| 键／对象 | 默认值 | 效果与操作 |
| --- | --- | --- |
| `logo max width` | `0.15\textwidth` | 所有校徽宽度上限；整页上下文为 2.1cm，辅助区 minipage 内按该栏 textwidth 求值 |
| `logo title height` | `0.82cm`，8.2mm | Academic 封面左上校徽高度上限 |
| `logo panel height` | `0.62cm`，6.2mm | Warm 封面浅色信息区／Cool 封面底部校徽高度上限 |
| `logo footer height` | `0.34cm`，3.4mm | standard 页脚校徽高度上限；minimal 不显示校徽 |
| `building max height` | `0.20\paperheight`，1.8cm | 辅助区建筑高度上限；宽度上限为辅助区右栏 linewidth |

图片实际尺寸是同时满足宽高上限的等比例结果，不是强制同时取这两个值；**不会拉伸、裁切、补线或自动改色**。建筑较宽时通常先达到宽度上限，因此只增大 height 可能看不出变化；要同时调整 hero column width，但两栏总宽不能超过框内行宽。正文里的图片另按各示例的 includegraphics 设置，不受 building max height 控制。

在 `\input{examples/local-assets.tex}` **之后**覆盖图片，否则会被默认加载器覆盖：

```tex
\HUASsetlogo{assets/research/HUAS-School_badge-transparent-imagegen-v2.png}
\HUASsetbuilding{assets/research/HUAS_building_2_bgcolor.png}
\HUASsetlayout{logo title height=9mm,building max height=16mm}
```

像素版名为 `HUAS-School_badge-transparent.png`，生成式版本为 imagegen-v1／v2。关闭校徽用 `\HUASsetup{logo=false}`；关闭建筑用 `\HUASsetbuilding{}`。缺失图片会警告并跳过，未设置素材时建筑区留空。建筑颜色需要更清晰时，只在原素材上改色另存再加载，不自行绘制建筑。图片文件仍只保存在本地忽略目录。

## 6. 字体、字号、颜色和固定文字

所有字体角色在 `beamerfontthemeHUAS.sty`。默认类字号为 11pt；表中的字号命令会跟随 documentclass 的 10pt／11pt／12pt 选项变化，不把它们视为固定 mm。

默认 11pt 类字号下，normalsize=10.95pt、small=10pt、scriptsize=8pt、large=12pt、Large=14.4pt、LARGE=17.28pt（按本机 LaTeX size11 定义）。字体字面可见高度不等于字号；需要固定尺寸时按下面 fontsize 示例设置。

| 字体角色 | 默认字号／字体 | 屏幕上的位置 |
| --- | --- | --- |
| `title` | LARGE、黑体、粗体 | 主封面标题 |
| `subtitle` | normalsize、宋体、常规 | 副标题及结束页第二行英文 |
| `section title` / `HUAS closing title` / `HUAS key point` | LARGE、黑体、粗体 | 章节标题／致谢／重点页主句 |
| `frametitle` | large、黑体、粗体 | 普通内容页标题栏 |
| `normal text` / `block body` | normalsize、宋体 | 正文与内容块正文 |
| `block title` | normalsize、黑体、粗体 | 普通、警告、示例内容块标题；后两者继承该角色 |
| `quote` / `quotation` | normalsize、正体 | 原生引文与 HUASquotation 文本 |
| `HUAS school name` | normalsize、黑体、粗体 | 封面中文校名 |
| `HUAS english name` | scriptsize | 封面英文校名 |
| `HUAS title meta` | small | 作者、机构、日期 |
| `HUAS section label` | small | 章节／结束页顶部校名 |
| `HUAS motto` / `HUAS source` | scriptsize | 校训／引文出处与图片来源 |
| `footline` | scriptsize、黑体 | 普通页脚及 Cool 页眉文字 |
| `caption` / `caption name` | small／粗体 | 图表说明／“图、表”标签 |
| `bibliography entry author` / `bibliography entry title` | small | 参考文献作者与题名 |
| `bibliography entry location` / `bibliography entry note` | scriptsize | 参考文献出版项与注记 |

导言区加载主题后可只改一个角色的字号，保留原字体和颜色：

```tex
\setbeamerfont{frametitle}{size=\Large}
\setbeamerfont{normal text}{size=\large}
% 需要固定字号时：18pt 字号、22pt 行距。
\setbeamerfont{title}{size=\fontsize{18pt}{22pt}\selectfont}
\setbeamerfont{quotation}{size=\large}
```

页脚与 Cool 页眉共享 footline 字体；增大它时一起检查二者高度。引文出处仍独立使用 HUAS source。单页局部改字号用 `{\small ...}`，列表可在当前列表中设 `\setlength{\itemsep}{0.4em}`，不会改变其他页。表格或代码里显式 small 优先于全局正文角色。

正文宋体由 ctex 的 CJK 主字体控制。标题使用项目黑体命令，Windows 默认 SimHei，AutoFakeBold=2；要改模拟加粗程度，在 font theme 带注释的位置调该数字。主题加载后 `\setCJKmainfont{SimSun}[BoldFont=SimHei]` 可选正文主字体；需要替换标题字体时自建一个 CJK 字体命令，再赋给 title／frametitle／section title 等角色的 family。不要仅改 CJK sans 字体并预期所有标题跟随，因为标题已显式选择黑体。

颜色令牌在 `beamercolorthemeHUAS.sty`：

| 令牌 | 默认 HTML 色值 | 作用 |
| --- | --- | --- |
| `HUASRed` | A34A42 | Academic/Warm 正文强调、Warm 完整页背景、警告语义 |
| `HUASTerracotta` | B76F4F | 预留陶土色，当前不自动改变建筑图片 |
| `HUASInk` / `HUASMuted` | 292929 / 666666 | 主要正文／辅助文字 |
| `HUASPaper` / `HUASWarmPaper` | FFFFFF / F8F4EF | 内容纸色／Academic 章节与辅助区底色 |
| `HUASLine` | E5DDD8 | Academic/Warm 正文标题下细线 |
| `HUASBlue` / `HUASNavy` / `HUASCoolPaper` | 3333B2 / 191959 / E9E9F3 | Cool 强调／页眉页脚及章节标题／浅色底 |

改令牌后再调用 setup 刷新派生强调色，例如：

```tex
\definecolor{HUASBlue}{HTML}{245A81}
\definecolor{HUASNavy}{HTML}{16364E}
\HUASsetup{style=cool}
```

普通 block 正文底色为强调色 `!8`，引文／重点框 `!6`，example 标题 `!18`、正文 `!4`，alert 正文为红色 `!6`；这些百分比在 color theme 内调整。仅修改正文标题颜色可在最后写 `\setbeamercolor{frametitle}{fg=white,bg=HUASBlue}`。完整页面命令会在局部应用模式色，因此单纯覆盖 HUAS hero 角色不保证在封面生效，应改令牌或对应模式函数。

固定中文校名、英文校名、校训与页脚机构逻辑在 `theme/huas-config.tex` 的 schoolname、schoolsecondary、motto、footerlabel 处；修改时保留 zh/en 条件。作者、机构、日期修改示例里的 `\author`、`\institute`、`\date`；faculty 非空时覆盖页脚机构标签。结束页“谢谢聆听／Thank you”在 inner theme 的 HUAS closing page 模板中。`language=en` 只切换固定标签，不翻译正文。

## 7. 内容组件与微调位置

| 对象 | 默认行为／尺寸 | 如何修改与实际效果 |
| --- | --- | --- |
| `HUASquotation` | 框宽为当前 linewidth，padding=0.8em，出处前 medskip、右对齐 | `quotation padding=1em` 增加四周留白；出处字体用 HUAS source。medskip 是 LaTeX 弹性中等间距，可在 huas-content 中替换为固定 vspace |
| `HUASkeypoint` | 独立普通 frame，框宽为 textwidth，padding=1em | `keypoint padding=1.2em` 增加留白；主句字体用 HUAS key point。必须在 frame 外调用，正文显式 `\\` 控制换行 |
| 原生 `block`／`alertblock`／`exampleblock` | 宽度跟随当前栏；高度由标题、正文、列表决定；标题／正文色块默认 colsep*=0.75ex | 改内容、block title/body 字体和颜色；原生块内距可按下方模板选项调，不受 quotation padding 控制 |
| `columns[T,onlytextwidth]` | 顶部对齐、总体宽度为正文宽 | 改每个 column 的比例；比例总和小于等于 1。不用减少字号就能控制图文分配 |
| `figure`／`table` 图注 | 自动“图／表＋编号”，small；前后间距默认各 7pt（约 2.46mm） | 改 caption 文本；字体改 caption；图注前后距离可在导言区设 `\setlength{\abovecaptionskip}{4pt}`、`\setlength{\belowcaptionskip}{2pt}` |
| 表格 | academic arraystretch=1.5，cool=1.4；lll 三列左对齐 | 增大 arraystretch 增加行高；当前表内设 `\setlength{\tabcolsep}{8pt}` 改列间内距；长文列改 `p{4cm}` 并保证总宽不超正文 |
| 代码 | fragile frame＋verbatim，局部 small，原样显示 | 只改代码文字或局部字号；长行手动拆分。不能把 verbatim 放进普通命令参数，也不自动高亮或折行 |
| 参考文献 | 手工 thebibliography，数字编号 | 添加唯一 bibitem 键与文字，正文可 cite；第二遍更新引用。换数字字体／颜色用 bibliography 相应角色，不是自动文献后端 |
| 目录／章节 | TOC 隐藏小节，sectionpage=true 自动插入章节页 | 添加 section 后编译两遍；false 后可手动 HUASsectionframe，但不要自动手动重复调用 |

原生内容块不用重写源码也能调整色块内距。下面是 Beamer default 模板的选项，放在导言区加载 HUAS 之后，分别作用于三种块；增大 colsep 会增加彩色区域边缘留白，块高可能随之增加：

```tex
\setbeamertemplate{block begin}[default][colsep*=1ex]
\setbeamertemplate{block alerted begin}[default][colsep*=1ex]
\setbeamertemplate{block example begin}[default][colsep*=1ex]
```

默认块前为 medskipamount、块后为 smallskipamount；有背景色时标题／正文连接处有 -0.5pt 补偿，正文开头有 -0.75ex 补偿。这些由 Beamer 管理，与 colsep 并非同一个参数。确需调整它们时在文档中重定义对应 block begin／end 模板，不直接修改 TeX Live 安装文件。占位图的 fbox 默认内距 fboxsep=3pt、线厚 fboxrule=0.4pt；可在占位分支中用 setlength 局部修改，不影响真实图片。

## 8. 修改后的检查

每次先改一处并编译两遍，检查 PDF 中的长标题、正文、图片、页脚和目录。日志出现 Overfull 通常表示文字或图片太宽／太高；先检查边距、栏宽、长代码和校徽高度。可用 `footer=none` 验证正文是否被页脚挤压，但最终请按自己的配置检查。建筑来源与线条不变，校徽版本均保留，不把研究素材和编译产物加入 Git。
