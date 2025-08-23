import GLib from "gi://GLib"
import { createPoll } from "ags/time"

function formatDateTime(format: string = "%a, %b %d - %H:%M") {
  return createPoll("", 60000, () => {
    return GLib.DateTime.new_now_local().format(format)!
  })
}

export const clockLabel = formatDateTime("%H:%M")

export const clockTooltip = formatDateTime()
