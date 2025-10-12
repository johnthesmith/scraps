# Хранилища состояний в SIAMA

1. SIAMA предполагает атомизацию компонентов.
0. На основе [Решения](@queue_issue_and_resolve) SIAMA предполагает 
исключительно следующие способы хранилища состояний:
    1. Взаимодейсвтие с очередью
    0. Взаимодействие с сервисами
    0. Взаимодействие с БД.
0. Иные способы взаимодействия не рекомендуются.
0. Далее рассматриваются синхронные потоки.



#  Изменение состояний DB

1. Под изменением состояний подразумевается запись в БД или вызов стороннего 
сервиса изменяющего состояние.
0. На изменение состояния накладывается требование идемпотентности.
0. SIAMA использует очередь для квантования задач.
0. Исключается использование неидемпотентного вызова.
0. Допускается, но не рекомендуется серия идемпотентных вызовов для изменения 
множества состояний.

```mermaid
flowchart LR

b((begin))
e((ok))
pull[pull<br>topic A]
commit[commit<br>topic A]
pull-gate{x}
work-gate{x}
commit-gate{x}
error((err))
work[idempotent<br>change state]

b --> 
pull --> 
pull-gate -->|success| work --> 
work-gate -->|success| commit --> 
commit-gate --> |success| e

pull-gate -->|fail| error
work-gate -->|fail| error
commit-gate -->|fail| error
```



## Размещение событий в очереди

```mermaid
flowchart LR

b((begin))
e((ok))
pull[pull<br>topic A]
pull-gate{x}
work-gate{x}
commit-gate{x}
error((err))
subgraph transact
    push[push<br>topic B ]
    commit[commit<br>topic A]
end
work[idempotent<br>change<br>state]


b --> 
pull --> 
pull-gate -->|success| work --> 
work-gate -->|success| transact --> 
commit-gate --> |success| e

pull-gate -->|fail| error
work-gate -->|fail| error
commit-gate -->|fail| error
```



## Объединение событий
