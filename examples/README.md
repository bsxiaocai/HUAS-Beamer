# 示例与参考项目

从项目根目录用 XeLaTeX 编译，不在 examples 内编译：

- `academic-demo.tex`：浅色学术汇报，包含方法、公式、表格与参考资料。
- `seminar-demo.tex`：暖色读书研讨，包含宋体引文、双栏细读与讨论。
- `cool-demo.tex`：蓝色完整内容组件示例。
- `local-assets.tex`：可选本地透明校徽与用户建筑图的加载；没有素材时不显示装饰图。

根目录执行 `./scripts/build.ps1` 编译全部示例，或按 README 的命令手动编译。源码可独立选择，仍需根目录五个主题文件、theme 目录和此可选素材加载文件；不依赖第三方参考仓库。

逐页修改说明：[main](../docs/templates/main.md)、[academic](../docs/templates/academic.md)、[seminar](../docs/templates/seminar.md)、[cool](../docs/templates/cool.md)。[共享微调手册](../docs/customization.md) 说明每个尺寸、字体和颜色的位置及作用；四份源码的导言区带可取消注释的调参示例。

## 参考项目源码

开发总纲中提到的项目均已浅克隆到 `examples/references/`。这些仓库仅供本地研究，不纳入 HUAS-Beamer 的 Git 提交；HUAS-Beamer 没有直接复制其代码。

| 本地目录 | 上游项目 | 下载版本 | 许可线索 |
| --- | --- | --- | --- |
| `SJTUBeamer` | [sjtug/SJTUBeamer](https://github.com/sjtug/SJTUBeamer) | `72a761384461` | Apache-2.0，见仓库 `LICENSE` |
| `USTC-Beamer` | [ustctug/ustcbeamer](https://github.com/ustctug/ustcbeamer) | `315cd8583707` | LPPL-1.3c，见仓库 `LICENSE` |
| `ZJU-Beamer-Template` | [qychen2001/ZJU-Beamer-Template](https://github.com/qychen2001/ZJU-Beamer-Template) | `a276635341ce` | 未找到顶层 LICENSE |
| `THU-Beamer-Theme` | [tuna/THU-Beamer-Theme](https://github.com/tuna/THU-Beamer-Theme) | `061f088d1c7e` | LPPL-1.3c，见仓库 `LICENSE` |
| `thubeamer` | [YangLaTeX/thubeamer](https://github.com/YangLaTeX/thubeamer) | `210c08e20022` | LPPL-1.3c，见仓库 `License` |
| `NJU_Beamer` | [luoyiti/NJU_Beamer](https://github.com/luoyiti/NJU_Beamer) | `48c70d4aec6a` | 未找到顶层 LICENSE；明确标注由 `thubeamer` 改造 |
| `NJUBeamer` | [nju-lug/NJUBeamer](https://github.com/nju-lug/NJUBeamer) | `01ffb8f78009` | LPPL-1.3c，见仓库 `LICENSE` |
| `Metropolis` | [matze/mtheme](https://github.com/matze/mtheme) | `2fa6084b9d34` | README 声明主题采用 CC BY-SA 4.0 |

本阶段阅读重点：SJTUBeamer 的标准主题模块和选项入口；USTC 的学校视觉素材组织；ZJU 的轻量结构；THU 与 NJU 的二次开发关系；Metropolis 的留白和页脚信息控制。借鉴结构与原理前应再核对具体文件的版权说明，不直接复制代码。
