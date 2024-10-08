# PUSA

## Идеология
Pusa - идеология построения клиент-серверного WEB приложения без разработки JS на Front.
Переносит всю разработку на Back, полностью исключив работы JS для Front.
Управление браузером и DOM элементами, бизнеслогика выполняются на Back.
Разработка JS для Front отсутствует. Pusa может быть реализована на любом языке:
PHP, JS, Java, Go, Ruby, etc.

## Достоинства
1. Исключается необходимость участия JS разработчиков для FrontEnd.
0. Клиентское приложение в браузере компактно и стабильно.
0. Код остается на стороне Back и не доступен со стороны Front.
0. Полностью решен вопрос серилизации REST, отпадает необходимость использования средств типа gRPC и тд.

## Технология
Pusа предлагает протокол обмена на базе минималистичного набора команд, выполняющих все необхдимые операциии.

![Pusa scheme](https://github.com/johnthesmith/scraps/blob/main/images/Pusa.jpg)

1. При загрузке страницы браузер загружает ядро Pusa Front.
0. Pusa Front направляет указанные события браузера (как то click, blur, focus, keypress) на Back посредством POST запроса.
0. Pusa Back получает событие, элемент вызвавший событие, его атрибуты, URL текущей страницы, а так же GET и POST параметры.
0. На основании полученных данных Back определяет контроллер, выполняет полезную нагрузку и формирует ответный набор команд.
0. Pusa Front получает ответ и выполняет команды, изменяя контент DOM и окржение барузера.

Back направляет команты в ответе на запрос Front и не имеет возможности проверить их выполнение.
Состояние Front формируется но не контролируется Back. Работа Pusa сходна с принципом разработки под
видеокарты или Canvas, где результат исполнения директив не оценивается программой а лишь
предствляется пользователю.

## Фокусные элементы

Управление DOM основывается на списке DOM элементов, именуемых фокусными.
Pusa Front выполняет все действия только для текущих фокусных элементов. Список может быть изменен при исполнении команды DOMSelect.

## Команды Pusa

Набор команд Pusa минимален. Ниже перечисленные команды являются основной протокола Pusa, и могт быть использованы
для создания высокоуровневых методов.

## Команды управления DOM

### DOMSelect

Устанавливае в браузере фокус на элменты, у которых Selector равен имени Name при этом поиск элементов осуществляется согласно критерия Target.

#### Аргументы

    Name        Имя для поиска фокусных элементов

    Selector    Тип селектора, условие для поиска фокусных элементов с которым сравнивается значение Name
        CLASS       class = Name
        ID          id = Name
        NAME        name = Name
        TAG         tagName = Name

    Target      Способ выбора фокусных элементов определяется одним из следующих значений
        BODY        единствнным фокусным элементом становится body документа;
        SELF        единственным фокусным становится элмент, вызвавший событие Pusa;
        CHILDS      поиск среди детей текущих фокусных элементов с учетом иерархии;
        SELF_CHILD  поиск фокусных элементов осуществляется только среди прямых потомков текущих фокусных элементов;
        PARENT      фокусными элементами становятся прямые родители текущих фокусных элементов;
        PARENTS     поиск среди родителей текущих фокусныхэлементов с учетом иерархии;

#### Пример

    DOMSelect( null, null, BODY )       установит фокусным элментом body документа;
    DOMSelect( 'a1', CLASS, CHILDS )    установит фокус на все дочерние элментв body, имеющие класс a1;
    DOMSelect( null, null, PARENT )     установит фокус на родителей всех ранее отобранных элементов;

Далее с выбранными элментами можно проивзодить различные манипуляции.


### DOMCreate

Создает новый DOM элемент в каждом фокусном элементе. После исполнения фокус перемещается на вновь созданные элементы.

#### Аргументы

    TagName     тэг вновь создаваемого элемента;
    Position    поизция для создаваемого элемента;
        FIRST   новый элемент разместится первым в фокусном элементе;
        LAST    новый элемент разместится последним в фокусном элементе;
        BEFORE  новый элемент разместится до текущего фокусного элемента;
        AFTER   новый элемент разместится после текущего фокусного элемента;
    ID          Идентификатор нового элемента. При этом если элемент с указанным идентификатором уже присутствует по правилам POSITION, он станет фокусным а новый элемент не будет создан.

Один вызов DOMCreate может создать множество новых элементов. Для каждого текущего фокусного элемента по одному.

#### Пример

    DOMCreate( 'div', LAST, null )  - создает во всех фокусных элементах новый элемент div.

### DOMAttr

Устанавливает для фокусных элементов стилевые арибуты из перечня Values

#### Аргументы

    Value   Массив именованных значений HTML атрибутов в формате [ "Attribute" => "Value", ... ]

### DOMStyle

Устанавливает для фокусных элементов стилевые арибуты из перечня Values

#### Аргументы

    Values  Массив именованных значений стилевых атрибутов CSS в формате [ "Attribute" => "Value", ... ]

### DOMValue
Устанавливает значение value фокусных элементов

#### Аргументы

    Value   Массив именованных значений HTML атрибутов в формате [ "Attribute" => "Value", ... ]

### DOMContent

Устанавливает произвольные текстовый контент для фокусных элементов

#### Аргументы

    Content текстовый контент

### DOMDelete

    Удаляет фокусные DOM элмементы из их родителей. Список фокусных элментов заполняется родителями.
    Не имеет аргументов.

### DOMClassAdd

Добавляет к фокумным элементам указанный класс.

#### Аргументы

    Value   добавляемое имя класса.

### DOMClassRemove

Исключает при наличии из фокусных элементов указанный класс.

#### Аргументы

    Value   исключаемое имя класса.

### DOMEvent

Устанавливает для фокусных элементов событие.

#### Аргументы

    Class   Имя контроллера Pusa
    Method  Метод в классе контролера Pusa, который будет вызван
    Event   Имя событие DOM, такие как click, blur, keypress, keyup, load и прочие
    Catch   Позволяет или запричает распространение события в дереве DOM используя JS вызов stopPropagation при значении true

#### html нотация

Установка событий Pusa возможно в HTML для любого элемента через атрибут data-event:

    <button data-event="Event.Class.Method">
    </button>

## Команды управления браузером

### ChangeURL

Замена URL в адресной строке браузера без перезагрузки страницы.

    URL     полный URL для подмены

### OpenURL

Открытие нового окна с переданным URL

    URL     полный URL для закгрузки
    Target  целевое окно для открытия новой ссылки, поддерживает стандартные свойства _SELF

### ExecuteJS

Прямое исполнение кода JS в браузере. Оставлена на крайний случай и на текущий момент разработчики Pusa не сталкивались с необходимостью ее использования.

    Code    JS код в виде текста

## PHP Реализация PUSA

Текущая реализация PUSA выполнена на PHP в состве Catlair.

## Участники разработки
* still@itserv.ru - идея и реализация;
* chiv@itserv.ru - реализация.



# Ссылки

1. [wiki](https://ru.wikipedia.org/wiki/Pusa_WEB)

