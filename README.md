# HUAS-Beamer

湖南文理学院主题的 LaTeX Beamer 项目。目前处于 Phase 0：仅提供可编译的中文 16:9 最小示例。

## 编译

需要安装包含 `ctexbeamer` 的 TeX Live，并使用 XeLaTeX。在项目根目录运行：

```sh
xelatex main.tex
```

若 Windows 终端找不到 `xelatex`，请将 TeX Live 的 `bin/windows` 目录加入 PATH。本机验证使用 `D:\Texlive\texlive\2025\bin\windows\xelatex.exe`。

编辑 `main.tex` 中的标题、作者和普通页面内容即可开始使用。`\usetheme{HUAS}` 会加载项目根目录的最小主题文件。`theme/` 留给后续阶段的内部模块。后续阶段将逐步扩展主题结构和视觉页面。

## 项目状态与素材

`HUAS-Beamer-Research/` 存放研究素材，尚未用于当前主题，也未确认全部素材适合公开分发。`examples/references/` 存放本地下载的第三方参考项目，不属于 HUAS-Beamer 源码。当前强调色为项目推导的起始值，不代表学校官方视觉标准。

HUAS-Beamer 是基于公开 HUAS 视觉材料设计的独立开源项目，并非湖南文理学院官方模板。
