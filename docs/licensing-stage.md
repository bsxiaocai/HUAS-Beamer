# 许可证与公开前准备阶段总结（2026-09-26）

本轮依据 `docs/development/lience_prompt.md` 开展许可审计与准备，尚未进入开发总纲的视觉页面 Phase 2。

## 审计结果

- Git 跟踪的原创 TeX 源码为五个 `beamer*themeHUAS.sty` 文件、`theme/huas-assets.tex` 和 `main.tex`。当前未跟踪任何学校图片、字体、第三方参考源码或参考素材；`assets/research/`、`examples/references/`、`build/` 均被 Git 忽略。
- 将七个项目 TeX 源文件与八个本地参考仓库中的 104 个 `.sty`、`.tex`、`.dtx` 文件比较。仅 `main.tex` 与 ZJU 示例有四行连续相同的通用 Beamer 用法（日期、开始文档、开始 frame、调用标题页）；未发现四行及以上的其他连续非注释复制片段。此检查不能替代未来对新增文件的逐项来源核查。
- 本地参考项目的许可证线索见 `examples/README.md`。ZJU-Beamer-Template 和 NJU_Beamer 未找到顶层 LICENSE；当前没有复用其源码，因此本轮未形成需合并的第三方许可条款。
- 学校名称出现在示例文字中，但校徽、Logo、校旗和研究图片都未纳入 Git。其公开使用、再分发和商标事项仍待人工核实。

## 本轮更改与验证

- 从 TeX Live 官方 LaTeX 基础发行文件 `texmf-dist/doc/latex/base/lppl.txt` 原样复制完整 LPPL 1.3c 到根目录 `LICENSE`。复制后与来源文件的 SHA-256 均为 `CA3227F672053CB608959D7E1D476C7A13EFEA11BE3F6E53758A68B650C918E8`，字节一致；未改写许可证正文。
- 建立 `NOTICE.md`，明确 LPPL 计划覆盖的源码范围、项目非官方状态、四类素材的当前状态和不自动转授学校视觉资产的原则。
- 给核心主题源码和示例增加 LPPL 声明，README 增加简短许可说明并移除机器专用编译路径。版权持有人与 Current Maintainer 按用户要求保留明确占位符。
- 在空的 `build/licensing/` 目录连续两次用 XeLaTeX 编译 `main.tex`，得到 2 页 16:9 PDF；最终日志未发现 error、warning、overfull 或 underfull。
- 检查现有项目文本中的常见密钥、口令和本机路径。未发现明显凭据；历史总结 `docs/phase-0.md` 仍记录本机 TeX Live 的磁盘路径，此项属于公开前可再审阅的信息。

## 尚未完成好与发布前阻碍

- `[COPYRIGHT_HOLDER]`、`[CURRENT_MAINTAINER]` 是用户要求保留的占位符。公开前必须填入有权授权的人或主体，并提供可联系的维护渠道；目前的 `maintained` 状态仍是预期配置，不能视为已最终落实。
- `docs/development/` 中的开发提示和其他非源码文档未纳入本轮 LPPL 源码范围；公开前需要确认作者和分发权利。
- 学校视觉素材的来源、权利和公开使用方式未核实，本地研究素材继续保持忽略状态。若 Phase 2 需要正式使用，应先逐项确认，再决定是否纳入发行版。
- 本轮未修改仓库可见性、未创建 Release、未推送、未向 CTAN 或其他平台发布。

## 下一阶段注意

继续开发前重新阅读 `docs/development/DEVELOPMENT_PROMPT.md`、`docs/development/lience_prompt.md`、`docs/phase-0.md`、`docs/phase-1.md` 和本总结。视觉页面 Phase 2 应逐项实现与编译。公开发布前先替换占位符、复核文档和素材权利，再重新做安全与许可检查。
