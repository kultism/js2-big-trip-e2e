import { Then } from 'cypress-cucumber-preprocessor/steps';
import dayjs from 'dayjs';

Then(/^точка '(.*)' содержит текст '(.*)'$/, (count, text) => {
  cy.get('.trip-events__list > *')
    .eq(count - 1)
    .should(($el) => {
      const elText = $el.text().trim().toLowerCase();
      expect(elText).to.include(text.toLowerCase());
    });
});

Then(/^точка '(.*)' не содержит текст '(.*)'$/, (count, text) => {
  cy.get('.trip-events__list > *')
    .eq(count - 1)
    .contains(text)
    .should('not.exist');
});

Then(/^точка '(.*)' содержит корректное время '(.*)' и '(.*)'$/, (count, startDate, endDate) => {
  cy.get('.trip-events__list > *')
    .eq(count - 1)
    .find('.event__time time')
    .then(($pointElements) => {
      const [startTimeElement, endTimeElement] = [$pointElements[0], $pointElements[1]];
      expect(endTimeElement.textContent.trim()).equal(dayjs(endDate).format('HH:mm'));
      expect(startTimeElement.textContent.trim()).equal(dayjs(startDate).format('HH:mm'));
  });
});

Then(/^форма содержит корректное время начала '(.*)'$/, (startDate) => {
  cy.get('[id*="event-start-time"i]')
    .then(($inputElements) => {
      const startTimeElement = $inputElements[0];
      expect(startTimeElement.value.trim()).equal(dayjs(startDate).format('DD/MM/YY HH:mm'));
  });
});

Then(/^форма содержит корректное время конца '(.*)'$/, (endDate) => {
  cy.get('[id*="event-end-time"i]')
    .then(($inputElements) => {
      const endTimeElement = $inputElements[0];
      expect(endTimeElement.value.trim()).equal(dayjs(endDate).format('DD/MM/YY HH:mm'));
  });
});

Then(/^точка '(.*)' содержит элемент '(.*)'$/, (count, selector) => {
  cy.get('.trip-events__list > *')
    .eq(count - 1)
    .find(selector)
    .should('exist');
});

Then(/^точка '(.*)' не содержит элемент '(.*)'$/, (count, selector) => {
  cy.get('.trip-events__list > *')
    .eq(count - 1)
    .find(selector)
    .should('not.exist');
});

When(/^заполняю форму$/, () => {
  cy.get('[for*="event-type-toggle"i]').click({force: true});
  cy.get('[for*="event-type-train"i]').click({force: true});
  cy.get('.event__input--destination').click({force: true});
  cy.get('.event__input--destination').type(`{selectAll}{backspace}Full destination`);
  cy.get('.event__input--price').click({force: true});
  cy.get('.event__input--price').type(`{selectAll}{backspace}${6000}`);
  cy.get('[id*="event-start-time"i]').click({force: true});
  cy.get('.flatpickr-day.today:first')
    .click({force: true});
  cy.get('.event__input--destination').click({force: true});
  cy.get('[id*="event-end-time"i]').click({force: true});
  cy.get('.flatpickr-day.today:last')
    .click({force: true});
  cy.get('.numInput.flatpickr-hour:last')
    .click({force: true});
  cy.get('body').type('{upArrow}');
  cy.get('.event__input--destination').click({force: true});
  cy.get('.event__offer-selector:nth-child(1) .event__offer-label').click({force: true});
  cy.get('.event__offer-selector:nth-child(1) .event__offer-checkbox:checked').should('exist');
});

Then(/^запрос на создание новой точки отправлен с правильными данными$/, () => {
  cy.wait('@postPoint')
    .its('request.body')
    .then((body) => {
      console.log(body);
      const { base_price, destination, offers, type } = body;
      expect(base_price,).to.eq(6000);
      expect(destination).to.eq('full-destination');
      expect(offers.length).to.eq(1);
      expect(offers[0]).to.eq('train-1');
      expect(type).to.eq('train');
    });
});

When(/^редактирую точку$/, () => {
  cy.get('[for*="event-type-toggle"i]').click({force: true});
  cy.get('[for*="event-type-train"i]').click({force: true});
  cy.get('.event__input--destination').click({force: true});
  cy.get('.event__input--destination').type(`{selectAll}{backspace}Full destination`);
  cy.get('.event__input--price').click({force: true});
  cy.get('.event__input--price').type(`{selectAll}{backspace}${9000}`);
  cy.get('.event__offer-selector:nth-child(1) .event__offer-label').click({force: true});
  cy.get('.event__offer-selector:nth-child(1) .event__offer-checkbox:checked').should('exist');
});

Then(/^запрос на изменение точки отправлен с правильными данными$/, () => {
  cy.wait('@updatePoint')
    .its('request.body')
    .then((body) => {
      console.log(body);
      const { base_price, date_from, date_to, destination, offers, type } = body;
      expect(base_price,).to.eq(9000);
      expect(date_from).to.eq('2023-07-15T13:30:00.000Z');
      expect(date_to).to.eq('2023-07-15T14:00:00.000Z');
      expect(destination).to.eq('full-destination');
      expect(offers.length).to.eq(1);
      expect(offers[0]).to.eq('train-1');
      expect(type).to.eq('train');
    });
});
