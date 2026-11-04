# Neovim Configuration for Ubuntu Server (x86_64)

This repository contains your complete Neovim configuration, customized and optimized specifically for an **Ubuntu Linux server running on x86_64 architecture**.

---

## 🚀 Key Adaptations for Ubuntu Server (x86_64) vs macOS (Apple Silicon)

1. **Strict Case Sensitivity (`engram`)**:
   - On macOS, the filesystem is case-insensitive, where `lua/Engram` and `lua/engram` match interchangeably.
   - On Ubuntu Linux (`ext4`), filesystems are strictly case-sensitive. The entire folder structure has been normalized to `lua/engram/` to prevent `module 'engram.core' not found` errors.

2. **Server & SSH Clipboard (OSC 52 Integration)**:
   - On macOS, Neovim relies on native `pbcopy` / `pbpaste`.
   - On a remote Ubuntu server accessed over SSH, traditional X11/Wayland clipboard tools (`xclip`/`wl-copy`) often fail or hang when no display server is present.
   - Configured with automatic **OSC 52 clipboard fallback** in Neovim: when connected via SSH, yanking text (`y`, `p`, etc.) sends terminal escape sequences that copy directly into your local machine's clipboard.
   - Added universal `<leader>y` and `<leader>Y` bindings to yank to system clipboard from any terminal.

3. **Neovim Modern Version Requirement (>= 0.10+ / 0.11+)**:
   - The default `apt install neovim` on Ubuntu 22.04 LTS installs Neovim 0.6, and Ubuntu 24.04 LTS installs 0.9.5.
   - This configuration relies on modern APIs (`vim.uv`, `vim.lsp.config`, `vim.lsp.enable`, `vim.hl.on_yank`).
   - The included `install.sh` script automatically installs the official latest release of Neovim (`nvim-linux-x86_64`) into `/usr/local/bin`.

4. **Linux-Compatible System Dependencies**:
   - Automatically handles Linux equivalents for tools:
     - `fd-find` (symlinked as `fd`)
     - `build-essential` (`gcc`, `g++`, `make`) for building `telescope-fzf-native` and `LuaSnip` C-regex bindings
     - `ripgrep` for Telescope search and `todo-comments`
     - Node.js LTS and Python3 `venv` support for Mason-installed language servers and formatters
     - Lazygit binary for `x86_64` Linux
     - Updated protobuf search paths to include `/usr/include` for `protols` on Debian/Ubuntu

---

## 📦 How to Transfer to your Ubuntu Server

### Option A: Via `scp` (Secure Copy)
From your Mac terminal, run:
```bash
scp -r /Users/emre/.config/nvim/ubuntu_nvim_config user@your-server-ip:~/ubuntu_nvim_config
```

### Option B: Via `rsync`
```bash
rsync -avz /Users/emre/.config/nvim/ubuntu_nvim_config/ user@your-server-ip:~/.config/nvim/
```

### Option C: Via Git Repository
You can push this directory to a private GitHub/GitLab repository and clone it directly to your server:
```bash
git clone <your-repo-url> ~/.config/nvim
```

---

## ⚡ Quick 1-Command Installation on Ubuntu

Once the files are on your Ubuntu server, run the automated installation script:

```bash
cd ~/ubuntu_nvim_config
chmod +x install.sh
./install.sh
```

### What `install.sh` does:
1. Installs all required Ubuntu packages (`build-essential`, `ripgrep`, `fd-find`, `curl`, `git`, `python3-venv`, etc.).
2. Creates the `fd` alias for `fdfind`.
3. Installs Node.js LTS (required by Mason language servers) if missing.
4. Installs the modern `x86_64` release of Neovim into `/usr/local/bin/nvim`.
5. Installs the latest `lazygit` binary.
6. Backs up any pre-existing `~/.config/nvim` and copies this configuration in place.
7. Clones `lazy.nvim` and triggers a headless plugin sync.

---

## 🛠 Manual Installation (If you prefer not using the script)

1. **Install system packages:**
   ```bash
   sudo apt update
   sudo apt install -y build-essential gcc g++ make git curl wget unzip tar ripgrep fd-find python3 python3-pip python3-venv xclip
   sudo ln -sf $(which fdfind) /usr/local/bin/fd
   ```

2. **Install modern Neovim (x86_64):**
   ```bash
   curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
   sudo rm -rf /opt/nvim-linux-x86_64
   sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
   sudo ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
   rm nvim-linux-x86_64.tar.gz
   ```

3. **Deploy the configuration:**
   ```bash
   mkdir -p ~/.config/nvim
   cp -r * ~/.config/nvim/
   ```

4. **Launch Neovim:**
   ```bash
   nvim
   ```
   Plugins will automatically install via Lazy.nvim upon first startup.

---

## ⌨️ Essential Keymaps Reference

| Keymap | Mode | Description |
|---|---|---|
| `<Space>` | - | Leader Key |
| `<leader>ee` | Normal | Toggle NvimTree file explorer |
| `<leader>ff` | Normal | Telescope find files |
| `<leader>fs` | Normal | Telescope live grep (ripgrep) |
| `<leader>fr` | Normal | Telescope recent files |
| `<leader>th` | Normal | Telescope theme selector & auto-save |
| `<leader>lg` | Normal | Open LazyGit floating window |
| `<leader>y` | Normal/Visual | Yank to system clipboard (works over SSH) |
| `<leader>mp` | Normal/Visual | Format file/range with Conform |
| `gd` | Normal | LSP go to definition |
| `gR` | Normal | LSP show references in Telescope |
| `K` | Normal | LSP hover documentation |
| `<leader>rn` | Normal | LSP smart rename |
| `<leader>d` | Normal | Show line diagnostics float |
| `<leader>rsl`| Normal | Restart LSP server |
| `<leader>1-3`| Normal | Harpoon jump to marked file 1, 2, or 3 |
| `<leader>ha` | Normal | Harpoon add current file |
| `<leader>hl` | Normal | Harpoon list / menu |

---

## 🔍 Verification & Health Check

After launching Neovim on your server, you can verify everything is working with:
- `:Lazy` — Inspect plugin status
- `:Mason` — Inspect language servers, linters, and formatters
- `:checkhealth` — Verify Neovim system health and clipboard provider
