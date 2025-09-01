# WARP.md

本文件为使用 WARP (warp.dev) 在本仓库中协作开发提供指导。

## 项目概述

这是极客邦 Rust 语言训练营的模板仓库。它作为创建新 Rust 项目的基础模板，集成了完善的开发工具链和质量保障流程。

## 架构

本模板提供：
- **基础 Rust 项目结构**，以 `src/main.rs` 作为入口
- **全面的质量保障工具链**，通过 pre-commit 钩子集成
- **GitHub Actions CI/CD 流水线**，实现格式化、静态检查、测试和自动发布
- **开发工具配置**，涵盖代码质量、安全扫描和变更日志生成

## 基本命令

### 项目初始化
```bash
# 基于本模板生成新项目
cargo generate --git https://github.com/zhangwei920211/rust_template

# 安装开发依赖（仅需一次）
cargo install cargo-generate cargo-deny typos-cli git-cliff cargo-nextest --locked
pipx install pre-commit
pre-commit install
```

### 开发流程
```bash
# 构建项目
cargo build

# 运行应用
cargo run

# 格式化代码
cargo fmt

# basic.rs

主要作用是作为 Rust 项目的示例程序（example），用于演示项目的用法、测试特定功能或为用户/开发者提供参考代码。

具体说明如下：

放在 examples 目录下的文件，可以通过 cargo run --example basic 命令单独编译和运行，不会影响主程序。
适合用来写教程、文档示例、API用法演示，或临时验证某些代码片段。
不会被主项目自动编译，只有显式运行时才会编译。
便于新手或团队成员快速了解项目的基本用法和接口调用方式。
简单来说，basic.rs 是一个“可运行的代码示例”，既方便演示，也方便开发调试。

# 运行静态检查
cargo clippy --all-targets --all-features --tests --benches -- -D warnings

# 运行测试（使用 nextest）
cargo nextest run --all-features

# 检查安全漏洞和许可证问题
cargo deny check

# 检查拼写错误
typos

# 运行所有质量检查（通过 pre-commit）
pre-commit run --all-files
```

### 测试命令
```bash
# 运行所有测试
cargo nextest run --all-features

# 运行指定模块的测试
cargo nextest run --all-features -E 'test(module_name)'

# 运行单个测试
cargo nextest run --all-features -E 'test(test_function_name)'

# 标准 cargo test（备用）
cargo test
```

### 发布与变更日志
```bash
# 生成变更日志
git cliff --output CHANGELOG.md

# 仅生成最新版本的变更日志
git cliff --latest --strip header
```

## 质量保障流程

本模板通过自动化检查严格保障代码质量：

### Pre-commit 钩子
本仓库使用 pre-commit 钩子自动执行：
- **代码格式化**（`cargo fmt`）
- **静态检查**（`cargo clippy`）
- **安全与依赖检查**（`cargo deny`）
- **拼写检查**（`typos`）
- **编译验证**（`cargo check`）
- **测试执行**（`cargo nextest`）

### GitHub Actions CI
CI 流水线（`build.yml`）在以下情况下触发：
- **推送到 master 分支**
- **向 master 分支的 Pull Request**
- **创建标签**（触发发布）

CI 步骤包括所有 pre-commit 检查，以及：
- **多平台测试**（目前为 Ubuntu）
- **代码覆盖率**（通过 cargo-llvm-cov）
- **自动发布**及变更日志生成

## 配置文件

### 核心 Rust 配置
- `Cargo.toml` - 项目元数据与依赖
- `Cargo.lock` - 依赖锁定文件

### 质量保障工具
- `deny.toml` - cargo-deny 配置，安全与许可证检查
- `_typos.toml` - typos 配置，排除 CHANGELOG.md 和 notebooks
- `.pre-commit-config.yaml` - pre-commit 钩子定义
- `cliff.toml` - git-cliff 配置，生成变更日志

### 开发规范
- **提交信息**应遵循 [Conventional Commits](https://www.conventionalcommits.org/)
- **中文提交信息**在生成变更日志时会被跳过
- **所有代码必须通过**格式化、静态检查和测试后方可提交
- **依赖项需严格验证**安全性和许可证

## 开发环境

### 所需工具
本模板要求安装以下工具：
- **Rust 工具链**（稳定版，含 llvm-tools-preview）
- **cargo-nextest** - 高级测试运行器
- **cargo-deny** - 依赖安全扫描
- **typos-cli** - 拼写检查工具
- **git-cliff** - 变更日志生成器
- **pre-commit** - Git 钩子管理器

### 编辑器集成
README 推荐 VSCode 扩展，包括：
- rust-analyzer、Rust Test lens、Rust Test Explorer
- Error Lens、GitLens、GitHub Copilot
- 其他格式化和实用扩展

## 测试策略

- 以 **cargo-nextest** 作为主要测试运行器，提升性能与输出体验
- 支持 **特性门控测试**，可用 `--all-features`
- 集成 **pre-commit 钩子**，防止提交损坏代码
- **CI 流水线**跨目标平台验证测试

开发时请始终运行 `cargo nextest run --all-features`，确保与 CI 环境兼容。
