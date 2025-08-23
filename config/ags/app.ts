import app from "ags/gtk4/app"
import styles from "./styles/styles.scss"
import { Bar } from "./components/bar"
import { NotificationPopups } from "./components/notifications"
import { notifySend } from "./utils"

app.start({
  css: styles,
  main() {
    app.get_monitors().map(Bar)
    NotificationPopups()

    // notifySend({
    //   appName: "foot",
    //   appIcon: "foot",
    //   summary: "Hello from foot",
    //   body: "This is a body notification.",
    //   actions: {
    //     Yes: () => {},
    //     No: () => {},
    //     Later: () => {},
    //   },
    // })
  },
})
