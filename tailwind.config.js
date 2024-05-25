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
          dark: "#e2e8f0",
          light: "#0a0a0a",
        },
        secondary: {
          dark: "#2e1065",
          light: "#4f46e5",
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
          dark: "#030712",
        },
      },
    },
  },
  plugins: [require("@tailwindcss/typography")],
}
