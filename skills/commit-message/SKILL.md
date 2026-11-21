---
name: commit-message
description: '写、改、审 git commit message 与提交信息时使用，涵盖 type(scope) 标题、拆多条、squash、改写历史、agent 自动提交'
---

# Commit Message 规范

写提交信息之前先看 `git diff --stat`，不要凭改动意图猜；改动的范围决定标题，改动的原因决定正文。

## 标题

```
type(scope): 中文说明（≤50 字符，句末不加句号）
```

- `type` 只从十一个里选：`feat fix docs test refactor perf chore build ci style revert`
- `scope` 必填，小写英文：取目录名或领域词（`proxy` `player` `cli` `dashboard` `auto`）
- 同一个东西不许有两个叫法，以先出现的为准
- 中文写在冒号后；代码标识符、命令、版本号保留原文

标题里出现「和 / 并 / 以及 / 同时 / and」就是该拆的信号，见 `references/rules.md`。

## 正文

空一行，写 **为什么** 和 **影响面**，用 `-` 列表。diff 已经说明了 what。

满足任一条必须写正文：

- 动了行为、接口、配置默认值
- 单条改动超过 100 行
- 删功能或删文件
- 跨模块

纯格式、纯文档、纯版本号可以只写标题。

## Trailer

有值时必填，放正文末尾：

- `Refs: <工单或 issue>` —— 消息里出现 `[ABC-123]` 或 `#123` 时必须补
- `Verified: <实际跑过的命令>` —— 不要说「已测试」
- `Co-authored-by: <agent>` —— agent 参与时署名

## 边界

- 记账、`journal`、`archive` 一类不进主分支；必须提交的机器提交用 `chore(auto):`
- 合并默认 squash，PR 标题即最终标题；分支名不当文案
- 禁止 `git commit --no-verify` 绕过校验；被拦是格式问题，改消息而不是绕

## 自查

```sh
scripts/check-log            # 历史违规分布（只报不改）
scripts/commit-msg .git/COMMIT_EDITMSG   # 手动验一条
```

规则全文 `references/rules.md`，真实 bad→good 对照 `references/examples.md`。
