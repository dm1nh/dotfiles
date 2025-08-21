import GLib from "gi://GLib"
import { createPoll } from "ags/time"

export function getFormattedTime(format: string = "%a, %b %d - %H:%M") {
  return createPoll("", 60000, () => {
    return GLib.DateTime.new_now_local().format(format)!
  })
}
