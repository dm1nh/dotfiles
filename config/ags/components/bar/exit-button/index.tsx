import { bash } from "../../../utils"
import { ModuleContainer } from "../shared/module-container"

function ExitButton() {
  return (
    <ModuleContainer
      class="exit-button"
      icon=""
      label="Exit"
      onClicked={() => bash("~/.config/hypr/scripts/dmenu.sh quit")}
    />
  )
}

export { ExitButton }
