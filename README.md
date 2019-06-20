# Hellcrazyrabbit_infra
## Домашнее задание Знакомство с облачной инфраструктурой GCP
- [x] Создание инфраструктуры и удаленное подключение
	- [x] Самостоятельное задание 
- [x] Создание VPN-сервера
	- [x] Дополнительное задание

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

##Дополнительное задание
К серверу привязан SSL сертификат сгенерированный автоматически ботом Let`s encrypt
[Инструкции для настройки](https://certbot.eff.org/lets-encrypt/ubuntutrusty-other)
Так же был выделен домен 3го уровня и направлен DNS хостингом на IP VPN-сервера
 
## Конфигурация VPN-сервера для проверки
- bastion_IP = 35.232.76.112
`````
hostname - vpn
someinternalhost alias - sih
````` 
- someinternalhost_IP = 10.128.0.3 


