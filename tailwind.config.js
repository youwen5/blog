/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: "selector",
  content: ["./src/**/*.{html,js}"],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Open Sans", "sans-serif"],
        serif: ["Merriweather", "serif"],
      },
      colors: {
        primary: {
          //dark: "#e7e5e4",
          light: "#44403c",
          dark: "#e0def4",
          //light: "#575279",
        },
        secondary: {
          //dark: "#4c1d95",
          //light: "#4338ca",
          dark: "#1f1d2e",
          light: "#fffaf3",
        },
        accent: {
          //dark: "#9ca3af",
          //light: "#78716c",
          dark: "#908caa",
          light: "#797593",
        },
        muted: {
          //dark: "#6b7280",
          //light: "#a8a29e",
          dark: "#6e6a86",
          light: "#9893a5",
        },
        background: {
          //light: "#d6d3d1",
          //dark: "#101017",
          dark: "#191724",
          light: "#faf4ed",
        },
        iris: {
          dark: "#c4a7e7",
          light: "#907aa9",
        },
        love: {
          dark: "#eb6f92",
          light: "#b4637a",
        },
      },
    },
  },
  plugins: [require("@tailwindcss/typography")],
}
