import { Gtk } from "ags/gtk4"
import AstalHyprland from "gi://AstalHyprland"
import { range } from "../../../utils"
import { CCProps, createBinding, createComputed } from "ags"

type WsButtonProps = Partial<
  CCProps<Gtk.Button, Gtk.Button.ConstructorProps>
> & {
  ws: AstalHyprland.Workspace
}

function WsButton({ ws, ...props }: WsButtonProps) {
  const hyprland = AstalHyprland.get_default()
  const classNames = createComputed(
    [
      createBinding(hyprland, "focusedWorkspace"),
      createBinding(hyprland, "clients"),
    ],
    (fws, _) => {
      const classes = ["workspace-button"]
      const active = fws.id == ws.id
      if (active) classes.push("active")
      const occupied = hyprland.get_workspace(ws.id)?.get_clients().length > 0
      if (occupied) classes.push("occupied")
      return classes
    },
  )
  return (
    <button
      cssClasses={classNames}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
      onClicked={() => ws.focus()}
      {...props}
    ></button>
  )
}

function Workspaces() {
  return (
    <box cssClasses={["workspaces"]} spacing={7}>
      {range(6).map((i) => (
        <WsButton ws={AstalHyprland.Workspace.dummy(i + 1, null)} />
      ))}
    </box>
  )
}

export { Workspaces }
