# commit-message

git 提交信息规范 skill：`type(scope): 中文标题（≤50 字符）` + 条件强制正文 + `Refs`/`Verified`/`Co-authored-by` trailer，附带零依赖 `commit-msg` 校验 hook 和只读历史体检脚本。

## 安装 hook

```sh
~/.agents/skills/commit-message/scripts/install.sh
```

做两件事：把三个 hook 软链到 `~/.githooks/`，再 `git config --global core.hooksPath ~/.githooks`。

- 脚本留在 skill 目录里，`~/.githooks` 只放软链 —— skill 搬家（比如挂到 magpie 的 library）后只需重跑 `install.sh`，各仓库配置一行不动。
- 全局生效意味着**所有仓库**都被校验，包括 clone 来的别人的项目。`pre-commit` 转发器保住了它们自带的 `.git/hooks/pre-commit`，但只转发这一个 hook。
- 撤销：`git config --global --unset core.hooksPath`。

## 校验什么、不校验什么

| 规则 | 拦截 | 说明 |
|---|---|---|
| `type(scope): 说明` 结构 | ✅ | type 白名单 11 个，scope 必填 |
| 标题 ≤ 50 字符 | ✅ | 中文字符，不是字节 |
| 空泛标题（「更新」「测试」「1」） | ✅ | |
| 改动 > 100 行必须有正文 | ✅ | 读 `git diff --cached --numstat` |
| 提到工单号必须有 `Refs:` | ✅ | `[ABC-123]` 和 `#123` 都算 |
| 标题语言是中文 | ❌ | 对外开源仓库需要英文，只在 `check-log` 里统计 |
| 正文写得有没有用 | ❌ | 机器判断不了，靠 `references/examples.md` |

`Merge` / `Revert` / `fixup!` / `squash!` 直接放行。

## 体检历史

```sh
scripts/check-log                      # 默认扫当前目录
scripts/check-log /path/to/repos --limit=500
```

只读。按结构、长度、空泛、文件名当标题、工单占标题五类统计，给出净合规率和最该改的几条。

## 挂到 magpie

本技能现位于多技能仓库的 `skills/commit-message/` 子目录下。

若此前通过 `magpie library skill hand-over` 迁入，或从旧的单技能根目录结构安装，`library.json` 中的来源路径会失效或缺少 `from` / `source` 字段，导致 `magpie library skill update` 无法自动拉取更新。切换到本仓库后按以下步骤重装一次：

1. 在 magpie App 的 Library 页移除旧的 `commit-message`
2. 同一页从本仓库添加 `skills/commit-message`（CLI 没有 install 命令）
3. `magpie library skill agents commit-message agy,antigravity,claude,codex,cursor,gemini,pi`
4. `magpie library sync`，然后重跑 `scripts/install.sh`

装好后 `library.json` 会记录对应 GitHub 仓库与 `skills/commit-message` 子路径，`update` / `auto-update` 即生效。

安装目录名保持不变（仍在 `~/.config/magpie/library/skills/commit-message`），但重装会重新拉取目录，**装完务必重跑 `install.sh` 并试一次提交**，确认 `~/.githooks` 软链没有悬空。

### frontmatter 的两个坑（实测）

1. **description 里不能出现半角「冒号 + 空格」**。`type(scope): 说明` 这种写法会让 YAML 把值截断，magpie 解析失败后索引里只剩名字，描述整段丢失。用全角或改写措辞。
2. **索引只取 description 的第一句，且截断在 80 字符**。触发词必须挤进前 80 字符以内，第二个句子之后的内容不参与索引。当前这条正卡在 78 字符。

## 结构

```
SKILL.md                 判定表与边界
references/rules.md      规则全文：type/scope 词典、长度、拆与不拆、trailer、机器提交
references/examples.md   7 条真实 bad→good 对照
scripts/commit-msg       校验 hook（POSIX sh）
scripts/prepare-commit-msg  编辑器里的注释模板
scripts/pre-commit       转发器，保住其它仓库自带的 pre-commit
scripts/install.sh       装 hook
scripts/check-log        历史体检（python3 标准库）
```
