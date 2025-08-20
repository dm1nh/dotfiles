import { createPoll } from "ags/time"
import GLib from "gi://GLib"
import { ModuleContainer } from "./shared/module-container"

function Clock({ format = "%a, %b %d - %H:%M" }) {
  const time = createPoll("", 60000, () => {
    return GLib.DateTime.new_now_local().format(format)!
  })

  return <ModuleContainer class="clock" icon="" label={time} />
}

export { Clock }
