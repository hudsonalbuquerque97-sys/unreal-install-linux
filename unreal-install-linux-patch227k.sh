#!/bin/bash
set -e

# Detecta idioma do sistema / Detect system language
if [[ "$LANG" == pt_* ]] || [[ "$LANGUAGE" == pt_* ]]; then
    LANG_PT=true
else
    LANG_PT=false
fi

# Textos bilíngues / Bilingual texts
msg() {
    local pt="$1"
    local en="$2"
    if $LANG_PT; then
        echo "$pt"
    else
        echo "$en"
    fi
}

WINE_PREFIX="$HOME/.wine/drive_c"
GAMES_DIR="$HOME/Games"
PATCH_URL="https://github.com/OldUnreal/Unreal-testing/releases/download/v227k_12/OldUnreal-UnrealPatch227k-Linux.tar.bz2"

msg "══════════════════════════════════════════════════" \
    "══════════════════════════════════════════════════"
msg "       Instalador Unreal para Linux (227k)" \
    "       Unreal Linux Installer (227k)"
msg "══════════════════════════════════════════════════" \
    "══════════════════════════════════════════════════"
echo ""
msg "NOTA: Este patch é compatível apenas com Unreal (original)." \
    "NOTE: This patch is compatible only with Unreal (original)."
msg "      UnrealGold não é suportado pelo patch 227k." \
    "      UnrealGold is not supported by patch 227k."
echo ""

# [1/9] Verificar dependências
msg "[1/9] Verificando dependências..." \
    "[1/9] Checking dependencies..."

MISSING_DEPS=()
for cmd in wget tar convert; do
    if ! command -v $cmd &> /dev/null; then
        MISSING_DEPS+=($cmd)
    fi
done

if [ ${#MISSING_DEPS[@]} -ne 0 ]; then
    msg "ERRO: Dependências faltando: ${MISSING_DEPS[*]}" \
        "ERROR: Missing dependencies: ${MISSING_DEPS[*]}"
    msg "Instale com: sudo apt install wget tar imagemagick" \
        "Install with: sudo apt install wget tar imagemagick"
    exit 1
fi

msg "✔ Dependências OK!" \
    "✔ Dependencies OK!"

# [2/9] Procurar instalação do Unreal no Wine
msg "[2/9] Procurando instalação do Unreal no Wine..." \
    "[2/9] Looking for Unreal installation in Wine..."

UNREAL_PATH="$WINE_PREFIX/Unreal"

if [ ! -d "$UNREAL_PATH" ]; then
    msg "ERRO: Instalação do Unreal não encontrada no Wine." \
        "ERROR: Unreal installation not found in Wine."
    echo ""
    msg "Instale primeiro o Unreal (original) via Wine." \
        "Install Unreal (original) first via Wine."
    msg "Caminho esperado: $UNREAL_PATH" \
        "Expected path: $UNREAL_PATH"
    echo ""
    msg "IMPORTANTE: Este script é apenas para Unreal, não UnrealGold." \
        "IMPORTANT: This script is for Unreal only, not UnrealGold."
    exit 1
fi

msg "✔ Unreal encontrado!" \
    "✔ Unreal found!"

# Definir paths finais
GAME_LINUX_PATH="$GAMES_DIR/Unreal"
ICON_DIR="$HOME/.local/share/icons/hicolor"
DESKTOP_FILE="$HOME/.local/share/applications/unreal.desktop"
LAUNCHER_NAME="unreal"

echo ""

# [3/9] Copiar arquivos
msg "[3/9] Copiando arquivos para $GAME_LINUX_PATH ..." \
    "[3/9] Copying files to $GAME_LINUX_PATH ..."

mkdir -p "$GAME_LINUX_PATH"
cp -r "$UNREAL_PATH"/* "$GAME_LINUX_PATH"

msg "✔ Arquivos copiados!" \
    "✔ Files copied!"

# [4/9] Baixar patch
msg "[4/9] Baixando patch 227k do GitHub..." \
    "[4/9] Downloading 227k patch from GitHub..."

cd /tmp
if [ -f "unreal_patch.tar.bz2" ]; then
    rm unreal_patch.tar.bz2
fi

wget -q --show-progress -O unreal_patch.tar.bz2 "$PATCH_URL"

msg "✔ Patch baixado!" \
    "✔ Patch downloaded!"

# [5/9] Extrair patch
msg "[5/9] Extraindo e aplicando patch..." \
    "[5/9] Extracting and applying patch..."

tar -xjf unreal_patch.tar.bz2 -C "$GAME_LINUX_PATH"
rm unreal_patch.tar.bz2

msg "✔ Patch 227k aplicado!" \
    "✔ Patch 227k applied!"

# [6/9] Ajustar permissões e configurações
msg "[6/9] Ajustando permissões e configurações..." \
    "[6/9] Setting permissions and configurations..."

chmod +x "$GAME_LINUX_PATH/System/"*-bin* 2>/dev/null || true
chmod +x "$GAME_LINUX_PATH/System/"*.bin 2>/dev/null || true

# Corrigir paths nos arquivos .ini para Linux
cd "$GAME_LINUX_PATH/System"

# Backup dos arquivos .ini originais
for ini_file in *.ini; do
    if [ -f "$ini_file" ] && [ ! -f "${ini_file}.bak" ]; then
        cp "$ini_file" "${ini_file}.bak"
    fi
done

# Corrigir todos os arquivos .ini
for ini_file in *.ini; do
    if [ -f "$ini_file" ]; then
        # Converter paths do Windows para Linux
        sed -i 's/\\/\//g' "$ini_file" 2>/dev/null || true
        sed -i "s|C:.*Unreal|$GAME_LINUX_PATH|gi" "$ini_file" 2>/dev/null || true
        sed -i "s|Z:.*Unreal|$GAME_LINUX_PATH|gi" "$ini_file" 2>/dev/null || true
        # Corrigir drives do Wine
        sed -i 's|[A-Z]:\\|/|gi' "$ini_file" 2>/dev/null || true
    fi
done

# Garantir que Unreal.ini existe e está correto
if [ -f "Unreal.ini" ]; then
    # Corrigir seção URL se existir
    sed -i '/^\[URL\]/,/^\[/ s|Map=.*|Map=../Maps/NaliC.unr|' "Unreal.ini" 2>/dev/null || true
    sed -i '/^\[URL\]/,/^\[/ s|MapExt=.*|MapExt=unr|' "Unreal.ini" 2>/dev/null || true
fi

# Garantir que as pastas essenciais existam
mkdir -p "$GAME_LINUX_PATH/Maps"
mkdir -p "$GAME_LINUX_PATH/Music"
mkdir -p "$GAME_LINUX_PATH/Sounds"
mkdir -p "$GAME_LINUX_PATH/Textures"

msg "✔ Permissões e configurações ajustadas!" \
    "✔ Permissions and configurations set!"

# [7/9] Localizar e converter ícone
msg "[7/9] Criando ícones..." \
    "[7/9] Creating icons..."

ICON_SOURCE=""
# Procurar em múltiplos locais possíveis
for icon_path in "$GAME_LINUX_PATH/Help/Unreal.ico" \
                 "$GAME_LINUX_PATH/System/Unreal.ico" \
                 "$GAME_LINUX_PATH/Unreal.ico"; do
    if [ -f "$icon_path" ]; then
        ICON_SOURCE="$icon_path"
        msg "  → Ícone encontrado: $icon_path" \
            "  → Icon found: $icon_path"
        break
    fi
done

if [ -n "$ICON_SOURCE" ]; then
    # Criar diretórios e converter para múltiplos tamanhos
    for size in 16 22 24 32 48 64 128 256; do
        mkdir -p "$ICON_DIR/${size}x${size}/apps"
        convert "$ICON_SOURCE"[0] -resize ${size}x${size} \
            "$ICON_DIR/${size}x${size}/apps/unreal.png" 2>/dev/null || true
    done
    
    # Copiar também para pixmaps (compatibilidade)
    mkdir -p "$HOME/.local/share/pixmaps"
    convert "$ICON_SOURCE"[0] -resize 48x48 \
        "$HOME/.local/share/pixmaps/unreal.png" 2>/dev/null || true
    
    msg "✔ Ícones criados em múltiplos tamanhos!" \
        "✔ Icons created in multiple sizes!"
else
    msg "⚠ Ícone original não encontrado, será usado ícone padrão" \
        "⚠ Original icon not found, default icon will be used"
fi

# [8/9] Criar launcher global
msg "[8/9] Criando launcher no sistema..." \
    "[8/9] Creating system launcher..."

LAUNCHER_SCRIPT="#!/bin/bash
cd \"$GAME_LINUX_PATH/System\"
exec ./unreal-bin-x86 \"\$@\""

echo "$LAUNCHER_SCRIPT" | sudo tee /usr/local/bin/unreal >/dev/null
sudo chmod +x /usr/local/bin/unreal

msg "✔ Launcher criado: unreal" \
    "✔ Launcher created: unreal"

# [9/9] Criar entrada no menu
msg "[9/9] Criando entrada no menu de aplicativos..." \
    "[9/9] Creating application menu entry..."

mkdir -p "$(dirname "$DESKTOP_FILE")"

if $LANG_PT; then
    cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Unreal
GenericName=Jogo de Tiro em Primeira Pessoa
Comment=Jogo clássico de FPS da Epic Games
Exec=$GAME_LINUX_PATH/System/unreal-bin-x86
Icon=unreal
Terminal=false
Categories=Game;ActionGame;
Keywords=unreal;fps;tiro;ação;epicgames;
StartupNotify=true
Path=$GAME_LINUX_PATH/System
EOF
else
    cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Unreal
GenericName=First Person Shooter
Comment=Classic FPS game by Epic Games
Exec=$GAME_LINUX_PATH/System/unreal-bin-x86
Icon=unreal
Terminal=false
Categories=Game;ActionGame;
Keywords=unreal;fps;shooter;action;epicgames;
StartupNotify=true
Path=$GAME_LINUX_PATH/System
EOF
fi

chmod +x "$DESKTOP_FILE"

# Atualizar cache do sistema
update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
gtk-update-icon-cache -f -t "$ICON_DIR" 2>/dev/null || true
xdg-desktop-menu forceupdate 2>/dev/null || true

msg "✔ Entrada no menu criada!" \
    "✔ Menu entry created!"

# Resumo final
echo ""
msg "══════════════════════════════════════════════════" \
    "══════════════════════════════════════════════════"
msg "    ✔ Instalação concluída com sucesso!" \
    "    ✔ Installation completed successfully!"
msg "══════════════════════════════════════════════════" \
    "══════════════════════════════════════════════════"
echo ""
msg "Versão instalada: Unreal (original)" \
    "Installed version: Unreal (original)"
msg "Patch aplicado: 227k (OldUnreal)" \
    "Applied patch: 227k (OldUnreal)"
echo ""
msg "Como jogar:" \
    "How to play:"
msg "  • Terminal: unreal" \
    "  • Terminal: unreal"
msg "  • Menu: Procure 'Unreal' nos seus aplicativos" \
    "  • Menu: Search 'Unreal' in your applications"
echo ""
msg "Localização: $GAME_LINUX_PATH" \
    "Location: $GAME_LINUX_PATH"
msg "Binário: $GAME_LINUX_PATH/System/unreal-bin-x86" \
    "Binary: $GAME_LINUX_PATH/System/unreal-bin-x86"
echo ""
msg "Divirta-se! 🎮" \
    "Have fun! 🎮"
echo ""
