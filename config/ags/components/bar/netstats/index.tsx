import { ModuleContainer } from "../shared/module-container"
import networkSpeed from "./helpers"

function Netstats() {
  return (
    <ModuleContainer
      class="netstats"
      icon=""
      label={networkSpeed((value) => {
        const downloadSpeed = value.download
        const uploadSpeed = value.upload
        const higherSpeed =
          downloadSpeed >= uploadSpeed ? downloadSpeed : uploadSpeed

        const speed = (higherSpeed / 1000).toFixed(2)

        const symbol = downloadSpeed >= uploadSpeed ? "" : ""

        return `${speed} MB/s ${symbol}`
      })}
    />
  )
}

export { Netstats }
