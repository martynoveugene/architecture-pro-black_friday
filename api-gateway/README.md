# sharding-repl-cache

## Как запустить

Запускаем компоненты mongodb и приложение, mongos_router будет unhealthy.

```shell
docker-compose up -d
```

Выполняем инициализацию конфигурации, всех шардов mongodb
Добавляем на роутер mongodb все шарды,
помечаем базу somedb для шардирования,
шардируем коллекцию helloDoc по полю name хэшированным способом,
mongos_router должен стать healthy

```shell
./scripts/mongo-init.sh
```

Заполняем коллекцию helloDoc данными

```shell
./scripts/mongo-data.sh
```

Регистрируем сервисы в Consul

```shell
./scripts/register-services.sh
```

Регистрируем маршрут в apisix

```shell
./scripts/register-services.sh
```


Для остановки контейнеров использовать скрипт

```shell
./scripts/stop.sh
```

## Как проверить
### Автотест
Запускаем проверочный тест, котоорый заберет количество документов на роутере и на шардах и сравнит

```shell
./scripts/mongo-test.sh
```

### Если вы запускаете проект на локальной машине

Откройте в браузере http://localhost:8080

### Если вы запускаете проект на предоставленной виртуальной машине

Узнать белый ip виртуальной машины

```shell
curl --silent http://ifconfig.me
```

Откройте в браузере http://<ip виртуальной машины>:8080

## Доступные эндпоинты

Список доступных эндпоинтов, swagger http://<ip виртуальной машины>:8080/docs