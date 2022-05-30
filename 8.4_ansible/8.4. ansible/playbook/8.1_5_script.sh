#!/usr/bin/env bash

echo "Вот такие контейнеры сейчас запущены:
"
docker ps

#Список контейнеров для запуска
contlist=("fedora" "ubuntu" "centos7")

for host in ${contlist[@]}
do
  echo "Запускаем..."
  docker start $host
done

echo "Вот такие контейнеры запущены теперь:
"
docker ps

ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass

for host in ${contlist[@]}
do
  echo "Останавливаем..."
  docker stop $host
done

echo "И вот мы наши контейнеры остановили:
"
docker ps