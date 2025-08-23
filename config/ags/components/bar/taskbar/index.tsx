import { For } from "ags"
import { currentWsClients, clientClassNames } from "./helpers"

function Taskbar() {
  return (
    <box class="taskbar" spacing={4}>
      <For each={currentWsClients}>
        {(client) => (
          <button
            cssClasses={clientClassNames(client)}
            onClicked={() => client.focus()}
            tooltipText={client.title}
          >
            <image class="client-icon" iconName={client.class} pixelSize={24} />
          </button>
        )}
      </For>
    </box>
  )
}

export { Taskbar }
