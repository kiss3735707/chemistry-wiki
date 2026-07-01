# 操作日志

> 只追加，不修改历史。新会话先读此文件。

## [2026-06-30] init | 知识库初始化

- 创建初高中化学 LLM Wiki 目录结构
- 生成 CLAUDE.md schema
- 初始化 `_index.md` 与 `_log.md`
- 等待首次 ingest

## [2026-06-30] batch ingest | GitHub Ella 化学资料库

- 来源：https://github.com/kiss3735707/Ella-/tree/main/化学
- raw 文件（5 md + 1 opml）：
  - [[raw/ella/2026-06-30-初中化学知识框架]]
  - [[raw/ella/2026-06-30-初中化学常见物质速查表]]
  - [[raw/ella/2026-06-30-初中化学溶解性表]]
  - [[raw/ella/2026-06-30-初中化学数字与排序速查]]
  - [[raw/ella/2026-06-30-初中化学思维导图-大纲]]
  - raw/ella/2026-06-30-初中化学思维导图.opml
- 生成 summaries：5 篇
- 生成/更新 concepts：11 篇
- 生成/更新 entities：12 篇
- 生成 comparisons：1 篇
- 生成 overviews：[[overviews/初中化学总览]]
- 更新 [[_index]]

## [2026-06-30] query-archive | 复分解反应沉淀判断

- 问题：复分解反应什么时候有沉淀
- 归档：[[synthesis/复分解反应沉淀判断]]
- 引用：[[concepts/复分解反应]]、[[concepts/溶解度与溶解性规律]]、[[summaries/初中化学溶解性表]]
- 更新 [[_index]]

## [2026-06-30] setup | 多端同步与 GitHub

- 重组 raw：`raw/ella/`（Ella 镜像）、`raw/inbox/`（待 ingest）
- 新增 [[多端同步说明]]：Mac/Windows 收集发布，手机/平板只读
- 初始化 Git 仓库，配置 remote `git@github.com:kiss3735707/chemistry-wiki.git`
- 待用户在 GitHub 创建空仓库后执行 `./scripts/push-to-github.sh`
- 更新 [[首页]]、CLAUDE.md、[[_index]]

## [2026-07-01] ingest | 高一化学知识框架

- 来源：[[raw/ella/2026-07-01-高一化学知识框架]]（沪科版 2020 必修第一册，上海高一）
- 镜像路径：`raw/ella/2026-07-01-高一化学知识框架.md`
- 生成 summaries：[[summaries/高一化学知识框架]]
- 生成 overviews：[[overviews/高一化学总览]]
- 新建 concepts：[[concepts/物质的量]]、[[concepts/离子反应]]、[[concepts/分散系]]、[[concepts/元素周期律]]、[[concepts/化学键]]
- 新建 entities：[[entities/氯气]]、[[entities/二氧化硫]]、[[entities/氨]]、[[entities/硝酸]]
- 新建 comparisons：[[comparisons/SO₂漂白 vs HClO漂白]]
- 更新 concepts：[[concepts/氧化反应与还原反应]]、[[concepts/溶液与溶质质量分数]]、[[concepts/复分解反应]]
- 更新 [[_index]]、[[首页]]
