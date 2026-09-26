# HUAS-Beamer

湖南文理学院主题的 LaTeX Beamer 项目。目前完成 Phase 2：可编译的中文 16:9 示例，以及标题页、章节页、普通内容页、双栏图片页和结束页。

## 编译

需要安装包含 `ctexbeamer` 的 TeX Live，并使用 XeLaTeX。在项目根目录运行（先创建 `build/`）：

```sh
mkdir build
xelatex -output-directory=build main.tex
xelatex -output-directory=build main.tex
```

若 Windows 终端找不到 `xelatex`，请将 TeX Live 的 `bin/windows` 目录加入 PATH。

输出文件为 `build/main.pdf`。编辑 `main.tex` 中的标题、作者和页面内容即可开始使用。`\usetheme{HUAS}` 加载主题入口，四个 `beamer*themeHUAS.sty` 分别管理颜色、字体、内层和外层样式；`theme/` 存放内部素材加载代码。

## 当前接口

默认显示页脚和页码，不显示 Logo。`\usetheme[nofooter]{HUAS}` 可关闭页脚；如要在标题页及内容页页脚显示自备 Logo，可写：

```tex
\usetheme[logo]{HUAS}
\HUASsetlogo{assets/logo/my-logo.png}
```

`\HUASsetlogo` 应放在导言区、`\usetheme` 之后。路径不存在时主题会给出警告并跳过图片。`footer`、`nofooter`、`logo`、`nologo` 是现有基础选项；更完整的 `\HUASsetup{...}` 留待 Phase 3。

标题页使用普通 Beamer 的 `\titlepage`，章节页使用 `\sectionpage`，结束页使用 `\HUASclosingpage`。示例对这三类页面采用 `[plain,noframenumbering]`，所以页码只统计内容页。章节页和结束页在局部切换为 `HUASWarmPaper`，不会更改其他页面背景。双栏图片页使用 Beamer 原生 `columns`。

## 项目状态与素材

`assets/research/` 存放研究素材，尚未确认全部素材适合公开分发。示例在本机检测到校徽和校园图片时显示它们；在没有这些文件的环境下仍可完整编译，并以文字校名和图片占位框替代。项目绘制的建筑示意线稿位于 `assets/lineart/`，素材目录说明见 `assets/README.md`。`examples/references/` 存放开发总纲提到的第三方参考项目，不属于 HUAS-Beamer 源码；版本和许可线索见 `examples/README.md`。开发总纲及阶段总结位于 `docs/`。当前调色板属于 **HUAS-Beamer Derived Design System**，不代表学校官方视觉标准。

## 许可与声明

HUAS-Beamer 自主开发的软件源码计划按 LPPL-1.3c 发布，版权持有人与 Current Maintainer 均为 `bsxiaocai`；具体文件见 `NOTICE.md`，许可证全文见 `LICENSE`。

湖南文理学院名称、校徽、Logo 等官方身份素材不因源码使用 LPPL 而获得 LPPL 授权。HUAS-Beamer 是独立开发项目，并非湖南文理学院官方模板；素材权利与第三方参考项目的说明见 `NOTICE.md`。
