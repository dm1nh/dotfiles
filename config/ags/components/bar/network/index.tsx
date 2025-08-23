import { bash } from "../../../utils"
import { ModuleContainer } from "../shared/module-container"
import { networkIcon, networkLabelAndTooltip } from "./helpers"

function Network() {
  return (
    <ModuleContainer
      class="network"
      icon={networkIcon}
      label={networkLabelAndTooltip((value) => value.label)}
      tooltipText={networkLabelAndTooltip((value) => value.tooltip)}
      onClicked={() => bash("nm-connection-editor")}
    />
  )
}

export { Network }
