Feature: 1.5 Редактирование точки маршрута

  Background:
    Given подменяю данные о точках
    Given подменяю данные о направлениях
    Given подменяю данные о предложениях
    Given подменяю запрос на изменение точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён

  Scenario: Для перехода к форме пользователь кликает по кнопке «Стрелка вниз»
    Then элемента '.event--edit' нет на странице
    When кликаю по элементу '.trip-events__item:nth-child(2) .event__rollup-btn'
    Then точка '2' содержит элемент '.event--edit'

  Scenario: Форма отрисована корректно [1]
    When кликаю по элементу '.trip-events__item:nth-child(2) .event__rollup-btn'
    Then элемент '.event__save-btn' содержит текст 'Save'
    Then элемент '.event__reset-btn' содержит текст 'Delete'
    Then элемент '.event__type-output' содержит текст 'Check-in'
    Then на странице '1' элементов '[value="taxi"i]'
    Then на странице '1' элементов '[value="bus"i]'
    Then на странице '1' элементов '[value="train"i]'
    Then на странице '1' элементов '[value="ship"i]'
    Then на странице '1' элементов '[value="flight"i]'
    Then на странице '1' элементов '[value="check-in"i]'
    Then на странице '1' элементов '[value="sightseeing"i]'
    Then на странице '1' элементов '[value="restaurant"i]'
    Then значение поля '.event__input--destination' равно 'Full destination'
    Then значение поля '[id*="event-start-time"i]' равно '17/11/20 16:25'
    Then значение поля '[id*="event-end-time"i]' равно '19/11/20 16:55'
    Then значение поля '.event__input--price' равно '4000'
    Then элемент '.event__section--offers' видим
    Then на странице '1' элементов '.event__offer-checkbox'
    Then элемента '.event__offer-checkbox:checked' нет на странице
    Then элемент '.event__destination-description' содержит текст 'Full destination description'
    Then на странице '3' элементов '.event__photo'

  Scenario: Форма отрисована корректно [2]
    When кликаю по элементу '.trip-events__item:nth-child(4) .event__rollup-btn'
    Then значение поля '.event__input--destination' равно 'No pictures destination'
    Then элемент '.event__destination-description' содержит текст 'No pictures destination description'
    Then элемента '.event__photos-container' нет на странице
    Then на странице '5' элементов '.event__offer-checkbox'
    Then на странице '2' элементов '.event__offer-checkbox:checked'

  Scenario: Форма отрисована корректно [3]
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    Then значение поля '.event__input--destination' равно 'Empty destination'
    Then элемента '.event__section--destination' нет на странице
    Then элемента '.event__section--offers' нет на странице

Scenario: Пользователь может выбрать тип точки маршрута
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--taxi'
    Then элемент '.event__type-output' содержит текст 'Taxi'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--bus'
    Then элемент '.event__type-output' содержит текст 'Bus'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--train'
    Then элемент '.event__type-output' содержит текст 'Train'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--ship'
    Then элемент '.event__type-output' содержит текст 'Ship'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--flight'
    Then элемент '.event__type-output' содержит текст 'Flight'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--check-in'
    Then элемент '.event__type-output' содержит текст 'Check-in'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--sightseeing'
    Then элемент '.event__type-output' содержит текст 'Sightseeing'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--restaurant'
    Then элемент '.event__type-output' содержит текст 'Restaurant'

  Scenario: Пункт назначения выбирается из списка предложенных значений
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When в поле '.event__input--destination' ввожу текст 'Full destination'
    When кликаю по элементу '.event__input--price'
    Then значение поля '.event__input--destination' равно 'Full destination'
    Then элемент '.event__destination-description' содержит текст 'Full destination description'
    Then на странице '3' элементов '.event__photo'
    When в поле '.event__input--destination' ввожу текст 'Empty destination'
    When кликаю по элементу '.event__input--price'
    Then значение поля '.event__input--destination' равно 'Empty destination'
    Then элемента '.event__section--destination' нет на странице
    When в поле '.event__input--destination' ввожу текст 'No pictures destination'
    When кликаю по элементу '.event__input--price'
    Then значение поля '.event__input--destination' равно 'No pictures destination'
    Then элемент '.event__destination-description' содержит текст 'No pictures destination description'
    Then элемента '.event__photos-container' нет на странице

  Scenario: Пользователь указывает стоимость
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When в поле '.event__input--price' ввожу текст '1'
    Then значение поля '.event__input--price' равно '1'
    When в поле '.event__input--price' ввожу текст '6000'
    Then значение поля '.event__input--price' равно '6000'

  Scenario: Пользователь может выбрать дополнительные опции
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--flight'
    When кликаю по элементу '.event__offer-selector:nth-child(1) .event__offer-label'
    Then элемент '.event__offer-selector:nth-child(1) .event__offer-checkbox:checked ~.event__offer-label' содержит текст 'Flight Offer #1'
    Then значение поля '.event__input--price' равно '3000'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--taxi'
    Then на странице '5' элементов '.event__offer-checkbox'
    Then элемента '.event__offer-checkbox:checked' нет на странице
    When кликаю по элементу '.event__offer-selector:nth-child(1) .event__offer-label'
    Then элемент '.event__offer-selector:nth-child(1) .event__offer-checkbox:checked ~.event__offer-label' содержит текст 'Taxi Offer #1'
    When кликаю по элементу '.event__offer-selector:nth-child(3) .event__offer-label'
    Then элемент '.event__offer-selector:nth-child(3) .event__offer-checkbox:checked ~.event__offer-label' содержит текст 'Taxi Offer #3'
    When кликаю по элементу '.event__offer-selector:nth-child(3) .event__offer-label'
    Then элемента '.event__offer-selector:nth-child(3) .event__offer-checkbox:checked' нет на странице
    Then значение поля '.event__input--price' равно '3000'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--sightseeing'
    Then элемент '.event__type-output' содержит текст 'Sightseeing'
    Then элемента '.event__section--offers' нет на странице
    Then значение поля '.event__input--price' равно '3000'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--flight'
    Then элемент '.event__section--offers' есть на странице
    Then элемента '.event__offer-checkbox:checked' нет на странице

  Scenario: Нажатие кнопки «Esc» скрывает форму
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    Then элемент '.event--edit' видим
    When нажимаю клавишу 'esc'
    Then элемента '.event--edit' нет на странице

  Scenario: Повторное нажатие кнопки «Стрелка вверх» скрывает форму
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    Then элемент '.event--edit' видим
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    Then элемента '.event--edit' нет на странице

  Scenario: Одновременно может быть открыта только одна форма
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    Then точка '1' содержит элемент '.event--edit'
    When кликаю по элементу '.trip-events__item:nth-child(2) .event__rollup-btn'
    Then на странице '1' элементов '.event--edit'
    Then точка '1' не содержит элемент '.event--edit'
    Then точка '2' содержит элемент '.event--edit'
    When кликаю по элементу '.trip-main__event-add-btn'
    Then на странице '1' элементов '.event--edit'
    Then точка '3' не содержит элемент '.event--edit'

  Scenario: При отмене несохранённые изменения пропадают
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--flight'
    When нажимаю клавишу 'esc'
    Then точка '1' не содержит элемент '.event--edit'
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    Then элемент '.event__type-output' содержит текст 'Sightseeing'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--flight'
    When кликаю по элементу '.trip-events__item:nth-child(2) .event__rollup-btn'
    When кликаю по элементу '.trip-events__item:nth-child(1) .event__rollup-btn'
    Then элемент '.event__type-output' содержит текст 'Sightseeing'
    When кликаю по элементу '.event__type-btn'
    When кликаю по элементу '.event__type-label--flight'
    When кликаю по элементу '.trip-main__event-add-btn'
    When кликаю по элементу '.trip-events__item:nth-child(2) .event__rollup-btn'
    Then элемент '.event__type-output' содержит текст 'Sightseeing'

  Scenario: Форма отправляется с правильными данными
    When кликаю по элементу '.trip-events__item:nth-child(3) .event__rollup-btn'
    When редактирую точку
    When кликаю по элементу '.event__save-btn'
    Then запрос на изменение точки отправлен с правильными данными

  Scenario: Обновлённая точка располагается в списке в соответствии с датой начала
    When кликаю по элементу '.trip-events__item:nth-child(3) .event__rollup-btn'
    When редактирую точку
    When кликаю по элементу '.event__save-btn'
    Then запрос на изменение точки завершён
    Then точка '5' содержит текст 'Taxi Full destination'
