import { execAsync } from "ags/process"

export function range(max: number) {
  return Array.from({ length: max }, (_, i) => i)
}

export async function sh(cmd: string | string[]) {
  return execAsync(cmd).catch((err) => {
    console.error(typeof cmd === "string" ? cmd : cmd.join(" "), err)
    return ""
  })
}

export async function bash(strings: string | string[], ...values: unknown[]) {
  const cmd =
    typeof strings === "string"
      ? strings
      : strings.flatMap((str, i) => str + `${values[i] ?? ""}`).join("")

  return execAsync(["bash", "-c", cmd]).catch((err) => {
    console.error(cmd, err)
    return ""
  })
}

type NotifUrgency = "low" | "normal" | "critical"
export function notifySend({
  appName,
  appIcon,
  urgency = "normal",
  image,
  icon,
  summary,
  body,
  actions,
}: {
  appName?: string
  appIcon?: string
  urgency?: NotifUrgency
  image?: string
  icon?: string
  summary: string
  body: string
  actions?: {
    [label: string]: () => void
  }
}) {
  const actionsArray = Object.entries(actions || {}).map(
    ([label, callback], i) => ({
      id: `${i}`,
      label,
      callback,
    }),
  )
  execAsync(
    [
      "notify-send",
      `-u ${urgency}`,
      appIcon && `-i ${appIcon}`,
      `-h "string:image-path:${!!icon ? icon : image}"`,
      `"${summary ?? ""}"`,
      `"${body ?? ""}"`,
      `-a "${appName ?? ""}"`,
      ...actionsArray.map((v) => `--action=\"${v.id}=${v.label}\"`),
    ].join(" "),
  )
    .then((out) => {
      if (!isNaN(Number(out.trim())) && out.trim() !== "") {
        actionsArray[parseInt(out)].callback()
      }
    })
    .catch(console.error)
}
