# 初高中化学知识库

由 LLM 维护的双层 Markdown 知识库，面向中国初高中化学学习与备考。所有内容为纯 Markdown，可用 Obsidian、VS Code 等任意编辑器浏览；Obsidian 的 `[[wiki-link]]` 与图谱视图是可选的增强体验。

**每次会话开始**：先阅读 `wiki/_log.md` 了解近期操作，保持上下文连续。若目录尚不存在则跳过。

## 架构

```
.
├── raw/                          # 不可变原始资料（LLM 只读；仅 ingest 时由人类触发写入）
│   ├── ella/                     # Ella 仓库化学资料镜像
│   ├── inbox/                    # 待 ingest 的新资料（桌面收集暂存）
│   ├── YYYY-MM-DD-标题.md        # 或按日期前缀命名
│   └── assets/                   # 附件（图片、PDF 等），按文章分桶
│       └── <文章-slug>/
│           └── NN-描述.{png,jpg,pdf,...}
├── wiki/                         # LLM 维护的衍生层（人类以阅读为主）
│   ├── summaries/                # 每篇 raw 对应一篇摘要（1:1）
│   ├── entities/                 # 实体：元素、化合物、人物、仪器、物质类别
│   ├── concepts/                 # 概念：反应类型、化学键、定律、实验方法
│   ├── comparisons/              # 对比分析（条件触发生成）
│   ├── overviews/                # 主题综述（≥3 篇相关文章时生成）
│   ├── synthesis/                # 问答归档（由 query 产生）
│   ├── _index.md                 # 内容索引（查询时先读此文件）
│   └── _log.md                   # 操作日志（时间线，只追加）
└── CLAUDE.md                     # 本文件
```

**两层分离**：`raw/` 是不可变的事实底稿；`wiki/` 是 LLM 对知识的当前理解。理解层可随时从 raw 重新编译。

## 领域范围

本知识库覆盖 **中国初高中化学** 课程标准相关内容，包括但不限于：

- **物质结构**：原子结构、元素周期律、化学键、分子间作用力
- **化学反应**：方程式配平、氧化还原、离子反应、化学平衡、速率
- **常见物质**：酸碱盐、金属与非金属、有机物入门（烷烃、烯烃、官能团）
- **实验与计算**：气体制备、滴定、物质的量、浓度计算
- **中考/高考**：常见考点、易错点、题型归纳

## 原则

1. **raw 不可变**：raw 文件及其 `assets/` 附件一旦写入，不得修改或删除
2. **wiki 可重编译**：summaries → entities → concepts → comparisons → overviews 均可从 raw 重新生成（synthesis 除外，由问答触发）
3. **先搜后建**：创建 entity/concept 页面前，搜索现有文件与 aliases，避免重复
4. **不丢信息**：增量更新 entity/concept 时，保留全部已有内容
5. **链接格式**：始终使用 `[[文件夹/名称]]`（如 `[[entities/铁]]`、`[[concepts/氧化还原反应]]`）
6. **语言**：wiki 内容默认使用 **简体中文**；化学式、元素符号、IUPAC 命名保持国际惯例

## 命名与分类约定

### 文件命名

- raw 文件：`YYYY-MM-DD-标题.md`，特殊字符替换为 `-`，连续 `-` 合并，标题截断至 80 字符
- raw 附件：`raw/assets/<文章-slug>/NN-描述.扩展名`
  - `NN` 为两位序号（`01`, `02`, …），按原文出现顺序
  - 在 raw.md 中用相对路径引用：`![说明](assets/<slug>/01-xxx.jpg)`
- wiki 页面：以主题命名（如 `铁.md`、`氧化还原反应.md`、`NaCl vs KCl.md`）
- comparisons：`A vs B.md`（如 `离子反应 vs 分子反应.md`）
- synthesis：以答案主题命名，不用原问题作文件名

### 实体（entities/）分类

| 类型 | 示例 |
|------|------|
| 元素 | 铁、氧、碳 |
| 化合物 | 氯化钠、硫酸、甲烷 |
| 物质类别 | 酸、碱、盐、氧化物 |
| 人物 | 门捷列夫、拉瓦锡 |
| 仪器/装置 | 滴定管、启普发生器 |

### 概念（concepts/）分类

| 类型 | 示例 |
|------|------|
| 反应类型 | 化合反应、置换反应、氧化还原反应 |
| 结构与理论 | 化学键、元素周期律、勒夏特列原理 |
| 计算方法 | 物质的量计算、溶液浓度换算 |
| 实验方法 | 气体制备、酸碱滴定、焰色反应 |
| 考点/易错点 | 离子方程式书写、氧化数判断 |

### Frontmatter 模板

```yaml
---
type: summary | entity | concept | comparison | overview | synthesis
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [初中, 高中, 实验, 计算, 易错点]
grade: 初中 | 高中 | 初高中    # 适用学段
source: [[raw/YYYY-MM-DD-标题]]  # 仅 summary
aliases: [别名1, 别名2]          # entity/concept 专用
---
```

### 交叉链接拓扑

```
raw/文章  ←──  summaries（唯一直接引用 raw 的页面）
                    │
                    ▼
            entities  ↔  concepts
                │            │
                ▼            ▼
            comparisons  comparisons
                    \      /
                     ▼    ▼
                  overviews

synthesis ──→ 所有页面（仅出链，叶子节点）
```

## 工作流

### Ingest（摄入资料）

用户说「ingest」「保存」「收录」或粘贴 URL/文件时，执行三阶段流程：

**阶段 1：抓取并保存 raw**
1. 用可用工具（WebFetch / curl / 浏览器 MCP 等）获取 URL，保留正文、作者、发布日期、图片
2. 下载所有图片/附件到 `raw/assets/<slug>/NN-描述.扩展名`
3. 保存正文为 `raw/YYYY-MM-DD-标题.md`，用相对路径引用附件
4. ingest 前检查 URL 是否已在 `wiki/_log.md` 或已有 raw 文件的 frontmatter 中出现；若已收录则跳过

**阶段 2：编译 wiki**
1. **摘要**：在 `wiki/summaries/` 创建 1:1 摘要，链接回 `[[raw/...]]`，标注适用学段与核心考点
2. **实体提取**：识别人物、元素、化合物、仪器、物质类别
   - 已存在则增量更新（保留旧内容，追加新来源）
   - 不存在则创建 `wiki/entities/名称.md`
3. **概念提取**：识别反应类型、定律、实验方法、计算技巧、易错点
   - 已存在则更新，否则创建 `wiki/concepts/名称.md`
4. **对比评估**：若文章明确对比两个已有实体/概念，生成 `wiki/comparisons/A vs B.md`
5. **综述评估**：若某主题已有 ≥3 篇相关摘要，生成或更新 `wiki/overviews/主题.md`

**阶段 3：索引与日志**
1. 更新 `wiki/_index.md`（按类型分组，每页一行描述）
2. 追加 `wiki/_log.md`：时间戳、来源、生成/更新的页面列表

**化学资料 ingest 提示**：
- 方程式使用标准写法（如 `\ce{2H2 + O2 -> 2H2O}` 或 plain text `2H₂ + O₂ → 2H₂O`）
- 标注是初中还是高中内容
- 实验步骤注意安全提示
- 区分「事实」与「考试技巧/口诀」

### Query（提问）

用户提问（非 ingest 操作）时，主动检索知识库：

1. **先读索引**：阅读 `wiki/_index.md`，定位相关页面
2. **定向阅读**：读取 index 中识别的 summaries、entities、concepts 等
3. **补充搜索**：index 不足时用 Grep 在 `wiki/` 按关键词搜索
4. **综合回答**：答案中内联 `[[文件夹/名称]]` wiki 链接，注明适用学段
5. 知识库中无相关内容时，明确说明，不编造
6. 对易错点、概念辨析给出清晰解释，必要时举初高中考试例题

**归档判断**——回答后评估是否归档到 `wiki/synthesis/`：

- 综合了 ≥2 个 wiki 页面 → 建议归档
- 产生了跨领域洞察或解题套路 → 建议归档
- 用户明确标记有价值 → 直接归档
- 简单事实查表、单页检索 → 不归档

建议话术：「此回答综合了多个来源，是否归档到知识库？」用户确认后保存为 markdown 页，更新 `_index.md` 和 `_log.md`。

### Lint（健康检查）

用户说「lint wiki」「检查知识库」「健康检查」时执行：

**步骤 1：结构扫描**
1. **断链**：grep 所有 `[[...]]` 并检查目标文件是否存在
2. **孤儿页**：确认每个 wiki 页至少被另一页引用（summaries 除外，通过 index 引用）
3. **缺失交叉引用**：检查 entity/concept 页的「相关」章节是否遗漏共现主题

**步骤 2：内容审查**
4. **矛盾检测**：同一 entity/concept 在不同来源中的描述是否矛盾
5. **过时信息**：较旧摘要是否被新资料 supersede
6. **缺失页面**：多篇文章提及但未独立建页的概念/实体

**步骤 3：发展建议**
7. **知识缺口**：基于现有图谱，建议可补充的章节/实验/题型
8. **新问题**：基于现有内容，建议值得探索的问题

**输出**：问题列表 + 修复建议；等用户确认后再执行。在 `_log.md` 追加 lint 记录。

### 维护命令

- **重新编译**：用户说「recompile wiki」→ 从 raw 重新生成全部 wiki 页（保留 synthesis）
- **更新索引**：用户说「update index」→ 重新生成 `wiki/_index.md`
- **去重**：ingest 前检查 URL 是否已收录

## 页面内容规范

### Entity 页结构

```markdown
# 名称

## 基本信息
（化学式、类别、学段等）

## 性质与用途
（物理性质、化学性质、应用）

## 相关反应
（重要方程式，链接到 concepts）

## 来源
- [[summaries/...]]

## 相关
- [[concepts/...]]
- [[entities/...]]
```

### Concept 页结构

```markdown
# 概念名称

## 定义
（准确、适合初高中理解的表述）

## 要点
（核心知识点，分条列出）

## 易错点
（常见误区与纠正）

## 例题/应用
（简短示例，标注初中或高中）

## 来源
- [[summaries/...]]

## 相关
- [[concepts/...]]
- [[entities/...]]
```

## Obsidian 协作

- **Mac/Windows**：收集资料、Cursor ingest、git push（见 [[wiki/多端同步说明]]）
- **手机/平板**：只读；Working Copy pull 后 Obsidian 浏览
- 用户在 Obsidian 中 **阅读** wiki，LLM 在 Cursor/Claude Code 中 **写入**
- 附件目录：`raw/assets/`
- 新资料暂存：`raw/inbox/`；Ella 镜像：`raw/ella/`
- 图谱视图用于发现 hub 页与 orphan 页；Graph 建议过滤 `path:wiki`
- 整个 vault 用 Git 管理，GitHub 为唯一真相源
