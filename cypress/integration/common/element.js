import { Then } from 'cypress-cucumber-preprocessor/steps';

Then(/^элемент '(.*)' видим$/, (selector) => {
  cy.get(selector).should('be.visible');
});

Then(/^элемент '(.*)' невидим$/, (selector) => {
  cy.get(selector).should('not.be.visible');
});

Then(/^элемент '(.*)' есть на странице$/, (selector) => {
  cy.get(selector).should('exist');
});

Then(/^элемента '(.*)' нет на странице$/, (selector) => {
  cy.get(selector).should('not.exist');
});

Then(/^элемент '(.*)' содержит текст '(.*)'$/, (selector, text) => {
  cy.get(selector).should(($el) => {
    const elText = $el.text().trim().toLowerCase();
    expect(elText).to.include(text.toLowerCase());
  });
});

Then(/^элемент '(.*)' не содержит текст '(.*)'$/, (selector, text) => {
  cy.get(selector).should(($el) => {
    const elText = $el.text().trim().toLowerCase();
    expect(elText).to.not.include(text.toLowerCase());
  });
});

Then(/^на странице '(.*)' элементов '(.*)'$/, (count, selector) => {
  cy.get(selector).should('have.length', count);
});

Then(/^элемент '(.*)' содержит атрибут '(.*)'$/, (selector, attr) => {
  cy.get(selector).should('have.attr', attr);
});

Then(/^элемент '(.*)' не содержит атрибут '(.*)'$/, (selector, attr) => {
  cy.get(selector).should('not.have.attr', attr);
});

Then(/^значение поля '(.*)' равно '(.*)'$/, (selector, value) => {
  cy.get(selector)
    .should('have.value', value);
});

Then(/^элемент '(.*)' "качает головой"$/, (selector) => {
  let startPosition;
  cy
    .get(selector)
    .then(($element) => {
      startPosition = $element[0].getBoundingClientRect();
    });
  cy.wait(300);
  cy
    .get(selector)
    .then(($element) => $element[0].getBoundingClientRect())
    .then(({x}) => {
      expect(x).to.not.eq(startPosition.x);
    });
});
