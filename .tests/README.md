# Nerd Fonts Test Suite

This directory contains test scripts to verify Nerd Fonts are properly installed and rendering correctly in your terminal.

## Test Scripts

### smoke-test.sh
Quick smoke test for basic Nerd Font functionality.

**Coverage:**
- Text formatting (bold, italic, underline, ligatures)
- Basic Powerline symbols
- Common Nerd Font icons
- File type icons for popular languages
- Configuration file icons
- Folder icons

**Usage:**
```bash
make test-nerd-fonts  # or make test-smoke
```

### unicode-range-test.sh
Comprehensive Unicode range testing based on nerd-fonts test-fonts.sh.

**Coverage:**
- Seti-UI + Custom icons (U+e5fa - U+e6b5)
- Devicons (U+e700 - U+e7c5)
- Font Awesome (U+f000 - U+f2e0)
- Font Awesome Extension (U+e200 - U+e2a9)
- Material Design Icons (sample)
- Weather Icons (U+e300 - U+e3e3)
- Octicons (U+f400 - U+f532)
- Powerline Symbols (U+e0a0 - U+e0d4)
- Pomicons (U+e000 - U+e00a)
- Codicons/VS Code Icons (U+ea60 - U+ec1e)
- Font Logos/Linux (U+f300 - U+f32f)
- IEC Power Symbols

**Features:**
- Displays icons in table format with hex codes
- Color-coded backgrounds for better visibility
- Shows Unicode codepoint ranges

**Usage:**
```bash
make test-unicode
```

### icon-sets-test.sh
Comprehensive, categorized testing of all major icon sets.

**Categories:**
- ⚡ Powerline Symbols (arrows, separators, flames, etc.)
- 💻 Programming Languages (30+ languages)
- 🌐 Web Development (HTML, CSS, frameworks)
- ⚙️ Configuration Files (JSON, YAML, TOML, etc.)
- 🐚 Shell & Scripts (Bash, Zsh, Fish, Vim, etc.)
- 📦 Version Control & DevOps (Git, Docker, Kubernetes, etc.)
- 🗄️ Data & Databases (SQL, PostgreSQL, MongoDB, etc.)
- 📝 Documentation & Text (Markdown, PDF, LaTeX, etc.)
- 🔧 Build Tools (Make, CMake, Gradle, NPM, etc.)
- 📦 Archives & Binary Files
- 🎨 Media Files (images, video, audio, fonts)
- ⭐ Special & System Icons
- 🌤️ Weather Icons
- 🍎 Pomicons
- 🐧 Linux & OS Icons
- 📟 Codicons (VS Code icons)

**Usage:**
```bash
make test-icons
```

## Running All Tests

To run all tests sequentially:

```bash
make test-all
```

This will execute:
1. Smoke test (basic verification)
2. Unicode range test (comprehensive ranges)
3. Icon sets test (categorized icons)

## Troubleshooting

If you see boxes (□) or missing characters:

1. **Install a Nerd Font:**
   ```bash
   make install-fonts
   ```

2. **Configure your terminal:**
   - Set your terminal font to a Nerd Font (e.g., "Hack Nerd Font", "JetBrains Mono Nerd Font")
   - In iTerm2: Preferences → Profiles → Text → Font
   - In Terminal.app: Preferences → Profiles → Font
   - In VS Code: Settings → Terminal › Integrated: Font Family

3. **Restart your terminal application**

## Available Nerd Fonts

The Makefile will install these fonts by default:
- JetBrains Mono Nerd Font
- Fira Code Nerd Font
- Hack Nerd Font
- Meslo LG Nerd Font

You can customize this by setting the `NERD_FONTS` variable:
```bash
make install-fonts NERD_FONTS="font-hack-nerd-font font-victor-mono-nerd-font"
```

## Reference

These tests are based on the official nerd-fonts test script:
https://github.com/ryanoasis/nerd-fonts/blob/master/bin/scripts/test-fonts.sh
