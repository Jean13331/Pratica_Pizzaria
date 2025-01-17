describe('Testando Tela de Registro', () => {
  beforeEach(() => {
    // Visita a URL do formulário de login
    cy.visit('http://localhost:61888/'); // Ajuste a URL conforme necessário
    cy.wait(10000); // Espera 10000ms antes de iniciar as ações
  });

  it('Deve ir para a tela de registro e preencher o formulário', () => {
    // Clica no botão de registrar-se utilizando a chave
    cy.get('button[key="btnRegistrar"]').click(); // Ou use [data-cy="btnRegistrar"]
    
    
    // Preenche o formulário com dados válidos
    cy.get('input[data-cy="nomeCompletoInput"]').type('Jean Carlos Ortega Júnior');
    cy.wait(1000); // Espera 1000ms

    cy.get('input[data-cy="emailInput"]').type('jean@example.com');
    cy.wait(1000); // Espera 1000ms

    cy.get('input[data-cy="telefoneInput"]').type('(11) 98765-4321');
    cy.wait(1000); // Espera 1000ms

    cy.get('input[data-cy="senhaInput"]').type('senhaSegura123');
    cy.wait(1000); // Espera 1000ms

    cy.get('input[data-cy="confirmarSenhaInput"]').type('senhaSegura123');
    cy.wait(1000); // Espera 1000ms

    // O botão de cadastrar não é clicado
  });
});
