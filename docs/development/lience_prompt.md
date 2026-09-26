# HUAS-Beamer Licensing & Repository Compliance Task

HUAS-Beamer 已完成第一阶段开发，并已经建立 Git 仓库，目前仓库仍为 Private。

本阶段需要为未来公开发布建立正式的许可证和版权声明体系。

项目计划采用：

**LaTeX Project Public License Version 1.3c（LPPL-1.3c）**

作为 HUAS-Beamer 自主开发的 LaTeX 源代码许可证。

在修改任何文件之前，请先审查当前仓库结构、Git 状态、现有源码、assets 和引用/参考的第三方项目。

---

## 1. 许可证原则

HUAS-Beamer 的自主开发 LaTeX 源代码原则上使用：

`LPPL-1.3c`

原因：

- 项目属于 LaTeX / Beamer theme；
- LPPL 是 LaTeX 项目官方使用并推荐用于新 TeX 相关作品的许可证；
- HUAS-Beamer 是长期维护项目；
- 项目需要明确 Current Maintainer。

不得自行修改 LPPL 正文。

如需加入完整 LICENSE，请使用 LaTeX Project 官方发布的 LPPL 1.3c 原文，而不是 AI 自己重新生成或改写许可证文本。

---

## 2. 首先进行 License Audit

在添加许可证之前检查：

1. 当前项目中哪些文件完全由 HUAS-Beamer 项目原创；
2. 是否存在复制、修改或改编自 SJTUBeamer、USTC Beamer、ZJU Beamer、THU Beamer、NJU Beamer、Metropolis 或其他项目的代码；
3. 如果存在第三方代码，检查对应上游 LICENSE；
4. 判断相关代码是否允许按当前方式使用；
5. 不得把第三方代码错误地重新声明为 HUAS-Beamer 自有 LPPL 代码；
6. 如果来源或许可证不清楚，先报告，不要擅自处理。

参考项目只能在许可证允许的情况下复用代码。

“参考实现思想”和“直接复制源码”必须明确区分。

---

## 3. HUAS 官方视觉资产不得自动纳入 LPPL

HUAS-Beamer 包含或可能包含：

- 湖南文理学院校徽；
- 中文校名 Logo；
- 英文校名；
- HUAS 标识；
- 校旗；
- 校训书法；
- 校园建筑线稿；
- 官方宣传材料中的其他视觉元素。

这些资产不因为存在于 HUAS-Beamer 仓库中，就自动成为项目作者可以重新授权的作品。

因此：

**LPPL-1.3c 默认只覆盖 HUAS-Beamer 自主开发且有权授权的软件代码和明确声明覆盖的项目文件。**

学校 Logo、校徽、商标、名称及来源于学校的官方视觉资产，应在 NOTICE 中单独说明。

不要声明这些官方资产属于 HUAS-Beamer 作者。

不要声明 LPPL 自动授权他人自由修改学校校徽或其他学校标识。

---

## 4. 建立许可证文件

在确认不存在许可证冲突后，建立：

### LICENSE

包含完整、未经修改的：

`LaTeX Project Public License Version 1.3c`

---

### NOTICE.md

至少说明：

1. HUAS-Beamer 是独立开发的开源 LaTeX Beamer theme；
2. 当前并非湖南文理学院官方发布或授权的官方模板，除非未来状态发生变化；
3. 湖南文理学院名称、HUAS 标识、校徽及其他学校视觉资产的相关权利归其各自权利人所有；
4. 这些资产不因 HUAS-Beamer 使用 LPPL 而自动按照 LPPL 重新授权；
5. 列出第三方代码、素材和对应来源/许可证；
6. 区分：
   - Project source code
   - Original project assets
   - HUAS official assets
   - Third-party assets

如果部分资产权利状态暂时无法确认，明确标记为待确认，而不是猜测。

---

## 5. LaTeX 源码许可证声明

对于 HUAS-Beamer 自主开发的核心 `.sty` / `.dtx` 等源码，根据 LPPL 官方推荐格式添加适当的许可证头。

至少包含：

- Copyright 年份；
- Copyright holder；
- LPPL 版本；
- maintenance status；
- Current Maintainer。

建议状态：

`maintained`

不要在每个普通示例文件中机械复制超长许可证。

遵循成熟 LaTeX 项目通常使用的许可证声明方式。

---

## 6. README 更新

README 增加简洁的 License / Disclaimer 部分。

需要明确表达：

**Code**

HUAS-Beamer 自主开发的软件代码按照 LPPL-1.3c 发布。

**HUAS Identity Assets**

湖南文理学院校徽、名称、Logo 和其他官方身份视觉资产不因代码许可证而获得 LPPL 授权。

**Project Status**

HUAS-Beamer 当前为独立开发项目，不应描述成湖南文理学院官方模板。

文字保持专业、简洁，不需要加入大段法律说明。

---

## 7. 检查公开仓库风险

由于仓库未来将从 Private 转为 Public，请顺便检查：

- 是否存在 API key；
- token；
- 用户名密码；
-私人路径；
- 临时文件；
- LaTeX build files；
- 大型无必要素材；
- 来源不清晰的图片；
- 无法确认再发布权利的字体；
- 第三方文件；
- 不适合公开的测试文件。

只报告发现的问题。

不要未经用户确认删除重要 assets。

---

## 8. 不要立即公开仓库

当前 GitHub Repository 仍应保持：

**Private**

本阶段只完成许可证和公开发布前准备。

不得自行：

- 将仓库切换为 Public；
- 创建 Release；
- 发布到 CTAN；
- 上传到其他平台。

以后由用户明确决定公开时间。

---

## 9. 完成后进行 Review

完成许可证配置后：

1. 查看 `git diff`；
2. 确认没有修改无关代码；
3. 检查 LICENSE 是否为官方 LPPL 1.3c 原文；
4. 检查源码头信息；
5. 检查 README；
6. 检查 NOTICE；
7. 检查第三方许可证兼容性；
8. 确认项目仍能够正常 XeLaTeX 编译。

然后输出一份简洁报告：

- 本次新增/修改了什么；
- 哪些内容受 LPPL-1.3c 覆盖；
- 哪些 assets 明确不受 LPPL 覆盖；
- 是否发现第三方许可证风险；
- 在仓库公开前还需要人工确认什么。

完成本阶段以后再创建 Git commit。

建议 commit：

`docs: add LPPL-1.3c license and asset notices`

未经用户确认，不要继续执行公开发布。