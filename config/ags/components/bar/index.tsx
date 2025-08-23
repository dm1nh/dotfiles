import app from "ags/gtk4/app"
import { Astal, Gdk, Gtk } from "ags/gtk4"
import { Clock } from "./clock"
import { Workspaces } from "./workspaces"
import { Volume } from "./volume"
import { Taskbar } from "./taskbar"
import { Network } from "./network"
import { Netstats } from "./netstats"
import { Systray } from "./systray"
import { ExitButton } from "./exit-button"

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
        <box $type="start" halign={Gtk.Align.START} spacing={8}>
          <Workspaces />
          <Taskbar />
        </box>
        <box $type="end" halign={Gtk.Align.END} spacing={8}>
          <Systray />
          <Volume />
          <Network />
          <Netstats />
          <Clock />
          <ExitButton />
        </box>
      </centerbox>
    </window>
  )
}
