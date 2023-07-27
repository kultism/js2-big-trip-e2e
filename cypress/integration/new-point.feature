Feature: 1.4 Новая точка маршрута

  Background:
    Given подменяю данные о точках
    Given подменяю данные о направлениях
    Given подменяю данные о предложениях
    Given подменяю запрос на создание точки
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    Then на странице '5' элементов '.event'

  Scenario: Новая точка маршрута создаётся нажатием на кнопку «New Event»
    Then элемента '.event--edit' нет на странице
    When кликаю по элементу '.trip-main__event-add-btn'
    Then на странице '6' элементов '.event'
    Then на странице '1' элементов '.event--edit'

  Scenario: Форма создания новой точки маршрута появляется в самом начале списка
    Then точка '1' не содержит элемент '.event--edit'
    When кликаю по элементу '.trip-main__event-add-btn'
    Then точка '1' содержит элемент '.event--edit'

  Scenario: Кнопка блокируется на время создания новой точки
    Then элемент '.trip-main__event-add-btn' не содержит атрибут 'disabled'
    When кликаю по элементу '.trip-main__event-add-btn'
    Then элемент '.trip-main__event-add-btn' содержит атрибут 'disabled'

  Scenario: Если был выбран фильтр или применена сортировка, то они сбрасываются
    When кликаю по элементу '[for*="past"i]'
    Then элемент '[id*="past"i]:checked' есть на странице
    When кликаю по элементу '[for*="price"i]'
    Then элемент '[id*="price"i]:checked' есть на странице
    When кликаю по элементу '.trip-main__event-add-btn'
    Then элемента '[id*="price"i]:checked' нет на странице
    Then элемент '[id*="everything"i]:checked' есть на странице
    Then элемент '[id*="day"i]:checked' есть на странице

  Scenario: Нажатие кнопки «Esc» скрывает форму создания новой точки маршрута
    When кликаю по элементу '.trip-main__event-add-btn'
    Then элемент '.event--edit' видим
    When нажимаю клавишу 'esc'
    Then элемента '.event--edit' нет на странице

  Scenario: Нажатие кнопки «Cancel» скрывает форму создания новой точки маршрута
    When кликаю по элементу '.trip-main__event-add-btn'
    Then элемент '.event--edit' видим
    When кликаю по элементу '.event__reset-btn'
    Then элемента '.event--edit' нет на странице

  Scenario: При отмене несохранённые изменения пропадают
    When кликаю по элементу '.trip-main__event-add-btn'
    When заполняю форму
    When нажимаю клавишу 'esc'
    When кликаю по элементу '.trip-main__event-add-btn'
    Then элемент '.event__type-output' не содержит текст 'Train'
    Then значение поля '.event__input--destination' равно ''
    Then значение поля '[id*="event-start-time"i]' равно ''
    Then значение поля '[id*="event-end-time"i]' равно ''
    Then значение поля '.event__input--price' равно '0'
    Then элемента '.event__offer-checkbox:checked' нет на странице

  Scenario: Нажатие на кнопку «New Event» закрывает открытую форму редактирования точки маршрута
    When кликаю по элементу '.trip-events__list > :nth-child(2) .event__rollup-btn'
    Then точка '2' содержит элемент '.event--edit'
    Then значение поля '.event__input--destination' равно 'Full destination'
    When в поле '.event__input--destination' ввожу текст 'Empty destination'
    Then значение поля '.event__input--destination' равно 'Empty destination'
    When кликаю по элементу '.trip-main__event-add-btn'
    Then точка '1' содержит элемент '.event--edit'
    Then точка '2' не содержит элемент '.event--edit'
    Then точка '3' не содержит элемент '.event--edit'
    When кликаю по элементу '.trip-events__list > :nth-child(3) .event__rollup-btn'
    Then точка '1' не содержит элемент '.event--edit'
    Then точка '2' содержит элемент '.event--edit'
    Then точка '3' не содержит элемент '.event--edit'
    Then значение поля '.event__input--destination' равно 'Full destination'

  Scenario: Пустая форма создания новой точки отрисована корректно
    When кликаю по элементу '.trip-main__event-add-btn'
    Then элемент '.event__save-btn' содержит текст 'Save'
    Then элемент '.event__reset-btn' содержит текст 'Cancel'
    Then элемент '.event__type-output' содержит текст 'Flight'
    Then на странице '1' элементов '[id*="event-type-taxi"i]'
    Then на странице '1' элементов '[id*="event-type-bus"i]'
    Then на странице '1' элементов '[id*="event-type-train"i]'
    Then на странице '1' элементов '[id*="event-type-ship"i]'
    Then на странице '1' элементов '[id*="event-type-flight"i]'
    Then на странице '1' элементов '[id*="event-type-check-in"i]'
    Then на странице '1' элементов '[id*="event-type-sightseeing"i]'
    Then на странице '1' элементов '[id*="event-type-restaurant"i]'
    Then значение поля '.event__input--destination' равно ''
    Then значение поля '[id*="event-start-time"i]' равно ''
    Then значение поля '[id*="event-end-time"i]' равно ''
    Then значение поля '.event__input--price' равно '0'
    Then элемент '.event__section--offers' видим
    Then на странице '1' элементов '.event__offer-checkbox'
    Then элемента '.event__offer-checkbox:checked' нет на странице
    Then элемента '.event__section--destination' нет на странице

  Scenario: Пользователь может выбрать тип точки маршрута
    When кликаю по элементу '.trip-main__event-add-btn'
    When кликаю по элементу '[for*="event-type-toggle"i]'
    When кликаю по элементу '[for*="event-type-taxi"i]'
    Then элемент '.event__type-output' содержит текст 'Taxi'
    When кликаю по элементу '[for*="event-type-toggle"i]'
    When кликаю по элементу '[for*="event-type-bus"i]'
    Then элемент '.event__type-output' содержит текст 'Bus'
    When кликаю по элементу '[for*="event-type-toggle"i]'
    When кликаю по элементу '[for*="event-type-train"i]'
    Then элемент '.event__type-output' содержит текст 'Train'
    When кликаю по элементу '[for*="event-type-toggle"i]'
    When кликаю по элементу '[for*="event-type-ship"i]'
    Then элемент '.event__type-output' содержит текст 'Ship'
    When кликаю по элементу '[for*="event-type-toggle"i]'
    When кликаю по элементу '[for*="event-type-flight"i]'
    Then элемент '.event__type-output' содержит текст 'Flight'
    When кликаю по элементу '[for*="event-type-toggle"i]'
    When кликаю по элементу '[for*="event-type-check-in"i]'
    Then элемент '.event__type-output' содержит текст 'Check-in'
    When кликаю по элементу '[for*="event-type-toggle"i]'
    When кликаю по элементу '[for*="event-type-sightseeing"i]'
    Then элемент '.event__type-output' содержит текст 'Sightseeing'
    When кликаю по элементу '[for*="event-type-toggle"i]'
    When кликаю по элементу '[for*="event-type-restaurant"i]'
    Then элемент '.event__type-output' содержит текст 'Restaurant'

  Scenario: Пункт назначения выбирается из списка предложенных значений
    When кликаю по элементу '.trip-main__event-add-btn'
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

  Scenario: Пользователь выбирает дату и время начала события
    Given сервер отдаёт пустой список точек
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    Then элемент 'body' содержит текст 'Click New Event to create your first point'
    When кликаю по элементу '.trip-main__event-add-btn'
    When кликаю по элементу '[id*="event-start-time"i]'
    Then элемент '.flatpickr-calendar' видим
    When кликаю по элементу '.flatpickr-day.today:first'
    Then элемент '.flatpickr-calendar' видим
    When кликаю по элементу '.event__input--destination'
    When кликаю по элементу '[id*="event-end-time"i]'
    Then элемент '.flatpickr-calendar' видим
    When кликаю по элементу '.flatpickr-day.today:last'
    Then элемент '.flatpickr-calendar' видим
    When кликаю по элементу '.numInput.flatpickr-hour:last'
    When нажимаю клавишу 'upArrow'
    When кликаю по элементу '.event__input--destination'

  Scenario: Пользователь указывает стоимость
    When кликаю по элементу '.trip-main__event-add-btn'
    When в поле '.event__input--price' ввожу текст '1'
    Then значение поля '.event__input--price' равно '1'
    When в поле '.event__input--price' ввожу текст '6000'
    Then значение поля '.event__input--price' равно '6000'

  Scenario: Пользователь может выбрать дополнительные опции
    When кликаю по элементу '.trip-main__event-add-btn'
    When в поле '.event__input--price' ввожу текст '1'
    When кликаю по элементу '.event__offer-selector:nth-child(1) .event__offer-label'
    Then элемент '.event__offer-selector:nth-child(1) .event__offer-checkbox:checked ~.event__offer-label' содержит текст 'Flight Offer #1'
    Then значение поля '.event__input--price' равно '1'
    When кликаю по элементу '[for*="event-type-toggle"i]'
    When кликаю по элементу '[for*="event-type-taxi"i]'
    Then на странице '5' элементов '.event__offer-checkbox'
    Then элемента '.event__offer-checkbox:checked' нет на странице
    When кликаю по элементу '.event__offer-selector:nth-child(1) .event__offer-label'
    Then элемент '.event__offer-selector:nth-child(1) .event__offer-checkbox:checked ~.event__offer-label' содержит текст 'Taxi Offer #1'
    When кликаю по элементу '.event__offer-selector:nth-child(3) .event__offer-label'
    Then элемент '.event__offer-selector:nth-child(3) .event__offer-checkbox:checked ~.event__offer-label' содержит текст 'Taxi Offer #3'
    When кликаю по элементу '.event__offer-selector:nth-child(3) .event__offer-label'
    Then элемента '.event__offer-selector:nth-child(3) .event__offer-checkbox:checked' нет на странице
    Then значение поля '.event__input--price' равно '1'
    When кликаю по элементу '[for*="event-type-toggle"i]'
    When кликаю по элементу '[for*="event-type-sightseeing"i]'
    Then элемент '.event__type-output' содержит текст 'Sightseeing'
    Then элемента '.event__section--offers' нет на странице
    Then значение поля '.event__input--price' равно '1'
    When кликаю по элементу '[for*="event-type-toggle"i]'
    When кликаю по элементу '[for*="event-type-flight"i]'
    Then элемент '.event__section--offers' есть на странице
    Then элемента '.event__offer-checkbox:checked' нет на странице

  Scenario: Новая точка отправляется с правильными данными
    Given сервер отдаёт пустой список точек
    Given нахожусь на главной странице сайта
    When запрос на получение данных завершён
    Then элемент 'body' содержит текст 'Click New Event to create your first point'
    When кликаю по элементу '.trip-main__event-add-btn'
    When заполняю форму
    When кликаю по элементу '.event__save-btn'
    Then запрос на создание новой точки отправлен с правильными данными

  Scenario: Новая точка располагается в списке в соответствии с датой начала
    When кликаю по элементу '.trip-main__event-add-btn'
    When заполняю форму
    When кликаю по элементу '.event__save-btn'
    When запрос на создание точки завершён
    Then точка '4' содержит текст 'Train Full destination'
