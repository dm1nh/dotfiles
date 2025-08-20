import { ModuleContainer } from "./shared/module-container"
import { createBinding } from "ags"
import AstalWp from "gi://AstalWp"
import { Gtk } from "ags/gtk4"

function Volume() {
  const speaker = AstalWp.get_default()?.audio!.default_speaker

  const icons = {
    muted: "",
    low: "",
    high: "",
    overamplified: "",
  }
  const thresholds = {
    101: "overamplified",
    51: "high",
    1: "low",
    0: "muted",
  }

  const icon = createBinding(speaker, "volume").as((value) => {
    const icon = speaker.mute
      ? 0
      : [101, 51, 1, 0].find((ts) => ts <= value * 100)
    return icon
      ? icons[thresholds[icon as keyof typeof thresholds] as keyof typeof icons]
      : icons.muted
  })

  const percentage = createBinding(speaker, "volume").as((value) => {
    return (
      Math.floor(value * 100)
        .toString()
        .padStart(3, "0") + "%"
    )
  })

  function on_scroll(_: Gtk.Button, __: Gtk.EventControllerScroll, dx: number) {
    console.log(dx)
    if (dx > 0) {
      speaker.set_volume(speaker.volume - 0.01)
    }
    if (dx < 0) {
      speaker.set_volume(speaker.volume + 0.01)
    }
  }

  return (
    <ModuleContainer
      class="volume"
      icon={icon}
      label={percentage}
      $={(self) => {
        const scroll_event = Gtk.EventControllerScroll.new(
          Gtk.EventControllerScrollFlags.VERTICAL,
        )
        scroll_event.connect("scroll", on_scroll)
        self.add_controller(scroll_event)
      }}
    />
  )
}

export { Volume }
