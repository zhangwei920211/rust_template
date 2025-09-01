#!/usr/bin/env sh
# POSIX-compatible post hook for cargo-generate

cat <<'EOF'

🎉 Project {{project-name}} created successfully!

📁 Project structure:
   ├── src/          # Source code
   ├── tests/        # Integration tests
   ├── examples/     # Example code
   └── assets/       # Static assets

🚀 Next steps:
   1. cd {{project-name}}
   2. cargo check     # Verify compilation
   3. cargo test      # Run tests
   4. cargo run       # Run the project

🔧 Optional setup:
   - git init && git add . && git commit -m "Initial commit"
   - pre-commit install  # Setup pre-commit hooks
   - cargo doc --open    # Generate and view docs

📚 Learn more: https://doc.rust-lang.org/book/

EOF
