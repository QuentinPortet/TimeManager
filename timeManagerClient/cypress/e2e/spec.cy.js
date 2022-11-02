describe('empty spec', () => {
  it('Is client server started', () => {
    cy.visit('http://localhost:5173')
  })
  it('can create user', () => {
    cy.visit('http://localhost:5173')
    cy.contains('Add new user').click()
    cy.wait(500)
    cy.get('#newUsername').type('Michel Sardou').should('have.value', 'Michel Sardou')
    cy.get('#newEmail').type('michel.sardou@gmail.com').should('have.value','michel.sardou@gmail.com') 
    cy.get('[style="z-index: 2;"] > .vfm__container > .vfm__content > .card > .content > form > .fancy-button').click()
  })
  it('Michel Sardou into users list', () => {
    cy.visit('http://localhost:5173')
    cy.get('.hidden-scrollbar').contains('Michel Sardou')
  })
  it('can edit profil', () => {
    cy.visit('http://localhost:5173');
    cy.wait(500);
    cy.contains('Edit profile').click();
    cy.get('#editUsername').clear();
    cy.get('#editUsername').type('Michel F').should('have.value', 'Michel F');
    cy.get('#editEmail').clear();
    cy.get('#editEmail').type('michel@F').should('have.value','michel@F');
    cy.get('[style="z-index: 1000;"] > .vfm__container > .vfm__content > .card > .content > form > .fancy-button').click();
    cy.get('.bar > :nth-child(2) > :nth-child(1)').contains('Michel F');
  })
  it('can delete user', () => {
    cy.visit('http://localhost:5173')
    cy.wait(500);
    cy.contains('Delete profile').click();
    cy.get('[style="z-index: 1000;"] > .vfm__container > .vfm__content > .card > .content > form > .fancy-button').click();
  })
  it('clock manager', () => {
    cy.visit('http://localhost:5173');
    cy.wait(500);
    const lastclock =  cy.get(':nth-child(1) > .important');
    // get element where id = clock_button
    cy.get('#clock_button').click();
    const newclock = cy.get(':nth-child(1) > .important');
    expect(lastclock).not.to.equal(newclock);
  })
  it('clock manager button', () => {
    cy.visit('http://localhost:5173');
    cy.wait(500);
    cy.get('#clock_button').click();
    const clock_is_running = cy.get(':nth-child(2) > .important');
    const button_value =cy.get('#clock_button');
    cy.get('.bar > :nth-child(2) > :nth-child(1)').contains('Michel F');
    const newclock = cy.get(':nth-child(2) > .important');
    const newbutton_value =cy.get('#clock_button');
    expect(clock_is_running).not.to.equal(newclock);
    expect(button_value).not.to.equal(newbutton_value);

  })
  it('working times', () => {
    cy.visit('http://localhost:5173')
    cy.wait(500)
    const workingtimes = cy.get('.card-container > :nth-child(2) > :nth-child(1)');
    cy.get('#clock_button').click()
    cy.get('#clock_button').click()
    const newworkingtimes = cy.get('.card-container > :nth-child(2) > :nth-child(1)');
    expect(workingtimes).not.to.equal(newworkingtimes)
  })
  it('working time edit and delete', () => {
    cy.visit('http://localhost:5173')
    cy.wait(500)
    const workingtime = cy.get(':nth-child(2) > .content > :nth-child(4)');
    cy.get('.content > :nth-child(4) > :nth-child(1)').click();
    cy.get('#newStartUpdate').type('2021-01-01T00:00:00');
    cy.get('#updateForm > .fancy-button').click();
    const newworkingtime = cy.get(':nth-child(2) > .content > :nth-child(4)');
    expect(workingtime).not.to.equal(newworkingtime);

    cy.get(':nth-child(4) > :nth-child(2)').click();
    cy.get('.content > div > .fancy-button-danger').click();
    const deletedworkingtime = cy.get(':nth-child(2) > .content > :nth-child(4)');
    expect(workingtime).not.to.equal(deletedworkingtime);
  })
})
