import { For } from "ags"
import { truncateTitle, currentWsClients, clientClassNames } from "./helpers"

function Taskbar() {
  return (
    <box class="taskbar" spacing={4}>
      <For each={currentWsClients}>
        {(client) => (
          <button
            cssClasses={clientClassNames(client)}
            onClicked={() => client.focus()}
          >
            <box class="client-container">
              <image class="client-icon" iconName={client.class} />
              <label class="client-title" label={truncateTitle(client.title)} />
            </box>
          </button>
        )}
      </For>
    </box>
  )
}

export { Taskbar }
