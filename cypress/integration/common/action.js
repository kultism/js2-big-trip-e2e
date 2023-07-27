import { Given, When } from 'cypress-cucumber-preprocessor/steps';

Given('нахожусь на главной странице сайта', () => {
  cy.visit('/');
});

When(/^кликаю по элементу '(.*)'$/, (selector) => {
  cy.get(selector).click({force: true});
});

When(/^нажимаю клавишу '(.*)'$/, (key) => {
  cy.get('body').type(`{${key}}`);
});

When(/^в поле '(.*)' ввожу текст '(.*)'$/, (selector, text) => {
  cy.get(selector).type(`{selectAll}{backspace}${text}`);
});

When(/^чекаю элемент '(.*)'$/, (selector) => {
  cy.get(selector).check({force: true});
});

When(/^жду секунду$/, () => {
  cy.wait(1000);
});
