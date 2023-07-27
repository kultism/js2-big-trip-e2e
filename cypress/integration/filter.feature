Feature: 1.6 Фильтры

  Background:
    Given подменяю данные о точках
    Given подменяю данные о направлениях
    Given подменяю данные о предложениях
    Given подменяю запрос на удаление точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    Then на странице '5' элементов '.event'

  Scenario: В приложении предусмотрено несколько фильтров: Everything, Future, Present, Past
    Then на странице '4' элементов '.trip-filters__filter'
    Then элемент '.trip-filters__filter:nth-child(1)' содержит текст 'EVERYTHING'
    Then элемент '.trip-filters__filter:nth-child(2)' содержит текст 'FUTURE'
    Then элемент '.trip-filters__filter:nth-child(3)' содержит текст 'PRESENT'
    Then элемент '.trip-filters__filter:nth-child(4)' содержит текст 'PAST'

  Scenario: Выбор любого из фильтров приводит к отрисовке только соответствующих точек
    When кликаю по элементу '[for*="past"i]'
    Then элемент '[id*="past"i]:checked' есть на странице
    Then на странице '3' элементов '.event'
    When кликаю по элементу '[for*="present"i]'
    Then элемент '[id*="present"i]:checked' есть на странице
    Then на странице '1' элементов '.event'
    When кликаю по элементу '[for*="future"i]'
    Then элемент '[id*="future"i]:checked' есть на странице
    Then на странице '1' элементов '.event'
    When кликаю по элементу '[for*="everything"i]'
    Then элемент '[id*="everything"i]:checked' есть на странице
    Then на странице '5' элементов '.event'

  Scenario: Если удалены все точки, отображается соответствующий текст [1]
    When кликаю по элементу '[for*="present"i]'
    When кликаю по элементу '.trip-events__list > :nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемент '.trip-events__msg' содержит текст 'There are no present events now'
    When кликаю по элементу '[for*="future"i]'
    Then элемента '.trip-events__msg' нет на странице
    When кликаю по элементу '.trip-events__list > :nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемент '.trip-events__msg' содержит текст 'There are no future events now'
    When кликаю по элементу '[for*="past"i]'
    Then элемента '.trip-events__msg' нет на странице
    When кликаю по элементу '.trip-events__list > :nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    When кликаю по элементу '.trip-events__list > :nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    When кликаю по элементу '.trip-events__list > :nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемент '.trip-events__msg' содержит текст 'There are no past events now'

  Scenario: Если удалены все точки, отображается соответствующий текст [2]
    When кликаю по элементу '.trip-events__list > :nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    When кликаю по элементу '.trip-events__list > :nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    When кликаю по элементу '.trip-events__list > :nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    When кликаю по элементу '.trip-events__list > :nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    When кликаю по элементу '.trip-events__list > :nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__reset-btn'
    When запрос на удаление точки завершён
    Then элемент '.trip-events__msg' содержит текст 'Click New Event to create your first point'
