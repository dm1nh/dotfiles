import { createComputed, createBinding } from "ags"
import { icons, thresholds } from "./constants"
import AstalWp from "gi://AstalWp"

const speaker = AstalWp.get_default()?.audio!.default_speaker

function getVolumeIcon(volume: number, mute: boolean) {
  const icon = mute ? 0 : [101, 51, 1, 0].find((ts) => ts <= volume * 100)
  return icon
    ? icons[thresholds[icon as keyof typeof thresholds] as keyof typeof icons]
    : icons.muted
}

export const volumeIcon = createComputed(
  [createBinding(speaker, "volume"), createBinding(speaker, "mute")],
  (volume, mute) => getVolumeIcon(volume, mute),
)

export const volumeValue = createBinding(speaker, "volume").as((value) => {
  return (
    Math.floor(value * 100)
      .toString()
      .padStart(3, "0") + "%"
  )
})
