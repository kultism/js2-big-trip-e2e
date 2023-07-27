Feature: 1.9 Обратная связь интерфейса

  Background:
    Given подменяю данные о точках
    Given подменяю данные о направлениях
    Given подменяю данные о предложениях

  Scenario: На время загрузки, вместо списка точек маршрута, отображается сообщение: «Loading...»
    Given нахожусь на главной странице сайта
    Then элемент '.trip-events__msg' содержит текст 'Loading...'
    When запрос на получение данных завершён
    Then элемента '.trip-events__msg' нет на странице

  Scenario: Если не удалось загрузить точки, показывается соответствующее сообщение
    Given сервер не отдаёт данные о точках
    Given нахожусь на главной странице сайта
    Then элемент '.trip-events__msg' содержит текст 'Loading...'
    When запрос на получение данных о точках завершён
    Then элемент '.trip-events__msg' содержит текст 'Failed to load latest route information'

  Scenario: Если не удалось загрузить данные о направлениях, показывается соответствующее сообщение
    Given сервер не отдаёт данные о направлениях
    Given нахожусь на главной странице сайта
    Then элемент '.trip-events__msg' содержит текст 'Loading...'
    When запрос на получение данных о направлениях завершён
    Then элемент '.trip-events__msg' содержит текст 'Failed to load latest route information'

  Scenario: Если не удалось загрузить данные о предложениях, показывается соответствующее сообщение
    Given сервер не отдаёт данные о предложениях
    Given нахожусь на главной странице сайта
    Then элемент '.trip-events__msg' содержит текст 'Loading...'
    When запрос на получение данных о предложениях завершён
    Then элемент '.trip-events__msg' содержит текст 'Failed to load latest route information'

  Scenario: На время выполнения запроса текст заголовка кнопки изменяется
    Given изменённая точка отправляется с задержкой
    Given точка удаляется с задержкой
    Given нахожусь на главной странице сайта
    When кликаю по элементу '.trip-events__list > :nth-child(3) .event__rollup-btn'
    When редактирую точку
    When кликаю по элементу '.event__save-btn'
    Then элемент '.event__save-btn' содержит текст 'Saving...'
    Then запрос на изменение точки завершён
    When жду полсекунды
    When кликаю по элементу '.trip-events__list > :nth-child(5) .event__rollup-btn'
    Then элемент '.event__save-btn' содержит текст 'Save'
    When кликаю по элементу '.trip-events__list > :nth-child(3) .event__rollup-btn'
    Then элемент '.event__save-btn' содержит текст 'Save'
    When кликаю по элементу '.trip-events__list > :nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    Then элемент '.event__reset-btn' содержит текст 'Deleting...'
    When запрос на удаление точки завершён
    When жду полсекунды
    When кликаю по элементу '.trip-events__list > :nth-child(1) .event__rollup-btn'
    Then элемент '.event__reset-btn' содержит текст 'Delete'

  Scenario: В момент отправки запроса на создание точки интерфейс блокируется
    Given подменяю данные о точках
    Given подменяю данные о направлениях
    Given подменяю данные о предложениях
    Given сервер не принимает запросы на создание точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    Then на странице '5' элементов '.event'
    When кликаю по элементу '.trip-main__event-add-btn'
    When заполняю форму
    When кликаю по элементу '.event__save-btn'
    When жду полсекунды
    Then активирую элемент '.event__reset-btn' с помощью клавиатуры
    Then элемент '.event--edit' видим
    Then активирую элемент '.trip-events__list > :nth-child(2) .event__rollup-btn' с помощью клавиатуры
    When запрос на создание точки завершён
    When жду секунду
    Then активирую элемент '.trip-events__list > :nth-child(1) .event__reset-btn' с помощью клавиатуры
    Then элемента '.event--edit' нет на странице

  Scenario: В момент отправки запроса на удаление точки интерфейс блокируется
    Given сервер не принимает запросы на удаление точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    When кликаю по элементу '.trip-events__list > :nth-child(2) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When жду полсекунды
    Then активирую элемент '.trip-events__list > :nth-child(2) .event__rollup-btn' с помощью клавиатуры
    Then элемент '.event--edit' видим
    Then активирую элемент '.trip-main__event-add-btn' с помощью клавиатуры
    Then активирую элемент '.trip-events__list > :nth-child(4) .event__rollup-btn' с помощью клавиатуры
    When запрос на удаление точки завершён
    When жду секунду
    Then активирую элемент '.trip-events__list > :nth-child(2) .event__rollup-btn' с помощью клавиатуры
    Then элемента '.event--edit' нет на странице

  Scenario: В момент отправки запроса на изменение точки форма блокируется
    Given сервер не принимает запросы на изменение точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    When кликаю по элементу '.trip-events__list > :nth-child(3) .event__rollup-btn'
    When редактирую точку
    When кликаю по элементу '.event__save-btn'
    When жду полсекунды
    Then активирую элемент '.trip-events__list > :nth-child(3) .event__rollup-btn' с помощью клавиатуры
    Then элемент '.event--edit' видим
    Then активирую элемент '.trip-main__event-add-btn' с помощью клавиатуры
    Then активирую элемент '.trip-events__list > :nth-child(2) .event__rollup-btn' с помощью клавиатуры
    When запрос на изменение точки завершён
    Then активирую элемент '.trip-events__list > :nth-child(3) .event__rollup-btn' с помощью клавиатуры
    Then элемента '.event--edit' нет на странице

  Scenario: Если запрос не удалось выполнить, форма остаётся открытой
    Given сервер не принимает запросы на изменение точки
    Given сервер не принимает запросы на создание точки
    Given сервер не принимает запросы на удаление точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    When кликаю по элементу '.trip-events__list > :nth-child(3) .event__rollup-btn'
    When редактирую точку
    When кликаю по элементу '.event__save-btn'
    When запрос на изменение точки завершён
    Then точка '3' содержит элемент '.event--edit'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then точка '3' содержит элемент '.event--edit'
    When кликаю по элементу '.trip-main__event-add-btn'
    When заполняю форму
    When кликаю по элементу '.event__save-btn'
    When запрос на создание точки завершён
    Then точка '1' содержит элемент '.event--edit'

  Scenario: Изменение точки происходит только после успешного выполнения запроса к серверу
    Given сервер не принимает запросы на изменение точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    When кликаю по элементу '.trip-events__list > :nth-child(3) .event__rollup-btn'
    When редактирую точку
    When кликаю по элементу '.event__save-btn'
    When запрос на изменение точки завершён
    When жду секунду
    When нажимаю клавишу 'esc'
    Then элемента '.event--edit' нет на странице
    Then точка '3' содержит текст 'Drive Empty destination'

  Scenario: Удаление точки происходит только после успешного выполнения запроса к серверу
    Given сервер не принимает запросы на удаление точки
    Given нахожусь на главной странице сайта
    Then элемента '.event--edit' нет на странице
    Then точка '3' содержит текст 'Drive Empty destination'
    When кликаю по элементу '.trip-events__list > :nth-child(3) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then на странице '5' элементов '.event'

  Scenario: Добавление в избранное происходит только после успешного выполнения запроса к серверу
    Given сервер не принимает запросы на изменение точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    When кликаю по элементу '.trip-events__list > :nth-child(3) .event__favorite-btn'
    When запрос на изменение точки завершён
    Then точка '3' не содержит элемент '.event__favorite-btn--active'
    When кликаю по элементу '.trip-events__list > :nth-child(4) .event__favorite-btn'
    When запрос на изменение точки завершён
    Then точка '4' содержит элемент '.event__favorite-btn--active'

  Scenario: Создание точки происходит только после успешного выполнения запроса к серверу
    Given сервер не принимает запросы на создание точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    Then на странице '5' элементов '.event'
    When кликаю по элементу '.trip-main__event-add-btn'
    When заполняю форму
    When кликаю по элементу '.event__save-btn'
    When запрос на создание точки завершён
    When жду секунду
    When нажимаю клавишу 'esc'
    Then элемента '.event--edit' нет на странице
    Then на странице '5' элементов '.event'

  Scenario: Если не удалось обновить точку, форма «покачивает головой»
    Given сервер не принимает запросы на изменение точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    When кликаю по элементу '.trip-events__list > :nth-child(3) .event__rollup-btn'
    When кликаю по элементу '.event__save-btn'
    When запрос на изменение точки завершён
    Then элемент '.event--edit' "качает головой"

  Scenario: Если не удалось выполнить запрос, точка «покачивает головой»
    Given сервер не принимает запросы на изменение точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    When кликаю по элементу '.trip-events__list > :nth-child(3) .event__favorite-btn'
    When запрос на изменение точки завершён
    Then элемент '.trip-events__list > :nth-child(3)' "качает головой"

  Scenario: Если не удалось создать точку, форма «покачивает головой»
    Given сервер не принимает запросы на создание точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    Then на странице '5' элементов '.event'
    When кликаю по элементу '.trip-main__event-add-btn'
    When заполняю форму
    When кликаю по элементу '.event__save-btn'
    When запрос на создание точки завершён
    Then элемент '.event--edit' "качает головой"

  Scenario: Если не удалось удалить точку, форма «покачивает головой»
    Given сервер не принимает запросы на удаление точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    When кликаю по элементу '.trip-events__list > :nth-child(3) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемент '.event--edit' "качает головой"
