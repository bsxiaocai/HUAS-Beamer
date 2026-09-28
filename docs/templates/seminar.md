# Warm 读书研讨模板操作说明

源码：`examples/seminar-demo.tex`。编译：根目录执行 `./scripts/build.ps1 -Target seminar`，输出 `build/seminar/seminar-demo.pdf`。默认 9 张页面、5 张正文计数页。共享参数表见 [自主微调手册](../customization.md)。

## 1. 导言区操作

| 项目 | 当前效果 | 修改方法 |
| --- | --- | --- |
| `style=warm` | 封面、章节、结束页暖红底白字；正文仍白底 | academic 得到浅色完整页面；cool 还增加蓝色正文页眉与标题栏 |
| `logo=true` | 封面红校徽在浅色信息区 | false 关闭；替换版本用 HUASsetlogo，放在 local-assets 的 input 之后 |
| `footer=minimal` | 普通页脚只显示“当前／总计” | standard 增加机构与可选校徽；none 不显示页脚 |
| `sectionpage=true` | 两个 section 自动插入章节页 | false 关闭自动，正文 section 结构仍存在 |
| `faculty` | “读书分享与研讨”出现在章节／结束页辅助区 | 改为院系或活动名称；minimal 页脚不会显示它 |
| 五项封面信息 | title／subtitle／author／institute／date | 逐项改文字；固定日期替换 today；空 subtitle 隐藏副标题 |

## 2. 逐页修改

| 物理页 | 当前效果与位置 | 如何改 |
| --- | --- | --- |
| 1 封面 | 黑体白标题、宋体副标题，浅色区有作者、校徽和建筑 | 改导言区信息；subtitle gap 改标题间距；logo panel height 改校徽上限，不是 logo title height |
| 2 目录 | 两项研讨结构 | 改 section 后编译两遍；隐藏小节选项可删 |
| 3 章节 | “阅读与细读”，暖红底白字 | 改 section 标题；section rule width／gap 改白短线 |
| 4 原文与提问 | 引文框、右下出处、下方三个问题 | 改 HUASquotation 花括号内出处和环境内原文；问题改 item；quotation padding 改引文框内边距 |
| 5 双栏细读 | 左栏语词列表、右栏解释 | 改两栏 block 标题和正文；左右 column 比例分别控制栏宽，T 保证顶部对齐 |
| 6 章节 | “交流与反思” | 改 section 文本，沿用自动章节页 |
| 7 研讨流程 | 三步 enumerate＋红色警告块 | 改讨论步骤与边界；增加 item 时检查高度，局部 itemsep 可调步骤间距 |
| 8 反思重点 | 两行黑体重点句，浅色正文页 | 改 HUASkeypoint 两参数；keypoint padding 控制框内距，HUAS key point 控制字号 |
| 9 致谢 | 暖红底白色致谢、浅色校训建筑区 | 固定致谢在 inner、校训在 config；closing subtitle gap／rule gap 改结束页间距 |

## 3. 具体尺寸与改法

默认 16×9cm，左右正文边距各 1cm。此模板 **无顶部章节页眉**；普通标题栏宽 16cm、内边距 1.5mm，下面细线长 14cm、厚 0.4pt。minimal 页脚宽 16cm、基线上方 2.5ex／下方 1.2ex；虽然显示内容少，默认高度与 standard 相同。

Warm 封面的主标题与副标题额外距离为 **0.6em**，副标题到短线为 **1.2em**，短线长 **2.52cm**、厚 **1.5pt**。顶部附加留白 **3.6mm**，章节／结束页顶部附加留白 **6.3mm**，完整页面底部附加留白 **2.7mm**。浅色辅助区 padding **1.5mm**，每栏占框内行宽 **47%**；校徽高最多 **6.2mm**，建筑图最多 **1.8cm** 高，也受右栏宽限制。

双栏各为 `0.47\textwidth`，默认各 **6.58cm**，剩余 **0.84cm** 是水平弹性空白。把两者改成 `0.43\textwidth` 和 `0.53\textwidth` 可给解释栏更多空间；比例之和不得超过 1。原生 block 高度由内容决定，并非与另一栏自动等高。

引文框宽为当页当前行宽，默认为 **14cm**；内边距 **0.8em**，出处前是 medskip，出处字号 scriptsize。改 padding 增加四周留白但减少框内文字宽度；原文长时自然换行，也可用 `\\` 明确断句。HUASquotation 与原生 block 的内距是分别控制的。

可直接使用的导言区修改：

```tex
\HUASsetlayout{subtitle gap=0.8em,section rule width=2cm,
  quotation padding=1em,logo panel height=7mm,
  closing subtitle gap=0.8em,closing rule gap=1.2em}
\setbeamerfont{quotation}{size=\large}
```

这样章节短线变长、引文留白和字号增加、封面校徽更大；主标题位置仍受 vfill 弹性留白与内容高度共同影响。Warm 背景用 HUASRed，浅色辅助区用 HUASPaper；不建议将透明红校徽移回红色背景，当前浅色区为其提供对比。
