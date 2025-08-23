import { ModuleContainer } from "../shared/module-container"
import { clockLabel, clockTooltip } from "./helpers"

function Clock() {
  return (
    <ModuleContainer
      class="clock"
      icon=""
      label={clockLabel}
      tooltipText={clockTooltip}
    />
  )
}

export { Clock }
