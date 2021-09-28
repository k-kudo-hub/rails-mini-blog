module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        gold: {
          300: '#bb9f00',
          500: '#CCC0AE',
          700: '#b1a798'
        },
        silver: {
          500: '#C4C4C4',
        },
        cleanness: {
          500: 'rgba(255,255,255, 0.5)'
        }
      },
      height: {
        '1/16': '6.25%',
        '2/16': '12.5%',
        '4/16': '25%',
        '8/16': '50%',
        '10/16': '62.5%',
        '12/16': '75%',
      },
      minHeight: {
        '1/16': '6.25%',
        '2/16': '12.5%',
        '4/16': '25%',
        '8/16': '50%',
        '10/16': '62.5%',
        '12/16': '75%',
      },
      width: {
        '16/12': '150%',
      }
    },
  },
  variants: {
    extend: {},
    height: ['responsive', 'hover', 'focus'],
  },
  plugins: [],
}
