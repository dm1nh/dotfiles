import { ModuleContainer } from "../shared/module-container"
import { getFormattedTime } from "./helpers"

function Clock({ format }: { format?: string }) {
  const time = getFormattedTime(format)

  return <ModuleContainer class="clock" icon="" label={time} />
}

export { Clock }
