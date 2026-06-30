# 初高中化学 LLM Wiki

Karpathy LLM Wiki 模式的化学知识库。GitHub 为唯一真相源。

## 仓库结构

- `raw/ella/` — Ella 化学资料镜像
- `raw/inbox/` — 待 ingest 新资料
- `wiki/` — LLM 编译的知识层（Obsidian Graph 主战场）
- `CLAUDE.md` — Agent 工作流规则

## 设备分工

| 设备 | 角色 |
|------|------|
| Mac / Windows | 收集、Cursor ingest、`git push` |
| 手机 / 平板 | 只读、Pull 后 Obsidian 浏览 |

详见 `wiki/多端同步说明.md`。

## 快速开始

```bash
git clone git@github.com:kiss3735707/chemistry-wiki.git
cd chemistry-wiki
```

Obsidian → Open folder as vault → 选择 clone 目录 → 打开 `wiki/首页.md`。

## Cursor 命令

- `ingest raw/inbox/` — 收录新资料
- `query` — 基于 wiki 提问
- `lint wiki` — 健康检查
