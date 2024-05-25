/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: "selector",
  content: ["./src/**/*.{html,js}"],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter", "sans-serif"],
        serif: ["Merriweather", "serif"],
        math: ["Latin Modern Math", "serif"],
      },
      colors: {
        primary: {
          dark: "#e7e5e4",
          light: "#44403c",
        },
        secondary: {
          dark: "#4c1d95",
          light: "#4338ca",
        },
        accent: {
          dark: "#9ca3af",
          light: "#78716c",
        },
        muted: {
          dark: "#6b7280",
          light: "#a8a29e",
        },
        background: {
          light: "#d6d3d1",
          dark: "#101017",
        },
      },
    },
  },
  plugins: [require("@tailwindcss/typography")],
}
