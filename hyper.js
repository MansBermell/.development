module.exports = {
  plugins: [
    'hypercwd',
    'hyperterm-tomorrow-night',
    'hyperterm-working-directory',
  ],
  config: {
    bell: false,
    fontSize: 14,
    fontFamily: 'Hack Regular, Monaco, Menlo, monospace',
    termCSS: '.cursor-node { background: rgba(95, 216, 251, 0.7) !important; }',
    workingDirectory: '~/Downloads',
  },
};
