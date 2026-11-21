# adr

架构决策记录（ADR）写作与体检 skill：准入判断、编号与互链、放弃方案约束、大重构拆步蓝图，附带零依赖只读体检与取号脚本 `scripts/check-adr`。

## 设计初衷

很多项目习惯在仓库里维护带日期的 `work/` 过程记录，跨几轮会话后极易膨胀成几十上百 KB 的流水账，既难检索又要反复归档。本 skill 采用「决策进 ADR、常态进 docs、过程不进仓」的分层思路：

- `docs/` 与契约文档只描述**现在是什么**（What）；
- `docs/adr/` 以短小、不可变追加的记录保存**为什么这么定、否决了什么**（Why）；
- 临时进度、排查草稿与个人待办留在会话、Issue 或仓库外目录。

## 用法

在支持的客户端中直接输入 `/adr`，或用自然语言要求起草、修订、审计 ADR。

### 体检与取号脚本

```sh
# 体检当前仓库的 docs/adr（只读，不修改文件）
scripts/check-adr

# 指定 ADR 目录、单个仓库根路径，或包含多个仓库的父目录
scripts/check-adr docs/adr
scripts/check-adr /path/to/repo
scripts/check-adr /path/to/code-root

# 输出下一个可用编号（空目录输出 0001）
scripts/check-adr --next
scripts/check-adr /path/to/repo --next

# 机器可读输出 / 严格模式（警告也返回非零退出码）
scripts/check-adr --json
scripts/check-adr --strict
```

### `check-adr` 检查什么

| 检查项 | 级别 | 说明 |
| --- | --- | --- |
| 重复编号 | 错误 | 同一 `NNNN` 前缀出现多个文件 |
| 文件名格式 | 错误 | 不符合 `NNNN-english-slug.md`（跳过 `README.md`、`index.md`、`template.md`） |
| 标题缺失或编号不符 | 错误 | 缺少一级标题，或标题中的 `ADR-NNNN` 与文件名前缀不一致 |
| 相对链接与 `ADR-NNNN` 断链 | 错误 | 相对 `.md` 链接目标不存在，或引用的 `ADR-NNNN` 编号不在目录中（跳过代码块与占位符） |
| 缺失状态或日期元信息 | 警告 | 头部前 15 行缺少状态或 `YYYY-MM-DD` 日期 |
| 缺少核心章节 | 提示 | 缺少背景、决定，或缺少放弃方案 / 后果类章节 |
| 单篇超长 | 提示 | 超过 15 KB 或 250 行，提醒检查是否混入过程流水账 |
| 编号间断 | 汇总提示 | 仅报告缺失号段，不判错 |

存在「错误」时退出码为 `1`；无错误时退出码为 `0`（传入 `--strict` 时存在「警告」也返回 `1`）。

## 目录结构

```text
SKILL.md                 准入表、格式规范、演进边界与自查入口
README.md                使用说明与脚本检查项
references/rules.md      准入边界、状态机、互链规范、大重构拆步与文档分层细则
references/examples.md   脱敏的 bad→good 对照与常见症状表
scripts/check-adr        只读体检与取号脚本（Python 3 标准库，零外部依赖）
```
