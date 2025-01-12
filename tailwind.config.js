const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './app/views/**/*.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        primary: colors.green,
        secondary: colors.blue,
        brand: {
          light: '#E8F5E9',  // Light green background
          DEFAULT: '#4CAF50', // Main green
          dark: '#2E7D32',   // Dark green
        }
      }
    }
  },
  plugins: [
    require('@tailwindcss/forms')
  ]
} 