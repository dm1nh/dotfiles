import app from "ags/gtk4/app"
import { Astal, Gdk, Gtk } from "ags/gtk4"
import { Clock } from "./clock"
import { Workspaces } from "./workspaces"
import { Volume } from "./volume"

export function Bar(gdkmonitor: Gdk.Monitor) {
  const { BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor

  return (
    <window
      visible
      name="bar"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={BOTTOM | LEFT | RIGHT}
      application={app}
    >
      <centerbox cssClasses={["bar-container"]}>
        <box $type="start" halign={Gtk.Align.START}>
          <Workspaces />
        </box>
        <box $type="end" halign={Gtk.Align.END} spacing={8}>
          <Volume />
          <Clock />
        </box>
      </centerbox>
    </window>
  )
}
