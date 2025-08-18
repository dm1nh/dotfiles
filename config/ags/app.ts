import app from "ags/gtk4/app"
import styles from "./styles/styles.scss"
import { Bar } from "./components/bar"

app.start({
  css: styles,
  main() {
    app.get_monitors().map(Bar)
  },
})
