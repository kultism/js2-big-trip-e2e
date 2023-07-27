Feature: 2 Дополнительные задания

  Background:
    Given подменяю данные о точках
    Given подменяю данные о направлениях
    Given подменяю данные о предложениях
    Given подменяю запрос на удаление точки
    Given подменяю запрос на изменение точки
    Given подменяю запрос на создание точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    Then на странице '5' элементов '.event'

  Scenario: Наименование маршрута путешествия состоит из пунктов назначения
    Then элемент '.trip-info__title' содержит текст 'Empty destination'
    Then элемент '.trip-info__title' содержит текст 'No pictures destination'
    When кликаю по элементу '.trip-events__item:nth-child(3) .event__rollup-btn'
    When редактирую точку
    When кликаю по элементу '.event__save-btn'
    Then запрос на изменение точки завершён
    Then элемент '.trip-info__title' содержит текст 'Empty destination'
    Then элемент '.trip-info__title' содержит текст 'Full destination'
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемент '.trip-info__title' содержит текст 'No pictures destination'
    Then элемент '.trip-info__title' не содержит текст '...'
    Then элемент '.trip-info__title' содержит текст 'Full destination'
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемент '.trip-info__title' не содержит текст 'No pictures destination'
    Then элемент '.trip-info__title' не содержит текст '...'
    Then элемент '.trip-info__title' содержит текст 'Full destination'

  Scenario: Фильтры и сортировка не влияют на наименование маршрута
    When кликаю по элементу '[for="filter-present"i]'
    Then элемент '.trip-info__title' содержит текст 'Empty destination'
    Then элемент '.trip-info__title' содержит текст 'No pictures destination'
    When кликаю по элементу '[for="filter-everything"i]'
    When кликаю по элементу '[for="sort-time"i]'
    Then элемент '.trip-info__title' содержит текст 'Empty destination'
    Then элемент '.trip-info__title' содержит текст 'No pictures destination'

  Scenario: Даты путешествия в шапке заполняются автоматически
    Then элемент '.trip-info__dates' содержит текст '17 FEB'
    Then элемент '.trip-info__dates' содержит текст '21 APR'
    When кликаю по элементу '.trip-events__item:nth-child(3) .event__rollup-btn'
    When редактирую точку
    When кликаю по элементу '.event__save-btn'
    Then запрос на изменение точки завершён
    Then элемент '.trip-info__dates' содержит текст '17 FEB'
    Then элемент '.trip-info__dates' содержит текст '15 JUL'
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемент '.trip-info__dates' содержит текст '17 NOV'
    Then элемент '.trip-info__dates' содержит текст '15 JUL'

  Scenario: Фильтры и сортировка не влияют даты путешествия
    When кликаю по элементу '[for="filter-present"i]'
    Then элемент '.trip-info__dates' содержит текст '17 FEB'
    Then элемент '.trip-info__dates' содержит текст '21 APR'
    When кликаю по элементу '[for="filter-everything"i]'
    When кликаю по элементу '[for="sort-time"i]'
    Then элемент '.trip-info__dates' содержит текст '17 FEB'
    Then элемент '.trip-info__dates' содержит текст '21 APR'

  Scenario: Общая стоимость пересчитывается при создании/изменении/удалении точки
    Then элемент '.trip-info__cost-value' содержит текст '15301'
    When кликаю по элементу '.trip-events__item:nth-child(3) .event__rollup-btn'
    When редактирую точку
    When кликаю по элементу '.event__save-btn'
    Then запрос на изменение точки завершён
    Then элемент '.trip-info__cost-value' содержит текст '24211'
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемент '.trip-info__cost-value' содержит текст '21211'
    When кликаю по элементу '.trip-main__event-add-btn'
    When заполняю форму
    When кликаю по элементу '.event__save-btn'
    When запрос на создание точки завершён
    Then элемент '.trip-info__cost-value' содержит текст '27311'

  Scenario: Информация о путешествии отображается, если есть точки, и удаляется, если нет
    Given сервер отдаёт пустой список точек
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    Then элемент 'body' содержит текст 'Click New Event to create your first point'
    Then элемента '.trip-info' нет на странице
    When кликаю по элементу '.trip-main__event-add-btn'
    When заполняю форму
    When кликаю по элементу '.event__save-btn'
    When запрос на создание точки завершён
    Then элемент '.trip-info__title' содержит текст 'Full destination'
    Then элемент '.trip-info__dates' содержит текст '15 JUL'
    Then элемент '.trip-info__dates' содержит текст '16 JUL'
    Then элемент '.trip-info__cost-value' содержит текст '6100'
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемента '.trip-info' нет на странице

  Scenario: Кнопка фильтра становится недоступной, если фильтру не соответствует ни одна из точек [1]
    When кликаю по элементу '[for="filter-present"i]'
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемент '[id="filter-present"i]' содержит атрибут 'disabled'
    When кликаю по элементу '[for="filter-future"i]'
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемент '[id="filter-future"i]' содержит атрибут 'disabled'
    Then элемент '[id="filter-present"i]' содержит атрибут 'disabled'
    When кликаю по элементу '[for="filter-past"i]'
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемент '[id="filter-future"i]' содержит атрибут 'disabled'
    Then элемент '[id="filter-present"i]' содержит атрибут 'disabled'
    Then элемент '[id="filter-past"i]' содержит атрибут 'disabled'
    Then элемент '[id="filter-everything"i]' содержит атрибут 'disabled'

  Scenario: Кнопка фильтра становится недоступной, если фильтру не соответствует ни одна из точек [2]
    Given сервер отдаёт пустой список точек
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    Then элемент '[id="filter-future"i]' содержит атрибут 'disabled'
    Then элемент '[id="filter-present"i]' содержит атрибут 'disabled'
    Then элемент '[id="filter-past"i]' содержит атрибут 'disabled'
    Then элемент '[id="filter-everything"i]' содержит атрибут 'disabled'
