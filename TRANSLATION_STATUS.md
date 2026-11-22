# 翻译状态（TRANSLATION_STATUS.md）

## 项目元数据

| 项目 | 值 |
| --- | --- |
| 上游仓库（Upstream URL） | <https://github.com/qmlbook/qt6book.git> |
| 基线分支（Base branch） | `main` |
| 基线提交（Base commit SHA） | `3e7d97a5a11f368a3b9f58ace3fd6e70cb461282` |
| 翻译分支（Translation branch） | `translation/zh-CN` |
| 初始化日期 | 2026-11-22 |
| 发现的可翻译 Markdown 文件数 | 137 |
| 基线构建命令 | `yarn run docs:build`（需加环境变量，见下方“构建记录”） |
| 基线构建结果 | PASS（带 `NODE_OPTIONS=--openssl-legacy-provider`；裸命令在 Node 24 下为环境性失败，见“构建记录”） |

### 构建环境

| 项目 | 值 |
| --- | --- |
| 操作系统 | Windows (win32) |
| Node.js | v24.22.1 |
| Yarn | 1.22.22（classic，匹配 `yarn.lock` v1） |
| VuePress | ^1.8.2（来自 `package.json`） |
| 包管理约定 | 使用现有 `yarn.lock`，不升级依赖 |

### 文件计数说明

`docs/` 下 Markdown 文件共 138 个，其中
`docs/ch18-extensions/src/CityUI/LICENSE.md` 为许可证文件（超出翻译范围），
故可翻译文件数为 **137**。计数由仓库内文件检索得出，非硬编码。

## 目标进度表

翻译状态取值：`NOT STARTED` / `IN PROGRESS` / `TRANSLATED`。
审查状态取值：`NOT REVIEWED` / `REVIEWED`。

| 目标（Target） | 文件数 | 翻译状态 | 审查状态 | 构建状态 | 提交 SHA | 备注 |
| --- | --- | --- | --- | --- | --- | --- |
| `docs/index.md` | 1 | TRANSLATED | NOT REVIEWED | BASELINE PASS | dda25cc | 推荐顺序第 1 项；批次 B01 |
| `docs/preface` | 3 | TRANSLATED | NOT REVIEWED | N/A | 9f6ec64 | 批次 B02 |
| `docs/ch01-meetqt` | 3 | TRANSLATED | NOT REVIEWED | N/A | 6727ab3 | 批次 B03 |
| `docs/ch02-start` | 5 | TRANSLATED | NOT REVIEWED | N/A | bbd74cf | 批次 B04 |
| `docs/ch03-qtcreator` | 8 | TRANSLATED | NOT REVIEWED | N/A | ecb005c | 批次 B05 |
| `docs/ch04-qmlstart` | 9 | TRANSLATED | NOT REVIEWED | N/A | 879d520 | 学习优先目标；批次 B06 |
| `docs/ch05-fluid` | 4 | TRANSLATED | NOT REVIEWED | N/A | 4f6bc0a | 批次 B07（重试后顺序完成） |
| `docs/ch06-controls` | 6 | TRANSLATED | NOT REVIEWED | N/A | 1b69091 | 学习优先目标；批次 B08 |
| `docs/ch07-modelview` | 7 | TRANSLATED | NOT REVIEWED | N/A | e6e5631 | 学习优先目标；批次 B09 |
| `docs/ch08-canvas` | 10 | NOT STARTED | NOT REVIEWED | N/A | — | |
| `docs/ch09-shapes` | 6 | NOT STARTED | NOT REVIEWED | N/A | — | |
| `docs/ch10-effects` | 15 | NOT STARTED | NOT REVIEWED | N/A | — | |
| `docs/ch11-multimedia` | 6 | NOT STARTED | NOT REVIEWED | N/A | — | |
| `docs/ch12-qtquick3d` | 7 | NOT STARTED | NOT REVIEWED | N/A | — | |
| `docs/ch13-networking` | 9 | NOT STARTED | NOT REVIEWED | N/A | — | |
| `docs/ch14-storage` | 3 | NOT STARTED | NOT REVIEWED | N/A | — | |
| `docs/ch15-dynamicqml` | 5 | NOT STARTED | NOT REVIEWED | N/A | — | |
| `docs/ch16-javascript` | 5 | NOT STARTED | NOT REVIEWED | N/A | — | |
| `docs/ch17-qtcpp` | 6 | TRANSLATED | NOT REVIEWED | N/A | dc007ac | 学习优先目标；批次 B10（卡死后顺序完成） |
| `docs/ch18-extensions` | 7 | NOT STARTED | NOT REVIEWED | N/A | — | 不含 `src/CityUI/LICENSE.md` |
| `docs/ch19-python` | 6 | NOT STARTED | NOT REVIEWED | N/A | — | |
| `docs/ch20-qtformcu` | 6 | NOT STARTED | NOT REVIEWED | N/A | — | |
| `docs/.vuepress/config.js` 导航标签 | 1 | NOT STARTED | NOT REVIEWED | N/A | — | 仅读者可见导航文案 |
| 根目录中文文档（`README.zh-CN.md` 等） | 3 | TRANSLATED | NOT REVIEWED | BASELINE PASS | — | INIT 创建；全书完成后终审 |

文件数合计：137（可翻译 Markdown）+ 1（config.js 导航）+ 3（根目录中文文档）。

## 当前进行中目标

`none`（本次 INIT 运行不翻译章节。）

## 构建记录

| 日期 | 命令 | 退出状态 | 说明 |
| --- | --- | --- | --- |
| 2026-11-22 | `yarn install --frozen-lockfile` | 0（成功，92.71s） | 按现有 `yarn.lock` 安装依赖，未升级、未改动锁文件 |
| 2026-11-22 | `yarn run docs:build` | 1（失败） | **环境性失败**：Node.js v24.22.1 的 OpenSSL 3 拒绝 webpack 4 的 md4 哈希，报 `ERR_OSSL_EVP_UNSUPPORTED`（`error:0308010C:digital envelope routines::unsupported`）。在未修改的基线提交上即可复现，与翻译无关。未改动任何依赖或源码。 |
| 2026-11-22 | `NODE_OPTIONS=--openssl-legacy-provider yarn run docs:build` | 0（成功，35.29s） | **基线构建通过**。输出：`√ Server: Compiled successfully in 13.90s`、`√ Client: Compiled successfully in 21.89s`、`success Generated static files in docs\.vuepress\dist.`。构建期警告均为上游固有：`Browserslist: caniuse-lite is outdated`、`Language does not exist: h/txt/vert/frag/conf`（棱镜对未知代码块语言标签的提示）、`[DEP0187]` 弃用警告。 |

后续运行构建时请使用：
`$env:NODE_OPTIONS='--openssl-legacy-provider'; yarn run docs:build`（PowerShell），
或在 cmd 中先 `set NODE_OPTIONS=--openssl-legacy-provider`。这是环境兼容性
workaround，不修改 `package.json`、`yarn.lock` 或任何上游源文件。

## 已知阻塞与未决术语

- 阻塞：无。
- 未决术语：无（见 `GLOSSARY.zh-CN.md` 的“待决术语”一节）。
- 注意：`README.md` 作者姓名 “Jürgen Bocklage-Ryannel” 在部分终端输出中出现
  乱码（编码显示问题），以 Git 历史与上游内容为准，不影响翻译。
