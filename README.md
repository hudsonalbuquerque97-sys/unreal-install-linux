# Unreal Linux Installer (Patch 227k)

[🇧🇷 Português](#português) | [🇺🇸 English](#english)

---

## Português

### 📋 Descrição

Script automatizado para converter uma instalação do **Unreal (original)** do Wine para versão nativa Linux, aplicando o patch 227k da OldUnreal.

### ⚠️ IMPORTANTE

- ✅ **Compatível:** Unreal (versão original)
- ❌ **NÃO compatível:** Unreal Gold, Unreal Gold + Return to Na Pali

Este patch é **exclusivo** para o Unreal original. Se você possui Unreal Gold, deve jogá-lo via Wine/Proton.

### 📦 Pré-requisitos

#### 1. Ter uma cópia legítima do Unreal

Você precisa possuir o jogo através de:
- GOG.com
- Steam
- CD/DVD original
- Archive.org (versões abandonware/preservação)
- Outra loja digital oficial

**Nota:** O Archive.org mantém cópias para preservação histórica de jogos antigos.

#### 2. Instalar o Unreal no Wine PRIMEIRO

**Antes de executar este script**, você deve:

1. Instalar o Wine no seu sistema:
```bash
sudo apt install wine winetricks  # Debian/Ubuntu
sudo dnf install wine              # Fedora
```

2. Instalar o Unreal através do Wine:
   - **GOG:** Execute o instalador `.exe` com Wine
   - **Steam:** Use o Proton ou instale o Steam no Wine
   - **CD:** Monte o CD e execute o instalador com Wine

3. Certificar-se de que o jogo está em:
```
~/.wine/drive_c/Unreal/
```

#### 3. Dependências do sistema

```bash
sudo apt install wget tar imagemagick  # Debian/Ubuntu
sudo dnf install wget tar ImageMagick  # Fedora
sudo pacman -S wget tar imagemagick    # Arch Linux
```

### 🚀 Como usar

#### Instalação rápida (um comando):

```bash
wget https://raw.githubusercontent.com/hudsonalbuquerque97-sys/unreal-install-linux/refs/heads/main/unreal-install-linux-patch227k.sh && chmod +x unreal-install-linux-patch227k.sh && ./unreal-install-linux-patch227k.sh
```
-
#### Ou passo a passo:

1. **Baixe o script:**
```bash
wget https://raw.githubusercontent.com/hudsonalbuquerque97-sys/unreal-install-linux/refs/heads/main/unreal-install-linux-patch227k.sh
```

2. **Torne-o executável:**
```bash
chmod +x unreal-install-linux-patch227k.sh
```

3. **Execute o script:**
```bash
./unreal-install-linux-patch227k.sh
```

4. **Digite a senha quando solicitado** (necessário para criar o launcher global)

### 📂 O que o script faz

1. ✅ Verifica dependências necessárias
2. ✅ Localiza instalação do Unreal no Wine
3. ✅ Copia arquivos para `~/Games/Unreal`
4. ✅ Baixa patch 227k do GitHub (OldUnreal)
5. ✅ Aplica o patch Linux nativo
6. ✅ Ajusta permissões e arquivos de configuração
7. ✅ Converte ícone `.ico` para `.png` (múltiplos tamanhos)
8. ✅ Cria launcher global `/usr/local/bin/unreal`
9. ✅ Cria entrada no menu de aplicativos

### 🎮 Como jogar após instalação

**Opção 1 - Terminal:**
```bash
unreal
```

**Opção 2 - Menu de Aplicativos:**
- Procure por "Unreal" no menu Iniciar/Dash
- Clique no ícone

### 📁 Estrutura de arquivos

```
~/Games/Unreal/           # Instalação do jogo
├── System/               # Executáveis e configurações
│   ├── unreal-bin-x86   # Binário principal
│   ├── Unreal.ini       # Configuração principal
│   └── *.so             # Bibliotecas Linux
├── Maps/                 # Mapas do jogo
├── Music/                # Músicas
├── Sounds/               # Sons
├── Textures/             # Texturas
└── Help/                 # Documentação e ícone

~/.local/share/applications/unreal.desktop    # Atalho do menu
~/.local/share/icons/hicolor/*/apps/unreal.png # Ícones
```

### 🔧 Solução de problemas

**Problema:** Script não encontra instalação do Unreal
- **Solução:** Certifique-se de que instalou via Wine e o jogo está em `~/.wine/drive_c/Unreal/`

### 📜 Licença

Este script é fornecido "como está". O jogo Unreal é propriedade da Epic Games.
O patch 227k é desenvolvido pela comunidade OldUnreal.

### 🔗 Links úteis

- **OldUnreal (Patch):** https://github.com/OldUnreal/Unreal-testing
- **Unreal na GOG:** https://www.gog.com/game/unreal_gold
- **Archive.org (Preservação):** https://archive.org/details/softwarelibrary_msdos_games
- **WineHQ:** https://www.winehq.org/

## 🤝 Contribuindo

Sinta-se à vontade para enviar issues ou pull requests para melhorar este instalador.

## ⭐ Créditos

- **Equipe OldUnreal** – Pelo incrível patch 227k
- **Epic Games** – Por criar o Unreal
- **Comunidade** – Por manter esse clássico vivo

---

## English

### 📋 Description

Automated script to convert a **Unreal (original)** installation from Wine to native Linux, applying the OldUnreal 227k patch.

### ⚠️ IMPORTANT

- ✅ **Compatible:** Unreal (original version)
- ❌ **NOT compatible:** Unreal Gold, Unreal Gold + Return to Na Pali

This patch is **exclusive** to original Unreal. If you have Unreal Gold, you should play it via Wine/Proton.

### 📦 Prerequisites

#### 1. Own a legitimate copy of Unreal

You need to own the game through:
- GOG.com
- Steam
- Original CD/DVD
- Archive.org (abandonware/preservation versions)
- Other official digital store

**Note:** Archive.org maintains copies for historical preservation of old games.

#### 2. Install Unreal in Wine FIRST

**Before running this script**, you must:

1. Install Wine on your system:
```bash
sudo apt install wine winetricks  # Debian/Ubuntu
sudo dnf install wine              # Fedora
```

2. Install Unreal through Wine:
   - **GOG:** Run the `.exe` installer with Wine
   - **Steam:** Use Proton or install Steam in Wine
   - **CD:** Mount the CD and run installer with Wine

3. Make sure the game is at:
```
~/.wine/drive_c/Unreal/
```

#### 3. System dependencies

```bash
sudo apt install wget tar imagemagick  # Debian/Ubuntu
sudo dnf install wget tar ImageMagick  # Fedora
sudo pacman -S wget tar imagemagick    # Arch Linux
```

### 🚀 How to use
#### Quick Install (One Command):

```bash
wget https://raw.githubusercontent.com/hudsonalbuquerque97-sys/unreal-install-linux/refs/heads/main/unreal-install-linux-patch227k.sh && chmod +x unreal-install-linux-patch227k.sh && ./unreal-install-linux-patch227k.sh
```
-
#### Manual Install:

1. **Download the script:**
```bash
wget https://raw.githubusercontent.com/hudsonalbuquerque97-sys/unreal-install-linux/refs/heads/main/unreal-install-linux-patch227k.sh
```

2. **Make it executable:**
```bash
chmod +x unreal-install-linux-patch227k.sh
```

3. **Run the script:**
```bash
./unreal-install-linux-patch227k.sh
```

4. **Enter password when prompted** (required to create global launcher)

### 📂 What the script does

1. ✅ Checks required dependencies
2. ✅ Locates Unreal installation in Wine
3. ✅ Copies files to `~/Games/Unreal`
4. ✅ Downloads 227k patch from GitHub (OldUnreal)
5. ✅ Applies native Linux patch
6. ✅ Adjusts permissions and configuration files
7. ✅ Converts `.ico` icon to `.png` (multiple sizes)
8. ✅ Creates global launcher `/usr/local/bin/unreal`
9. ✅ Creates application menu entry

### 🎮 How to play after installation

**Option 1 - Terminal:**
```bash
unreal
```

**Option 2 - Application Menu:**
- Search for "Unreal" in your Start Menu/Dash
- Click the icon

### 📁 File structure

```
~/Games/Unreal/           # Game installation
├── System/               # Executables and configs
│   ├── unreal-bin-x86   # Main binary
│   ├── Unreal.ini       # Main configuration
│   └── *.so             # Linux libraries
├── Maps/                 # Game maps
├── Music/                # Music files
├── Sounds/               # Sound files
├── Textures/             # Texture files
└── Help/                 # Documentation and icon

~/.local/share/applications/unreal.desktop    # Menu shortcut
~/.local/share/icons/hicolor/*/apps/unreal.png # Icons
```

### 🔧 Troubleshooting

**Problem:** Script doesn't find Unreal installation
- **Solution:** Make sure you installed via Wine and game is at `~/.wine/drive_c/Unreal/`

### 📜 License

This script is provided "as is". Unreal game is property of Epic Games.
The 227k patch is developed by the OldUnreal community.

### 🔗 Useful links

- **OldUnreal (Patch):** https://github.com/OldUnreal/Unreal-testing
- **Unreal on GOG:** https://www.gog.com/game/unreal_gold
- **Archive.org (Preservation):** https://archive.org/details/softwarelibrary_msdos_games
- **WineHQ:** https://www.winehq.org/

---

## 🤝 Contributing

Feel free to submit issues or pull requests to improve this installer.

## ⭐ Credits

- **OldUnreal Team** - For the amazing 227k patch
- **Epic Games** - For creating Unreal
- **Community** - For keeping this classic alive
