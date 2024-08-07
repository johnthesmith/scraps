# Проблема гарантии консистентности двух и более состояний

1. Статья
    1. описывает проблему гарантии полноты и неизбыточности при последовательной 
       установке двух [состояний](./glossary/Состояние.md);
    0. выдвигает гипотезу о невозможности разрешения проблемы без участия 
       состояний (без [идемпотентности](https://ru.wikipedia.org/wiki/%D0%98%D0%B4%D0%B5%D0%BC%D0%BF%D0%BE%D1%82%D0%B5%D0%BD%D1%82%D0%BD%D0%BE%D1%81%D1%82%D1%8C) состояний);
    1. предлагает [Общее решение](general_solution_to_the_state_preservation_problem.md).



# Задача

1. [Поток](./Термины/Поток) T должен установить два состояния S1 и S2.
0. S1 и S2 возвращают синхронный ответ при успехе сохранения и не более.
0. Требуется гарантировать полноту и не избыточность установки состояний.



# Проблема

1. Поток Т выполняет запись в S1.
    1. При провале Поток Т возвращает отказ.
    0. При успехе поток Т выполняет запись в S2.
        2. При успехе задача завершена.
        0. При провале возвращается отказ, и возникает **проблема**:
            1. состояние S1 уже установлено, а S2 не установлено;
            0. обнозначно не определен результат исполнения потока T;
            0. повторный вызов потока Т не разрешит ситуацию.

```mermaid
flowchart LR

b(( )) --> wS1
wS1[write S1] --> cc{ }
cc --> |ok#| wS2[write S2]
wS2 --> cc1{ } --> |ok| ok(((  )))
cc1 --> |fail|erorr1(((!)))
cc --> |fail|erorr2(((!)))
```


# Гипотеза

1. Не существует решения при котором поток Т гарантирует полноту и неизбыточность 
установки двух состояний, при том что состояния возвращают исключительно синхронный
ответ о результате сохранения.
0. Никакие механизмы со стороны Т не могут разрешить указанную проблему 
без [идемпотентности](https://ru.wikipedia.org/wiki/%D0%98%D0%B4%D0%B5%D0%BC%D0%BF%D0%BE%D1%82%D0%B5%D0%BD%D1%82%D0%BD%D0%BE%D1%81%D1%82%D1%8C) S1.



# Варианты решения

1. Состояние S1 должно быть идемпотентным например: 
    1. защита от дублированного получения данных;
    0. возможность оповещения T по его инициативе о результатах сохранения.
0. T должен обладать возможностью повтора установки состояний при отказе.

```mermaid
flowchart LR
    b((b)) --> rs1
    rs1[read S1] --> cc{x}
    cc --> |exists| wS2[write S2]
    cc --> |empty| wS1[write S1] --> wS2
    wS2 --> e((e))
```



# Ссылки

1. [Общее решение проблемы сохранения состояний](general_solution_to_the_state_preservation_problem.md)
