#!/bin/bash
# Обновление репозитория на текущей ветке

# Предупреждение по безопасности
# Не рекомендуется запускать данный файл без проверки его содержимого

echo -e "\033[0;32m$(pwd)\033[0m"

[ -z "$1" ] && read -p "Enter commit comment: " comment || comment=$1
[ -z "$comment" ] && comment="Auto commit"

git add -A && git commit -m "$comment"
git pull --rebase && git push

