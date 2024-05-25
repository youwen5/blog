import "../css/default.css"

// @ts-check

const prefersDark = window.matchMedia("(prefers-color-scheme: dark)").matches
const themeSystem = () => {
  if (prefersDark) {
    document.documentElement.classList.add("dark")
  } else {
    document.documentElement.classList.remove("dark")
  }
}
const themeLight = () => {
  document.documentElement.classList.remove("dark")
}
const themeDark = () => {
  document.documentElement.classList.add("dark")
}
let currentTheme =
  localStorage.getItem("theme") === "dark"
    ? 2
    : localStorage.getItem("theme") === "light"
      ? 1
      : 0
const themeButton = document.getElementById("theme-toggle")
themeButton.addEventListener("click", () => {
  currentTheme = (currentTheme + 1) % 3
  switch (currentTheme) {
    case 0:
      localStorage.removeItem("theme")
      themeSystem()
      themeButton.innerText = "theme: system"
      break
    case 1:
      if (prefersDark) {
        localStorage.setItem("theme", "light")
        themeLight()
        themeButton.innerText = "theme: light"
      } else {
        localStorage.setItem("theme", "dark")
        themeDark()
        themeButton.innerText = "theme: dark"
      }
      break
    case 2:
      if (prefersDark) {
        localStorage.setItem("theme", "dark")
        themeDark()
        themeButton.innerText = "theme: dark"
      } else {
        localStorage.setItem("theme", "light")
        themeLight()
        themeButton.innerText = "theme: light"
      }
      break
  }
})
