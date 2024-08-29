# Вступление

1. Статья предлагает реализацию проблемы гарантированной консистентности работы с очередями.

# Проблема

1. Согласно [статьи](./state_consistency_problem.md) невозможно гарантированная консистентная установка двух состояний не поддерживающих идемпотентность или транзакционную целостность.
0. Очереди вроде kafka rmq относятся именно к таковым. Соответсвенно использование указанных очередей налагает существенные ограничения на реализацию особенно при использовании msa.



# Определения

## hash

1. hash - идентификатор группы изоляции сообщений;
0. добавление получение коммит сообщений выполняется в рамках hash;
0. hash может формироваться на основе топика, номера дорожки топика, секретного слова и иных модификаторов.

## id

1. Уникальный идентификатор сообщения в рамках hash.
0. Очередность разбора сообщений определяется именно на основе возрастания идентификатора.

## message

1. Произвольное тело сообщение, допустимы бинарные данные, строки (включая форматы типа json, yaml).

## offset

1. Последний обработанный идентификатор в рамках hash.



# Методы

1. Взаимодействие с очередью осуществляется на основе синхронных REST вызовов.
0. Очередь обеспечивает выполнение следущих методов.
    1. [set](#set) - изменение состояния очереди;
    0. [get](#get) - получение состояния очереди.


# set

1. Метод **set**
    1. выполняет изменения состояния очереди путем опциональных Действий:
        1. создание сообщений;
        0. коммит сообщений.
0. Метод гарантируют транзакционную целостность при исполнении, а именно при любой ошибке состояние очереди остается неизменным.

## Аргументы set

1. Аргументом метода является структура в формате json или yaml, включающая опциональный перечень Действий:
    1. create - опциональный массив сообщений для размещения в очереди hash;
    0. commit - опциональный массив хэшей для выполнения коммита сообщений в нем;
0. Действия обрабатываются в указанной аргументом последовательности.
0. Ниже представлен пример аргумента с секциями create и commit одновременно:

```json
{
    "create" :
    [
        { "hash":"", "message":"hello" }, ...
    ],
    "commit":
    [
        { "hash":"hash_1", "id":"id_1" }, ...
    ]
}
```

## set.create

1. Секция содержит директивы размещения сообщений по различным hash очереди.
0. Секция содержит следующие ключи:
    1. hash - хеш очереди с которым будет размещено сообщение в очереди.
    0. message - тело сообщения для указанного hash.

# set.commit

1. Секция содержит перечень идентификаторов хэшей для которых выполняется коммит сообщения, при этом осуществляется смещение указателя следующего сообщения offset.
    1. hash - хеш очереди для которого будет выполнен коммит сообщения в очереди.
    0. id - идентификатор сообщения которе является последним исполненным для указанного хэша очереди.
2. Секция допускает выполнение последовательных коммитов для одного и того же hash или различных hash.

## Результат set

1. Результатом метода является структура, содержащая ответ о фактическом выполнении всех действий или сообщение об ошибке.
0. При любой из ошибок состояние очереди остается неизменной.



# get

1. Метод **get** возвращает очередное сообщение и его идентификтаор.

## Аргументы get

1. Аргументом метода является структура в формате json или yaml, указывающая hash очереди:
0. Пример:

```json
{ "hash":"hash_1" }
```

## Результат get

1. Метод возвращает ответ с идентификатором сообщения и телом сообщения.
    1. id - идентификатор сообщения;
    0. message - тело сообщения сообщение.
0. Пример:
```json
{
    "id":"id_1",
    "message":"hello"
}
```