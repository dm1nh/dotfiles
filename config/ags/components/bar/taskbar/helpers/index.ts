import AstalHyprland from "gi://AstalHyprland"
import { createComputed, createBinding } from "ags"

const hyprland = AstalHyprland.get_default()
export const currentWsClients = createComputed(
  [
    createBinding(hyprland, "focusedWorkspace"),
    createBinding(hyprland, "clients"),
  ],
  (fws, cs) => {
    const wsClients = cs
      .filter((cs) => cs.workspace.id === fws.id)
      .sort((a, b) => (a.address < b.address ? -1 : 1))
    return wsClients
  },
)

export const clientClassNames = (client: AstalHyprland.Client) =>
  createComputed([createBinding(hyprland, "focusedClient")], (fc) => {
    const classes = ["client"]
    const active = fc?.address === client.address
    if (active) {
      classes.push("active")
    }
    return classes
  })

export function truncateTitle(title: string | null, maxSize: number = 16) {
  if (title == null) {
    return "--"
  }
  return title.length > maxSize
    ? title.substring(0, maxSize).trim() + "..."
    : title
}
