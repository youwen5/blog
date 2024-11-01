import autoprefixer from "autoprefixer"
import postcss from "rollup-plugin-postcss"
import tailwindcss from "tailwindcss"
import postcssMinify from "postcss-minify"
import terser from "@rollup/plugin-terser"

export default {
  input: "src/js/main.js",
  output: {
    file: "dist/out/bundle.js",
  },
  plugins: [
    postcss({
      plugins: [tailwindcss, autoprefixer, postcssMinify],
      extract: true,
    }),
    terser(),
  ],
}
