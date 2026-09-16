# Transformer CUDA Kernels Lab

这是贯穿 CUDA 算子开发学习路线的迷你 Transformer 算子库。当前处于 M0 启动前，代码和构建系统尚未建立；目录先固定职责，具体文件随里程碑逐步加入。

项目目标、里程碑和完成标准见[项目成果路线](../../docs/cuda-operator-roadmap.md)，对应知识路线见[CUDA 学习规划](../../docs/cuda-learning-plan.md)。

## 目录职责

```text
transformer-cuda-kernels/
├── include/       # 项目公共或跨源文件使用的 C++/CUDA 声明
├── src/           # 稳定的 C++/CUDA 实现
├── tests/         # 正确性、边界和回归测试
├── benchmarks/    # 统一性能基准入口与配置
├── python/        # M5 起加入的 PyTorch/Python 接口
├── docs/          # 项目设计、算子说明和最终性能报告
└── results/       # 可提交的小型汇总数据和图表
```

构建系统、命名空间、测试框架和 Python 打包方式在 M0/M5 的真实需求出现时决定，不提前生成空配置。

## 内容边界

- `src/` 不直接复制实验代码；实验结论确认后再整理为项目实现。
- `tests/` 先于性能优化建立，并覆盖非规则形状和明确的误差容差。
- `benchmarks/` 与 `tests/` 分离，Benchmark 不承担正确性验证。
- `results/` 只提交能够支持项目结论的小型结果；原始大型 Profiler 文件留在本机。
- 项目不依赖 `notes/` 或 `experiments/` 才能构建运行，但文档可以链接它们解释学习与决策过程。
