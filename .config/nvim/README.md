# Neovim Configuration

LazyVim ベースの設定

## Troubleshooting

### 2026-01-23: nvim が SIGKILL でクラッシュ + cmdline モードでエラー

#### 症状

- ヤンク、ペースト、検索、`:w` などで nvim が突然終了する
- cmdline モード (`:`) を開くと tree-sitter エラーが出る
  ```
  Query error at 113:4. Invalid node type "tab"
  ```

#### 原因

2つの問題が同時に発生していた：

1. **tree-sitter パーサーのコード署名問題**
   - `~/.local/share/nvim/site/parser/*.so` ファイルのコード署名が壊れていた
   - macOS (Apple Silicon) のセキュリティ機能が不正な署名を検出し、nvim を SIGKILL で強制終了
   - クラッシュレポート: `~/Library/Logs/DiagnosticReports/nvim-*.ips`
   - エラー内容: `SIGKILL (Code Signature Invalid)`, `termination: CODESIGNING, Invalid Page`

2. **nvim-treesitter と nvim 0.11.5 の互換性問題**
   - `nvim-treesitter` の vim 用クエリファイル (`highlights.scm`) が `"tab"` というノードタイプを参照
   - nvim 0.11.5 の vim パーサーではこのノードタイプが存在しない
   - `noice.nvim` が cmdline をハイライトしようとしてエラー

#### 対応

1. **パーサーの再インストール**
   ```bash
   rm -rf ~/.local/share/nvim/site/parser/
   nvim --headless "+TSUpdate" "+qa"
   ```

2. **クエリファイルの修正**
   ```bash
   # 113行目の "tab" をコメントアウト
   sed -i '' '113s/^/; /' ~/.local/share/nvim/lazy/nvim-treesitter/runtime/queries/vim/highlights.scm
   ```

#### 注意

- `nvim-treesitter` をアップデートするとクエリファイルの修正が上書きされる
- 本家で修正されるまでは、アップデート後に再度 sed コマンドを実行する必要がある可能性あり

#### 関連 Issue

**noice.nvim (SIGKILL 問題の報告)**
- https://github.com/folke/noice.nvim/issues/1182
- https://github.com/folke/noice.nvim/issues/1184

**nvim-treesitter (vim クエリの "tab" 問題) ← これを追う**
- https://github.com/nvim-treesitter/nvim-treesitter/issues/8381
- https://github.com/nvim-treesitter/nvim-treesitter/issues/8369
- https://github.com/nvim-treesitter/nvim-treesitter/issues/8373

上記 issue は closed だが、最新版でも修正が反映されていない場合がある。
`:Lazy update nvim-treesitter` で更新後も問題が続く場合は sed での修正を再適用する。
