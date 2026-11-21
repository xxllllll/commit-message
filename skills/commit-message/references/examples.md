# 真实对照：本项目历史里改过的 7 条

以下 7 条来自真实历史，每条都核对过 diff；私有项目的名字已替换为「项目 A/B/C/D」，提交哈希保留。改法是按当时实际改动重写，不是凭空润色。

## 1. 文案跟改动无关 — `项目 A 6af5e2c`

原文：

```
Enhance backend functionality and improve frontend design

- Added new API endpoint for user authentication and session management.
- Updated frontend components to improve responsiveness and accessibility.
```

diff：31 个文件 `+10502 / -0`，全部 added，是项目首次导入。所谓「认证接口」「改进可访问性」都不存在。

改成：

```
feat: 导入 项目 A 项目初始代码

首次落库：FastAPI 后端 + 前端界面 + Docker 部署，此前仓库为空。

- 后端 app/api 与 core（channel_sync / epg_manager / iptv_auth / database）
- 部署 Dockerfile、docker-compose、GHCR 发布工作流
- README 记录启动方式与 API 说明
```

判据：`+N / -0` 且全是 added，就是初始导入，不可能同时是「增强」。

## 2. 文件名当标题，同一句话写 19 次 — `Surge d390304`

原文：`Update Panels.sgmodule`

diff：1 个文件 `-5`，移除了 `Sub_info` 面板项和对应 `[Script]` 定义。这个仓库里同样的消息出现 19 次。

改成：

```
chore(panels): 下线机场信息面板

- 移除 Sub_info 面板项（原 update-interval=600）
- 删除对应脚本定义，面板不再引用已失效的订阅节点
```

## 3. 标题罗列四个动词 — `项目 B 4fe070a`

原文：`优化前端API和组件，提升用户体验`

diff：5 个文件 `+178/-48`，实际是三件不相干的事：`/linkserver/history` 缓存降到 5 秒并支持时间戳绕过；两个组件加 Unix 时间戳解析；按钮改网格布局。

改成（两条）：

```
fix(linkserver): 链接历史缓存 5 秒并支持时间戳绕过

原来缓存 5 分钟，新增请求要等好几分钟才可见。
- 默认 TTL 降到 5s
- 支持 ?ts= 参数强制绕过缓存
```

```
style(database): 详情页按钮改网格布局，支持 Unix 时间戳显示
```

## 4. 分支名当文案 — `项目 C 743ae15`

原文：`Merge branch 'agent/pi/source-adr'`

diff：22 个文件 `+1578/-41`，新增候选排序、身份合并、孤儿头像重挂、流水线串联四个脚本，改了 `docs/SOURCING.md`。同仓库这种消息 71 条。

改成 squash 后的：

```
feat(avatar): 头像候选排序与缺失补全流水线

- 候选排序、身份合并、孤儿头像重挂三段脚本
- run_avatar_followup 串联全流程
- SOURCING.md 补选图口径
```

## 5. 标题只放工单号，type 也用错 — `tmdb-proxy c8b7e8f`

原文：`[TMDBP-040] 缓存阈值调参（数据驱动）`

diff：2 个文件，`Report.md +13` 和一个 CSV `+1/-1`，一行代码没动，只是把结论记下来。

改成：

```
docs(perf): 记录 TMDBP-040 缓存阈值调参结论

实测 32MB/64MB/128MB 三档命中率与内存占用，选定 64MB 为默认值。

Refs: TMDBP-040
```

## 6. 一题两改 — `elastic-fruit-runner 52b9ba8`

原文：`fix: upgrade runner base to 2.338.0 and guard empty runner name cleanup`

diff：Dockerfile 基础镜像版本 +1/-1；`docker_host.go` +6 加空名称短路；`docker_host_test.go` +11 补测试。两件事。

改成（两条）：

```
build(docker-host): runner 基础镜像升级到 2.338.0
```

```
fix(docker-host): 跳过名称为空的 runner 清理

清理逻辑对无名称的容器调 remove 会 500，加空值短路并补单测。
```

## 7. 记账提交占满历史 — `项目 D c9ba685`

原文：`chore: record journal`

diff：`.trellis/workspace/xxllllll/journal-2.md +31`、`index.md +3/-2`。同仓库这类消息 54 条，加 `chore(task): archive ...` 共 140 条。

改成（三选一，按省事排序）：

1. 不提交：`.trellis/workspace/` 进 `.gitignore`
2. 放独立 `journal` 分支
3. 按天合并成一条带主题的：

```
chore(journal): 2026-06-10 控制台鉴权与播放回归
```

## 症状对照表

| 症状 | 规则 |
|---|---|
| `+10502/-0` 却写「增强功能」 | 先看 `git diff --stat` 再写消息 |
| `Update X.js` × 19 | 标题禁写文件名 |
| 「优化 A 和 B，提升 C」 | 标题出现「和 / and」→ 拆 |
| `Merge branch '...'` | 合并用 squash，分支名不当文案 |
| `[TICKET-040] 标题` | 工单号进 trailer，不进标题首位 |
| 「调参」实际只改文档 | type 按 diff 选，不按意图选 |
| `chore: record journal` × 54 | 记账文件不进主分支 |
