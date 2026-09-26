# Phase 1 开发总结（2026-09-26）

## 本轮完成

- 重新阅读开发总纲和 `phase-0.md`。用户已在本轮明确要求继续开发；仓库现有 `origin/main`，因此进入 Phase 1。
- 整理目录：开发总纲移至 `docs/DEVELOPMENT_PROMPT.md`；研究素材移至 `assets/research/`；编译产物集中到 `build/`。研究素材、参考仓库和编译产物均由 `.gitignore` 排除。
- 按用户追加要求，将总纲提到的 SJTUBeamer、USTC Beamer、ZJU、两套 THU、两套 NJU 和 Metropolis 共八个参考仓库下载到 `examples/references/`；版本和许可线索见 `examples/README.md`。
- 建立 Beamer 标准五文件：主题入口，以及 color、font、inner、outer 子主题。入口只处理基础选项和模块加载；`theme/huas-assets.tex` 负责 Logo 路径加载。
- 提供临时 HUAS-Beamer Derived Design System 色票、基本字体层级、内容页标题栏、页脚和页码。基础选项为 `footer`/`nofooter`、`logo`/`nologo`；公开 Logo 接口是 `\HUASsetlogo{路径}`。
- 未添加新宏包。沿用 `ctexbeamer` 的中文字体选择与 Beamer 已加载的图片支持。

## 验证

- 每组主题修改后均运行 XeLaTeX。最后从空的 `build/fresh/` 目录连续编译两遍，得到 2 页 PDF；`pdfinfo` 报告 453.54 × 255.12 pt，日志未发现 error、warning、overfull 或 underfull。
- 另用本地 `assets/research/HUAS-Logo_Color.png` 编译验证 `[logo]` 与 `\HUASsetlogo`，并编译验证 `[nofooter]`。两种输出均成功生成 16:9 PDF，渲染检查符合预期。缺失 Logo 路径的测试仍生成 PDF，日志给出预期警告。测试文件及 PDF 均在忽略的 `build/` 中。
- `git check-ignore` 已确认研究素材、参考仓库与编译产物不会进入提交。

## 未完成好与限制

- 色票仍是设计推导的暂定值，没有正式 HUAS VI 手册支撑；`HUASRed` 延续 Phase 0 的 `#A34A42`，不应称为学校官方色。中文字体依赖 `ctexbeamer` 的平台默认配置，尚未验证 Linux、macOS 与 Overleaf。
- 标题页仍使用 Beamer 默认布局，页脚和页码也出现在标题页；章节页、结束页、建筑线稿和完整视觉模式留待后续阶段。
- Logo 加载器只支持用户提供的单个图片路径，并显示在页脚；正式校徽文件因分发许可未核实，尚未纳入 Git。若路径不存在会警告并跳过图片。
- 项目代码许可证仍待确定。本阶段没有直接复制参考仓库代码。
- 编译测试最初用 Windows 反斜杠传入测试源文件时，XeLaTeX 未正确解析路径；改用正斜杠后编译成功。后续脚本应统一使用正斜杠传给 TeX。

## 下一阶段注意

进入 Phase 2 前，再次阅读 `docs/DEVELOPMENT_PROMPT.md`、`docs/phase-0.md` 和本总结，并针对每个视觉页面复查 `examples/references/` 中对应实现。先核实学校视觉素材的来源和使用方式，再决定哪些素材可复制到可提交的 `assets/logo/`、`assets/lineart/` 等目录。标题页、章节页、普通内容页、双栏图片页、结束页应逐项实现、逐项编译和检查，避免把当前页脚或 Logo 位置机械套到所有页面。
