module.exports = {
  content: [
    './public/*.{html,js}',
    './src/*.{elm,js}',
  ],
  theme: {
    extend: {},
  },
  plugins: [
	  require('tailwind-nord'),
  ],
}
