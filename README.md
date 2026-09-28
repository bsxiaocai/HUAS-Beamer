# HUAS-Beamer

湖南文理学院主题的 LaTeX Beamer 项目。目前完成 Phase 5 的示例与构建流程，并提供 Academic Light、HUAS Warm 和蓝色 Cool 三套样式。

## 编译

需要安装包含 `ctexbeamer` 的 TeX Live，并使用 XeLaTeX。在项目根目录运行（先创建 `build/`）：

```sh
mkdir build
xelatex -output-directory=build main.tex
xelatex -output-directory=build main.tex
```

若 Windows 终端找不到 `xelatex`，请将 TeX Live 的 `bin/windows` 目录加入 PATH。

输出文件为 `build/main.pdf`。编辑 `main.tex` 中的标题、作者和页面内容即可开始使用。`\usetheme{HUAS}` 加载主题入口，四个 `beamer*themeHUAS.sty` 分别管理颜色、字体、内层和外层样式；`theme/` 存放配置、素材加载与内容接口。

PowerShell 可运行 `./scripts/build.ps1`，连续编译全部四份示例两遍。可用 `-Target academic`、`seminar`、`cool` 或 `main` 只编译一份；找不到 XeLaTeX 时用 `-Engine '完整的 xelatex 可执行文件路径'` 指定。脚本从任意工作目录运行均以项目根目录编译，失败时停止，日志与 PDF 位于 `build/<Target>/`。

| 示例 | 场景 | 脚本输出 |
| --- | --- | --- |
| `main.tex` | 五页最小视觉示例 | `build/main/main.pdf` |
| `examples/academic-demo.tex` | Academic 学术汇报、方法、公式与表格 | `build/academic/academic-demo.pdf` |
| `examples/seminar-demo.tex` | Warm 读书分享、文本细读与研讨 | `build/seminar/seminar-demo.pdf` |
| `examples/cool-demo.tex` | Cool 完整内容组件 | `build/cool/cool-demo.pdf` |

## 中文字体

标题、章节标题、内容块标题和页脚使用黑体；正文、副标题、引文与图注使用宋体。Windows 默认由 ctex 选择 SimSun，标题优先使用 SimHei；黑体没有原生粗体，标题采用轻度模拟加粗。没有 SimHei 时沿用 ctex 的黑体族，不分发或下载系统字体。引文使用正体，保持中文标点与中英文混排的默认 ctex 行为。

Linux／Overleaf 可在文档类中指定 `fontset=fandol`，使用 TeX Live 自带字体；这一配置不等于已在对应平台验证。需要自定义字体时，在加载主题后设置 ctex 字体及相应 `\setbeamerfont`，不修改主题源码。

## 当前接口

在导言区加载主题后配置，无需修改主题源码：

```tex
\usetheme{HUAS}
\HUASsetup{style=warm,logo=true,footer=standard,
  sectionpage=true,language=zh,faculty={湖南文理学院}}
\HUASsetlogo{assets/logo/my-logo.png}
\HUASsetbuilding{assets/lineart/my-building.png}
```

图片路径请换为实际存在的文件；不需要图片时省略对应命令。

| 配置项 | 可选值 | 默认值与作用 |
| --- | --- | --- |
| `style` | `academic` / `warm` / `cool` | 默认 `academic`；`warm` 控制封面、章节与结束页；`cool` 同时采用蓝色标题栏、章节提示和页脚。正文均为浅色 |
| `logo` | `true` / `false` | `false`；控制标题页与标准页脚中的 Logo |
| `footer` | `standard` / `minimal` / `none` | `standard` 显示机构、页码及可选 Logo；`minimal` 只显示页码；`none` 关闭 |
| `sectionpage` | `true` / `false` | `false`；是否在普通 `\section` 后自动插入章节页 |
| `language` | `zh` / `en` | `zh`；切换主题的固定身份与致谢文字，不翻译用户的标题、正文、机构或日期 |
| `faculty` | 简短文字，含逗号时用花括号包围 | 空；设置章节／结束页的院系文字及标准页脚标签，空值时页脚使用 `\institute` 的短名称 |

`\HUASsetup` 只用于导言区，可以分多次调用；后一次指定的配置覆盖前一次，其余配置保留。旧的 `footer`、`nofooter`、`logo`、`nologo` 主题选项继续有效，后续 `\HUASsetup` 优先。

在正文使用完整页面命令，让主题自动设置局部背景并排除这些页面的页码：

```tex
\HUASmaketitle
\section{研究背景} % sectionpage=true 时自动生成章节页
\begin{frame}{研究目标}
  正文内容
\end{frame}
\HUASclosingframe
```

`sectionpage=false` 时可用 `\HUASsectionframe` 手动生成章节页；启用自动章节页后不要再手动重复插入。星号章节和 frame 内部的章节不触发自动页面；自定义 `\AtBeginSection` 会替换主题的章节钩子。普通 Beamer `\titlepage`、`\sectionpage` 与 `\HUASclosingpage` 仍可在自建 frame 中使用浅色模板；暖色背景由完整页面命令设置，`cool` 也影响普通内容页。双栏图片页仍使用 Beamer 原生 `columns`。

`\HUASsetlogo` 与 `\HUASsetbuilding` 放在导言区。缺失 Logo 或建筑图会警告并跳过；`\HUASsetbuilding{}` 关闭建筑图。主题只使用提供的图片，不绘制或补充建筑线条。建筑图按比例缩放，保留原颜色和透明度；暖色页面将它置于浅色辅助区以保持对比度。需要调整建筑颜色时，以原素材另存颜色版本，再通过该接口加载。

## 冷色样式与内容组件

冷色版以本地教学 PDF 的蓝色标题栏、深蓝章节提示、居中封面和浅色内容块为参考，适配 16:9；不包含原 PDF 的个人信息、正文或页面截图。只需设置 `\HUASsetup{style=cool}`。完整示例为 `examples/cool-demo.tex`，在项目根目录编译两遍：

```sh
xelatex -output-directory=build examples/cool-demo.tex
xelatex -output-directory=build examples/cool-demo.tex
```

输出为 `build/cool-demo.pdf`。主题为原生 `block`、`alertblock`、`exampleblock`、`quote`、`quotation`、`figure` / `table` 图注和 `thebibliography` 提供样式；研究流程、文学阅读和教学案例通过原生列表与双栏组合。带出处的引文和重点页可写：

```tex
\begin{HUASquotation}{作者与出处}
  引文内容
\end{HUASquotation}
\HUASkeypoint{关键结论}{一句清晰的核心判断。}
```

`\HUASkeypoint` 在 frame 外使用，生成计入页码的内容页。代码示例使用 `[fragile]` frame 与原生 `verbatim`，保留代码原样但不提供语法高亮或自动折行；短 ASCII 代码与中文解释分别排版。参考文献使用原生环境，本阶段没有引入 BibLaTeX / Biber。

## 项目状态与素材

示例通过 `examples/local-assets.tex` 条件加载透明校徽 `HUAS-School_badge-transparent.png` 和用户建筑图 `HUAS_building_1_bgcolor.png`；`main.tex` 与 Cool 内容页另使用第二张建筑图。`assets/research/` 被 Git 忽略，图片不随仓库分发；缺失时使用文字校名，装饰建筑区留空，正文图片使用占位框。素材目录说明见 `assets/README.md`。`examples/references/` 存放第三方参考项目，版本和许可线索见 `examples/README.md`。开发总纲及阶段总结位于 `docs/`。当前调色板属于 **HUAS-Beamer Derived Design System**，不代表学校官方视觉标准。

默认透明校徽由原 JPG 按像素去白得到，保留原分辨率及 RGB，白色负空间变为透明。处理脚本 `scripts/extract-badge.py` 需要 Python 和 Pillow，仅用于素材准备，编译不依赖 Python。它拒绝覆盖已有输出；通常直接使用已处理的本地 PNG 即可。原 JPG 保留，两份生成式候选另存为 `HUAS-School_badge-transparent-imagegen-v1.png`／`v2.png`，可通过 `\HUASsetlogo` 选择；其笔画与色泽存在生成式处理差异。

## 许可与声明

HUAS-Beamer 自主开发的软件源码计划按 LPPL-1.3c 发布，版权持有人与 Current Maintainer 均为 `bsxiaocai`；具体文件见 `NOTICE.md`，许可证全文见 `LICENSE`。

湖南文理学院名称、校徽、Logo 等官方身份素材不因源码使用 LPPL 而获得 LPPL 授权。HUAS-Beamer 是独立开发项目，并非湖南文理学院官方模板；素材权利与第三方参考项目的说明见 `NOTICE.md`。
