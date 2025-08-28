import { For } from "ags"
import { currentWsClients, clientClassNames, truncateTitle } from "./helpers"

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
            <box>
              <image
                class="client-icon"
                iconName={client.class}
                pixelSize={24}
              />
              <label
                class="client-title"
                label={truncateTitle(client.title)}
                xalign={0}
              />
            </box>
          </button>
        )}
      </For>
    </box>
  )
}

export { Taskbar }
