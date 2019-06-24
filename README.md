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
