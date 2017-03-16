module.exports = {
  plugins: [
    'hypercwd',
    'hyperterm-tomorrow-night',
    'hyperterm-working-directory',
  ],
  config: {
    bell: false,
    fontFamily: 'Hack Regular, Monaco, Menlo, monospace',
    fontSize: 14,
    termCSS: `
      ::selection {
        background: rgb(95, 216, 251);
      }
      .cursor-node {
        background: rgba(95, 216, 251, 0.7) !important;
      }
    `,
    workingDirectory: '~/Downloads',
  },
};
