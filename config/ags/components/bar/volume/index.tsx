import { ModuleContainer } from "../shared/module-container"
import { Gtk } from "ags/gtk4"
import { volumeIcon, volumeValue } from "./helpers"
import AstalWp from "gi://AstalWp"
import { bash } from "../../../utils"

function Volume() {
  const speaker = AstalWp.get_default()?.audio!.default_speaker

  function on_scroll(_: Gtk.Button, __: Gtk.EventControllerScroll, dx: number) {
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
      icon={volumeIcon}
      label={volumeValue}
      onClicked={() => bash("pavucontrol")}
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
