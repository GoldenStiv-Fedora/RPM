#!/bin/bash

set -e

# 1. Установка зависимостей
echo "▶ Установка зависимостей..."
sudo dnf install -y fuse fuse-libs

# 2. Загрузка Msty AppImage (CPU-версия для Linux x86_64)
echo "▶ Скачивание последней версии Msty..."
DOWNLOAD_URL="https://assets.msty.app/prod/latest/linux/amd64/Msty_x86_64_amd64.AppImage"
wget -O Msty.AppImage "$DOWNLOAD_URL"

# 3. Назначение прав на выполнение
echo "▶ Назначение прав на выполнение..."
chmod +x Msty.AppImage

# 4. Перемещение в /opt
echo "▶ Установка в /opt..."
sudo mv Msty.AppImage /opt/Msty.AppImage

# 5. Создание ярлыка в меню
echo "▶ Создание ярлыка в меню приложений..."
cat <<EOF | sudo tee /usr/share/applications/msty.desktop
[Desktop Entry]
Name=Msty
Exec=/opt/Msty.AppImage --no-sandbox
Icon=utilities-terminal
Type=Application
Categories=Utility;
EOF

# 6. (опционально) alias в /usr/local/bin
echo "▶ Создание команды 'msty' в терминале..."
sudo ln -sf /opt/Msty.AppImage /usr/local/bin/msty

echo "✅ Установка завершена. Запустите Msty из меню приложений или через команду 'msty'"

