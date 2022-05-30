#Домашнее задание к занятию "08.04 Работа с Roles"

PLAYBOOK `site.yml` содержит 3 playbook:
 - 'Install Clickhouse' (вызывает роль clickhouse на хосте clickhouse)
 - 'Install Vector' (вызывает роль vector-role на хосте vector)
 - 'Install Lighthouse' (вызывает роль clickhouse-role на хосте lighthouse)

###Роль "clickhouse"
Получена с помощью команды 'ansible-galaxy install -r -requirements.yml' 
и вот такого файла requirements.yml:
```text
---
  - src: git@github.com:AlexeySetevoi/ansible-clickhouse.git
    scm: git
    version: "1.11.0"
    name: clickhouse
```

###Роль "vector-role"
В defaults/main.yml указана версия:
```text
---
# defaults file for vector-role
vector_version: "0.21.2"
```

Таски вынесены в tasks/main.yml
```text
---
# tasks file for vector-role
- name: Get vector distrib
  ansible.builtin.get_url:
    url: "https://packages.timber.io/vector/{{ vector_version }}/vector-{{ vector_version }}-1.x86_64.rpm"
    dest: "./vector-{{ vector_version }}-1.x86_64.rpm"
- name: Install vector packages
  become: true
  ansible.builtin.yum:
    name:
      - vector-{{ vector_version }}-1.x86_64.rpm
  notify: Start vector service
```

Хендлер перезапускает `vector`
```text
---
# handlers file for vector-role
- name: Start vector service
  become: true
  ansible.builtin.service:
    name: vector
    state: restarted
```

###Роль "clickhouse-role"
Строчка `- include_tasks: install_nginx.yml` в `main.yml` вызывает таски для установки nginx
После чего скачивается lighthouse и вызывается хендлер, перезапускающий nginx