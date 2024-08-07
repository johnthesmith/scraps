# Общее решение гарантии консистентности состояний

1. Статья описывает общее решение гарантии консистентности (полноты и неизбыточности)
   при установке нескольких состояний синхронным [потоком](./glossary/Поток.md) с учетом статьи 
   [Проблема консистентности состояний](./state_consistency_problem.md).


# Состояния

1. Ниже пречислены рассматриваемые виды состояний:
    1. S - (simple state) простое состояние без подержки тарнзакций и [идемпотентности](https://ru.wikipedia.org/wiki/%D0%98%D0%B4%D0%B5%D0%BC%D0%BF%D0%BE%D1%82%D0%B5%D0%BD%D1%82%D0%BD%D0%BE%D1%81%D1%82%D1%8C), например:
        1. очереди сообщений (kafka, итд);
        0. внешние сервисы;
        0. базы без идемпотентных проверок, с триггерами или автокоммитом;
        0. журналирование.
    0. I - (idempotent state) - состояние с поддержкой идемпотентности:
        1. базы данных;
        0. сервисы;
        0. файлы.
    0. T - (transact state) - состояния, поддерживающие транзакционную целостность.
        1. базы данных TSQL.



# Таблица возможных комбинаций

1. Таблица демонстирует:
    1. возможные комбинации последовательной установки состояний в синхронном потоке;
    0. гарантию итоговой консистентности для различных вариантов;
    0. последствия сбоя в потоке между установкой состояний.
0. Обязательным условием является повтор вызова потока пр отказе на любой стадии.
    1. пример:
        1. Поток получает сообщение из очереди, которая гарантирует повторяемость.
        0. Вызов потока из UI не гарантирует повторяемость события, так как пользователь 
           получив ошибку, может не выполнить повторное действие.

|[Состояния](#сокращения)| Гарантия | Пример | Негатичные последствия |
|:-:|:-:|-|-|
|SS        | нет      | Push сообщения в очередь; Write в журнал | Накопление дублей сообщений в очереди |
|SI        | нет      | Commit сообщения очереди; Идемпотентный вызов сервиса | Отсутствие вызова сервиса |
|ST        | нет      | Commit сообщения очереди; Insert в базу | Накопление дублей сообщений в очереди |
|IS        | да       | Insert с предпроверкой в базу; Commit сообщения очереди | Многократные попытки Insert |
|II        | да       | Insert с предпроверкой в базу; Update с предпроверкой в базу | Многократные попытки Insert |
|IT        | да       | Вызов внешнего сервиса; Запись в базу | Многократный вызов внешнего сервиса |
|TS        | нет      | Insert в базу; Push в очередь | Накопление дублей в БД |
|TI        | нет      | Insert в базу; Запись с предпроверкой в базу | Накопление дублей в БД |
|TT        | да       | Insert в базу; Запись в базу в одной транзакции | Полный откат транзакции |



# Общие правила гарантии сохранения состояний

1. Повторямость вызова при любом отказе в потоке
    1. И идемпотентность предыдущего изменения состояния
        1. ИЛИ изменение всех состояний в единой транзакции.
