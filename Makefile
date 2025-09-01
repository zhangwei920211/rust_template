# Makefile for {{project-name}}
# 常用开发任务的快捷命令

.PHONY: help build test check fmt clippy clean doc bench install audit coverage release pre-commit

# 默认目标：显示帮助信息
help:
	@echo "Available commands:"
	@echo "  build    - Build the project"
	@echo "  test     - Run all tests"
	@echo "  check    - Run cargo check"
	@echo "  fmt      - Format code with rustfmt"
	@echo "  clippy   - Run clippy linter"
	@echo "  clean    - Clean build artifacts"
	@echo "  doc      - Generate documentation"
	@echo "  bench    - Run benchmarks"
	@echo "  install  - Install development tools"
	@echo "  audit    - Run security audit"
	@echo "  coverage - Generate test coverage report"
	@echo "  release  - Build release version"
	@echo "  pre-commit - Run pre-commit hooks"

# 构建项目
build:
	cargo build --all-features

# 运行测试
test:
	cargo nextest run --all-features

# 检查代码
check:
	cargo check --all-targets --all-features

# 格式化代码
fmt:
	cargo fmt --all

# 运行 Clippy
clippy:
	cargo clippy --all-targets --all-features -- -D warnings

# 清理构建产物
clean:
	cargo clean

# 生成文档
doc:
	cargo doc --all-features --no-deps --open

# 运行基准测试
bench:
	cargo bench --all-features

# 安装开发工具
install:
	cargo install cargo-nextest
	cargo install cargo-audit
	cargo install cargo-deny
	cargo install cargo-llvm-cov
	cargo install typos-cli
	cargo install git-cliff

# 安全审计
audit:
	cargo audit
	cargo deny check

# 生成测试覆盖率报告
coverage:
	cargo llvm-cov nextest --all-features --html

# 构建发布版本
release:
	cargo build --release --all-features

# 运行 pre-commit hooks
pre-commit:
	pre-commit run --all-files

# 快速检查（格式化 + Clippy + 测试）
quick-check: fmt clippy test

# 完整检查（所有检查项目）
full-check: fmt clippy test audit coverage

# 初始化开发环境
init:
	rustup component add rustfmt clippy llvm-tools-preview
	pre-commit install
	@echo "Development environment initialized!"

# 更新依赖
update:
	cargo update

# 显示项目状态
status:
	@echo "=== Project Status ==="
	@echo "Rust version: $$(rustc --version)"
	@echo "Cargo version: $$(cargo --version)"
	@echo "Project name: {{project-name}}"
	@echo "Features: $$(grep '^default.*=' Cargo.toml || echo 'none')"
