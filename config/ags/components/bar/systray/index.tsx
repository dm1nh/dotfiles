import { createBinding, For } from "ags"
import { Gtk } from "ags/gtk4"
import AstalTray from "gi://AstalTray"

function Systray() {
  const tray = AstalTray.get_default()
  const items = createBinding(tray, "items")

  return (
    <box class="systray" spacing={2}>
      <For each={items}>
        {(item) => (
          <menubutton
            class="button"
            $={(self: Gtk.MenuButton) => {
              self.insert_action_group("dbusmenu", item.actionGroup)
            }}
            tooltipText={createBinding(item, "tooltipMarkup")}
          >
            <image class="button-icon" gicon={createBinding(item, "gicon")} />
            {Gtk.PopoverMenu.new_from_model(item.menuModel)}
          </menubutton>
        )}
      </For>
    </box>
  )
}

export { Systray }
