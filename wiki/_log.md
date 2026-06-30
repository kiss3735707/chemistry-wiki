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
- 初始化 Git 仓库，推送到 GitHub
- 更新 [[首页]]、CLAUDE.md、[[_index]]
