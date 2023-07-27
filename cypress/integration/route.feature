Feature: 1.2 Маршрут

  Background:
    Given подменяю данные о точках
    Given подменяю данные о направлениях
    Given подменяю данные о предложениях
    Given нахожусь на главной странице сайта

  Scenario: Точки маршрута загружаются при старте приложения.
    Then элемента '.event--edit' нет на странице
    Then элемента '.event' нет на странице
    When запрос на получение данных завершён
    Then на странице '5' элементов '.event'
    Then элемента '.event--edit' нет на странице

  Scenario: Точки маршрута по умолчанию сортируются по дате
    When запрос на получение данных завершён
    Then точка '1' содержит текст 'Sightseeing Empty destination'
    Then точка '1' содержит текст 'Feb 17'
    Then точка '2' содержит текст 'Check-in Full destination'
    Then точка '2' содержит текст 'Nov 17'
    Then точка '3' содержит текст 'Drive Empty destination'
    Then точка '3' содержит текст 'Jul 15'
    Then точка '4' содержит текст 'Taxi No pictures destination'
    Then точка '4' содержит текст 'Jul 16'
    Then точка '5' содержит текст 'Train No pictures destination'
    Then точка '5' содержит текст 'Apr 19'

  Scenario: В случае отсутствия точек отображается соответствующий текст
    Given сервер отдаёт пустой список точек
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    Then элемента '.event--edit' нет на странице
    Then элемента '.event' нет на странице
    Then элемент 'body' содержит текст 'Click New Event to create your first point'
    When кликаю по элементу '.trip-main__event-add-btn'
    Then элемент 'body' не содержит текст 'Click New Event to create your first point'
    When нажимаю клавишу 'esc'
    Then элемент 'body' содержит текст 'Click New Event to create your first point'
