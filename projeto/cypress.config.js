module.exports = {
  e2e: {
    setupNodeEvents(on, config) {
      // implementar ouvintes de eventos aqui
    },
    baseUrl: 'http://localhost:61888/', // URL base do seu aplicativo
    supportFile: 'cypress/support/e2e.js', // arquivo de suporte para configurações globais
    video: false, // desativa a gravação de vídeo durante os testes
    screenshotsFolder: 'cypress/screenshots', // pasta para capturas de tela
    videosFolder: 'cypress/videos', // pasta para vídeos
  },
};
