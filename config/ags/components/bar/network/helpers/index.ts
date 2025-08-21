import AstalNetwork from "gi://AstalNetwork"
import { createBinding, createComputed } from "ags"
import { icons, thresholds } from "./constants"

const network = AstalNetwork.get_default()

function getNetworkIcon(
  primary: AstalNetwork.Primary,
  wifi: AstalNetwork.Wifi,
) {
  if (primary === AstalNetwork.Primary.WIRED) {
    return icons.wired
  }

  if (primary === AstalNetwork.Primary.WIFI) {
    const iconThreshold = [80, 60, 40, 20, 0].find((ts) => ts <= wifi.strength)
    return icons[
      thresholds[iconThreshold as keyof typeof thresholds] as keyof typeof icons
    ]
  }

  return icons.disconnected
}

export const networkIcon = createComputed(
  [createBinding(network, "primary"), createBinding(network, "wifi")],
  (primary, wifi) => getNetworkIcon(primary, wifi),
)

export const networkLabelAndTooltip = createComputed(
  [
    createBinding(network, "primary"),
    createBinding(network, "state"),
    createBinding(network, "connectivity"),
    ...(network.wifi ? [createBinding(network.wifi, "enabled")] : []),
  ],
  (primary) => {
    if (primary === AstalNetwork.Primary.WIRED) {
      return {
        label: network.wired.device.interface,
        tooltip: "Connected",
      }
    }
    if (primary === AstalNetwork.Primary.WIFI) {
      return {
        label: network.wifi.active_access_point.ssid,
        tooltip: formatWifiInfo(network.wifi),
      }
    }
    return { label: "Unavailable", tooltip: "No Internet" }
  },
)

/**
 * Formats the frequency value to MHz.
 *
 * This function takes a frequency value in kHz and formats it to MHz with two decimal places.
 *
 * @param frequency The frequency value in kHz.
 *
 * @returns The formatted frequency value in MHz as a string.
 */
const formatFrequency = (frequency: number): string => {
  return `${(frequency / 1000).toFixed(2)}MHz`
}

/**
 * Formats the WiFi information for display.
 *
 * This function takes a WiFi object and formats its SSID, signal strength, and frequency for display.
 *
 * @param wifi The WiFi object containing SSID, signal strength, and frequency information.
 *
 * @returns A formatted string containing the WiFi information.
 */
const formatWifiInfo = (wifi: AstalNetwork.Wifi): string => {
  return `Network: ${wifi.ssid} \nSignal Strength: ${wifi.strength}% \nFrequency: ${formatFrequency(wifi.frequency)}`
}
