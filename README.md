# Hellcrazyrabbit_infra
## Домашнее задание Знакомство с облачной инфраструктурой GCP
- [x] Создание инфраструктуры и удаленное подключение
	- [x] Самостоятельное задание 
- [X] Создание VPN-сервера
	- [X] Дополнительное задание

## Самостоятельное задание
 Для удобства сквозного подключения к внутреннему хосту через bastion
следует использовать ~/.ssh/config настройки
`````
Host bastion
        ForwardAgent yes
        Hostname host_ip
        User user_name
        IdentityFile ~/.ssh/vendikato

Host sih
        Hostname host_ip
        User user_name
        ProxyCommand ssh user_name@host_ip nc %h %p 2> /dev/null
`````
Описание использования и доп. информацию можно подчерпнуть [отсюда](https://www.cyberciti.biz/faq/create-ssh-config-file-on-linux-unix/)

## Дополнительное задание
К серверу привязан SSL сертификат сгенерированный автоматически ботом Let`s encrypt
[Инструкции для настройки](https://certbot.eff.org/lets-encrypt/ubuntutrusty-other)
Так же был выделен домен 3го уровня и направлен DNS хостингом на IP VPN-сервера
 
## Конфигурация VPN-сервера для проверки

bastion_IP = 35.232.76.112

someinternalhost_IP = 10.128.0.3
`````
hostname - vpn
someinternalhost alias - sih
````` 

## Домашнее задание Основные сервисы GCP
 - [x] Настроить новый инстанс через GUI, развернуть приложение
 - [x] Создать скрипты установок Ruby, MongoDB и развертывания приложения

### Проверка ДЗ

testapp_IP = 34.83.160.205

testapp_port = 9292

### Самостоятельная работа
- [x] Написать команду создания инстанса с использованием startup_script
````` 
gcloud compute instances create reddit-app \ 
--zone=us-west1-b \ 
--boot-disk-size=10GB \ 
--image-family ubuntu-1604-lts \ 
--image-project=ubuntu-os-cloud \ 
--machine-type=g1-small \ 
--tags puma-server \ 
--metadata startup-script='wget -O - https://gist.githubusercontent.com/Hellcrazyrabbit/50bea9ae44a994dbbea5cebd783f8e71/raw/88734dee34947de6d9cf4f1975e3e6e6daaaa66d/startupscript.sh | bash' \
--restart-on-failure
`````

- [x] Написать команду создания правила приложения 
`````
gcloud compute firewall-rules create default-puma-server \ 
--direction=INGRESS \ 
--priority=1000 \ 
--network=default \ 
--action=ALLOW \ 
--rules=tcp:9292 \ 
--source-ranges=0.0.0.0/0 \
--target-tags=puma-server
`````
## Домашнее задание Сборка образа VM припомощи Packer

- [x] Установка Packer и сборка образа VM для GCP

Установка происходит путем скачивания дистра с [сайта](https://www.packer.io/downloads.html)
После распаковки нежно добавить приложение в PATH
`````
ln -s /path/to/packer packer
````` 
Сборка VM происходит по инструкции задания

### Самостоятельное задание
- [x] Создать файл переменных для сборки образа

### Задание со *

 - [x] "Запечь" полный образ VM, старт приложения производить через systemd. Создать shell-скрипт запуска VM для gcloud. 

 - Реализовано путем запуска bash скрипта с EOF в сервис файл.
 - Shell-скрипт сохранен в config-scripts.

## Домашнее задание Практика IaC с использованием Terraform

 - [x] Установка Terraform и создание VM согласно описания

Установка проиcходит аналогично установке Packer.

### Самостоятельное задание 

 - [x] Задать переменную для приватного ключа provisioner. Значение default зоны ресурса app. Отформатировать tf файлы. Создать examle переменных

### Задание со *

 - [x] Добавить ssh ключи пользователей в метаданные проекта

**1й вариант**
`````
resource "google_compute_project_metadata" "ssh-keys" {
    metadata {
    ssh-keys = <<EOF
appuser:${file(var.public_key_path)}
appuser1:${file(var.public_key_path)}
appuser2:${file(var.public_key_path)}
EOF
  }
}
`````
удаляет все метаданные проекта и устанавливает указанные, можно импортировать имеющиеся 
`````
terraform import google_compute_project_metadata.ssh-keys my-project-id
````` 

**2й вариант**
`````
resource "google_compute_project_metadata_item" "appuser" {
  key = "appuser"
  value = "${file(var.public_key_path)}"
}
`````
Создает отдельный экземпляр метаданных для проекта
[мануал](https://www.terraform.io/docs/providers/google/r/compute_project_metadata.html)


- [X] Создать балансировщик

## Домашнее задание Принципы организации инфраструктурного кода и работа над инфраструктурой в команде на примере Terraform.

- [x] Разбить конфигурацию Terraform на модули

- [x] Создать Stage & Prod
### Самостоятельные задания
- Удалить ненужные файлы
- Параметризировать конфиги модулей
- Отформатировать файлы
 
- [x] Создать модуль storage-bucket

### Примечания к выполненному
Для выполнения заданий и тестов может потребоваться  экспорт аккаунта подключения к GCP
`````
export GOOGLE_APPLICATION_CREDENTIALS="[acc_file_name].json"
`````
Все переменные имеют значение по умолчанию.

### Задание со *
- [X] Настроить GCS в качестве бэкенда

`````
создано 2 бакета для stage & prod
`````

## Домашнее задание Управление конфигурацией.

- [x] Установить Ansible и настроить конфигурацию, инвентори, плейбук
- [x] Прогнать плэйбук 

После выполнения плэйбука, Ansible уведомляет об отсутствии изменений на хосте
`````
Причиной тому выполненная команда клонирования репозитория через модуль команды
ansible app -m git -a 'repo=https://github.com/express42/reddit.git dest=/home/appuser/reddit' 
`````
Это подтверждает идемпотентность Ansible. Удаляем директорию с репой, запускаем плэйбук снова и получаем уже результат со статусом "changed"

### Задание со *


