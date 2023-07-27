import { Given } from 'cypress-cucumber-preprocessor/steps';

const baseApiUrl = Cypress.config('baseApiUrl');
const APIRoute = {
  POINTS: `${baseApiUrl}/points`,
  DESTINATIONS: `${baseApiUrl}/destinations`,
  OFFERS: `${baseApiUrl}/offers`,
};
const firstPointUrl = `${APIRoute.POINTS}/point-1`;
const secondPointUrl = `${APIRoute.POINTS}/point-2`;

Given(/^подменяю данные о точках$/, () => {
  cy.intercept('GET', APIRoute.POINTS, {
    fixture: 'points.json',
  }).as('getPoints');
});

Given(/^подменяю данные о направлениях$/, () => {
  cy.intercept('GET', APIRoute.DESTINATIONS, {
    fixture: 'destinations.json',
  }).as('getDestinations');
});

Given(/^подменяю данные о предложениях$/, () => {
  cy.intercept('GET', APIRoute.OFFERS, {
    fixture: 'offers.json',
  }).as('getOffers');
});

Given(/^сервер отдаёт пустой список точек$/, () => {
  cy.intercept(
    {
      method: 'GET',
      url: APIRoute.POINTS,
    },
    {
      statusCode: 200,
      body: [],
    }
  ).as('getPoints');
});

Given(/^сервер не отдаёт данные о точках$/, () => {
  cy.intercept({
    method: 'GET',
    url: APIRoute.POINTS
  }, {
    statusCode: 500
  }).as('getPoints');
});

Given(/^сервер не отдаёт данные о направлениях$/, () => {
  cy.intercept({
    method: 'GET',
    url: APIRoute.DESTINATIONS
  }, {
    statusCode: 500
  }).as('getDestinations');
});

Given(/^сервер не отдаёт данные о предложениях$/, () => {
  cy.intercept({
    method: 'GET',
    url: APIRoute.DESTINATIONS
  }, {
    statusCode: 500
  }).as('getOffers');
});

When(/^запрос на получение данных о точках завершён$/, () => {
  cy.wait('@getPoints');
});

When(/^запрос на получение данных о направлениях завершён$/, () => {
  cy.wait('@getDestinations');
});

When(/^запрос на получение данных о предложениях завершён$/, () => {
  cy.wait('@getOffers');
});

When(/^запрос на получение данных завершён$/, () => {
  cy.wait(['@getPoints', '@getDestinations', '@getOffers']);
});

Given(/^подменяю запрос на создание точки$/, () => {
  cy.intercept(
    'POST', APIRoute.POINTS,
    {
      fixture: 'new-point.json'
    }
  ).as('postPoint');
});

Given(/^сервер не принимает запросы на создание точки$/, () => {
  cy.intercept({
    method: 'POST',
    url: APIRoute.POINTS
  }, {
    statusCode: 500
  }).as('postPoint');
});

Given(/^новая точка отправляется с задержкой$/, () => {
  cy.intercept({
    method: 'POST',
    url: APIRoute.POINTS
  }, {
    statusCode: 200,
    delayMs: 500,
    fixture: 'new-point.json',
  })
    .as('postPoint');
});

When(/^запрос на создание точки завершён$/, () => {
  cy.wait('@postPoint');
});

Given(/^подменяю запрос на добавление точки в избранное$/, () => {
  cy.intercept(
    'PUT', firstPointUrl,
    {
      fixture: 'favorite-point.json'
    }
  ).as('addFavoritePoint');
});

Given(/^подменяю запрос на удаление точки из избранного$/, () => {
  cy.intercept(
    'PUT', secondPointUrl,
    {
      fixture: 'unfavorite-point.json'
    }
  ).as('removeFavoritePoint');
});

When(/^запрос на добавление точки в избранное завершён$/, () => {
  cy.wait('@addFavoritePoint');
});

When(/^запрос на удаление точки из избранного завершён$/, () => {
  cy.wait('@removeFavoritePoint');
});

Given(/^сервер не принимает запросы на изменение точки$/, () => {
  cy.intercept({
    method: 'PUT',
    url: `${APIRoute.POINTS}/*`
  }, {
    statusCode: 500
  }).as('updatePoint');
});

Given(/^изменённая точка отправляется с задержкой$/, () => {
  cy.intercept({
    method: 'PUT',
    url: firstPointUrl
  }, {
    statusCode: 200,
    delayMs: 500,
    fixture: 'updated-point.json'
  })
    .as('updatePoint');
});

Given(/^подменяю запрос на изменение точки$/, () => {
  cy.intercept(
    'PUT', firstPointUrl,
    {
      fixture: 'updated-point.json'
    }
  ).as('updatePoint');
});

When(/^запрос на изменение точки завершён$/, () => {
  cy.wait('@updatePoint');
});

Given(/^подменяю запрос на удаление точки$/, () => {
  cy.intercept(
    {
      method: 'DELETE',
      url: `${APIRoute.POINTS}/*`,
    },
    {
      statusCode: 204,
    }
  ).as('deletePoint');
});

Given(/^сервер не принимает запросы на удаление точки$/, () => {
  cy.intercept({
    method: 'DELETE',
    url: `${APIRoute.POINTS}/*`
  }, {
    statusCode: 500
  }).as('deletePoint');
});

Given(/^точка удаляется с задержкой$/, () => {
  cy.intercept({
    method: 'DELETE',
    url: `${APIRoute.POINTS}/*`
  }, {
    statusCode: 204,
    delayMs: 500,
  })
    .as('deletePoint');
});

When(/^запрос на удаление точки завершён$/, () => {
  cy.wait('@deletePoint');
});
