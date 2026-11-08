# 《冲突的战略》蒸馏产物（single 形态）— 云端交付包

由 cangjie-skill v2.5.0 (RIA-TV++) 从《冲突的战略》(Thomas C. Schelling, 1960 / 中译 赵华) 蒸馏。

## 包含

- `conflict-strategy/` —— 编译后的 **single 技能包**（1 个入口 `SKILL.md` + 8 张能力卡 in `references/capabilities/` + 速查/术语/概览 references）。
  安装方式：复制此目录到宿主 `skills/` 目录（如 `~/.codebuddy/skills/` 或 `.claude/skills/`）。
- `DIGEST.md` —— 精华长文（约 6500 字），给"不想读全书但想看精华"的读者。
- `GLOSSARY.md` —— 术语词典（作者用法 vs 常识差异）。

## 8 个能力

1. bargaining-game 冲突结构诊断
2. credible-commitment 可信承诺
3. threat-vs-promise 威胁 vs 允诺
4. focal-point 聚焦点/默式谈判
5. strategic-behavior 战略行为
6. randomized-commitment 随机化承诺
7. brinkmanship 边缘政策
8. deterrence-stability 消除突袭恐惧/稳定威慑

## 验证

- verified.yaml 通过 capability-bundle.schema.json 校验（8 卡全部存在, destination=router）。
- `validate_skill_pack.py` 硬门：0 errors / 0 warnings。
- 阶段 4 压力测试：17 条用例, 静态路由核验 15/15 通过（活体触发评测列为后续 ratcheting）。

见 `PIPELINE_STATE.md` 了解完整阶段记录与待核查项。
