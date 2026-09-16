# AI Infra 学习项目

这是一个用于学习 AI Infrastructure、实践 CUDA 算子开发并保存跨会话项目记忆的长期项目。

项目包含本地收藏资料、管理文档、学习笔记、小型实验和一个贯穿学习过程的 CUDA 算子项目。新的 Codex 会话可以从版本库恢复上下文，而不依赖某一次聊天记录。

`.resources/` 由用户在本地维护并被 Git 忽略；其使用方法见[收藏资料使用指南](docs/RESOURCES.md)。构建产物、缓存和大型 Profiler 原始文件不纳入版本控制。

## 目录结构

```text
.
├── docs/          # 项目目标、路线、当前状态、决策和会话记忆
├── notes/         # 按日记录与按主题整理的学习笔记
├── experiments/   # 围绕单个问题设计的小型验证实验
├── projects/      # 持续演进、面向最终展示的贯穿项目
├── .tmp/          # 本地杂项与临时文件，不纳入 Git
└── .resources/    # 本地收藏资料，不纳入 Git
```

实验用于验证知识和假设，贯穿项目只接收整理后的稳定实现；项目不能依赖实验目录才能构建。

学习笔记由 Codex 根据实际学习表现自动整理；`.tmp/` 仅用于短期杂项，任何需要复现或长期保存的内容必须移入正式目录。

## 快速入口

- [项目目标与边界](docs/PROJECT.md)
- [当前状态与下一步](docs/CURRENT.md)
- [学习路线图](docs/ROADMAP.md)
- [关键决策记录](docs/DECISIONS.md)
- [会话交接日志](docs/SESSIONS.md)
- [文档索引与写作规范](docs/README.md)
- [收藏资料使用指南](docs/RESOURCES.md)
- [CUDA 算子开发学习路线](docs/cuda-learning-plan.md)
- [Transformer CUDA 算子库成果路线](docs/cuda-operator-roadmap.md)
- [学习笔记说明](notes/README.md)
- [实验目录说明](experiments/README.md)
- [贯穿项目](projects/transformer-cuda-kernels/README.md)
- [Codex 协作约定](AGENTS.md)

新参与者先读 `docs/PROJECT.md` 和 `docs/CURRENT.md`；新的 Codex 会话遵循 `AGENTS.md` 中的启动与收尾协议。
