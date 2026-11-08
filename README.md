# book-skills

用 [cangjie](https://github.com/...) 蒸馏的「书籍 → skill」集合仓库，作为手机 / PC / 网页 / 云沙箱之间共享的单一可信源。

## 目录结构

```
book-skills/
├── .gitignore            # 忽略 .cangjie 缓存、原始书稿(*.pdf/epub/full_text.txt)、日志等
├── README.md             # 本文件
├── registry.json         # 书单索引（发现 / 同步用）
├── books/                # 每本书一个目录
│   └── <slug>/           # ASCII 短名，如 conflict-strategy
│       ├── README.md     # 该书说明 + 蒸馏元数据
│       ├── DIGEST.md     # 精华长文（可独立阅读）
│       ├── GLOSSARY.md   # 术语词典
│       ├── skill/        # ← 可安装包：含 SKILL.md 的目录，拷到宿主 skills/ 即用
│       │   ├── SKILL.md
│       │   ├── BUILD_MANIFEST.json
│       │   └── references/
│       └── source/       # 中间产物（默认不提交，见 .gitignore）
└── scripts/
    └── install.ps1       # 把 books/<slug>/skill 链接到 ~/.workbuddy/skills/<slug>
```

约定：

- **slug 用 ASCII 短名**（kebab-case）。仓库要在多端共享，非 ASCII 目录名在 URL / 某些 shell / 压缩同步里易乱码；完整中文书名只写在 `registry.json` 和该书 `README.md`。
- **只提交可分发物**：`skill/` 包 + `{README,DIGEST,GLOSSARY}.md` + `registry.json`。cangjie 的工作树（`.cangjie/`、`candidates/`、`rejected/`、`PIPELINE_STATE.md`、原始书稿 `full_text.txt` 等）默认不提交，保持仓库轻量、跨设备同步快。
- **两种形态都兼容**：`single` 时 `skill/` 直接是那一个包；`pack` 时 `skill/` 里是父 `SKILL.md` + 多个子技能目录，结构不变。

## 安装到 WorkBuddy

在 Windows 上（需要已开启开发者模式或管理员，才能建符号链接；脚本默认用不需要管理员权限的 junction）：

```powershell
cd E:\WorkBuddy\book-skills
pwsh scripts/install.ps1
```

脚本会遍历 `books/*/skill`，为每个 `<slug>` 在 `%USERPROFILE%\.workbuddy\skills\<slug>` 建一个 junction 指向仓库里的 `skill/` 目录。之后**重启 WorkBuddy** 即可加载。

> 换设备：克隆仓库 → 跑一次 `install.ps1` 即可。

## 新增一本书

1. 用 cangjie 蒸馏，得到可安装包（含 `SKILL.md` 的目录）与 `DIGEST.md` / `GLOSSARY.md`。
2. 在 `books/<slug>/` 下放文档，包放进 `books/<slug>/skill/`。
3. 在 `registry.json` 的 `books` 数组追加一条。
4. 提交：`git add books/<slug> registry.json && git commit`。
