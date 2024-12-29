import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { execAsync } from "astal/process";
import { Variable, GLib, bind } from "astal";
import Hyprland from "gi://AstalHyprland";
import Wp from "gi://AstalWp";

function Workspaces() {
  const hypr = Hyprland.get_default();

  const wp_count = 6;

  return (
    <box className="workspaces" spacing={8} valign={Gtk.Align.CENTER}>
      {Array.from({ length: wp_count })
        .map((_, i) => i + 1)
        .map((id) => (
          <button
            className="workspace-button"
            widthRequest={16}
            heightRequest={16}
            setup={(self) => {
              function update() {
                self.toggleClassName(
                  "focused",
                  hypr.focusedWorkspace.id === id,
                );
                self.toggleClassName(
                  "occupied",
                  (hypr.get_workspace(id)?.get_clients().length || 0) > 0,
                );
              }
              self.hook(hypr, "event", update);
            }}
          />
        ))}
    </box>
  );
}

function FocusedClient() {
  const hypr = Hyprland.get_default();
  const focused = bind(hypr, "focusedClient");

  return (
    <box className="focused-client" visible={focused.as(Boolean)}>
      {focused.as(
        (client) =>
          client && (
            <>
              <icon
                className="client-icon"
                icon={bind(client, "class")}
                widthRequest={18}
                heightRequest={18}
              />
              <label className="client-app" label={bind(client, "class")} />
            </>
          ),
      )}
    </box>
  );
}

function Volume() {
  const icons = {
    muted: "",
    low: "",
    high: "",
    overamplified: "",
  };
  const thresholds = {
    101: "overamplified",
    51: "high",
    1: "low",
    0: "muted",
  };
  const speaker = Wp.get_default()?.audio.defaultSpeaker!;

  return (
    <button
      onClick={() => execAsync("pavucontrol")}
      onScroll={(_, e) => {
        if (e.delta_y < 0) {
          speaker.set_volume(speaker.volume + 0.01);
        } else {
          speaker.set_volume(speaker.volume - 0.01);
        }
      }}
    >
      <box className="volume" valign={Gtk.Align.CENTER}>
        <label
          className="volume-icon"
          label={bind(speaker, "volume").as((value) => {
            const icon = speaker.mute
              ? 0
              : [101, 51, 1, 0].find((ts) => ts <= value * 100);
            return icon
              ? icons[
                  thresholds[
                    icon as keyof typeof thresholds
                  ] as keyof typeof icons
                ]
              : icons.muted;
          })}
        />
        <label
          className="volume-value"
          label={bind(speaker, "volume").as((value) => {
            return (
              Math.floor(value * 100)
                .toString()
                .padStart(3, "0") + "%"
            );
          })}
        />
      </box>
    </button>
  );
}

function IdleInhibitor() {
  const enabled = Variable<boolean>(false);

  return (
    <button
      onClick={() => {
        if (enabled.get()) {
          enabled.set(false);
          execAsync("hypridle &");
        } else {
          enabled.set(true);
          execAsync("pkill hypridle");
        }
      }}
    >
      <box className="idle-inhibitor" valign={Gtk.Align.CENTER}>
        <label
          className="idle-inhibitor-icon"
          label={enabled((value) => (value ? "" : ""))}
        />
        <label
          className="idle-inhibitor-label"
          label={enabled((value) => (value ? "On" : "Off"))}
        />
      </box>
    </button>
  );
}

function Clock({ format = "%H:%M" }) {
  const time = Variable<string>("").poll(
    60000,
    () => GLib.DateTime.new_now_local().format(format)!,
  );
  const date = Variable<string>("").poll(
    3600000,
    () => GLib.DateTime.new_now_local().format("%a, %b %d")!,
  );

  return (
    <label
      className="clock"
      onDestroy={() => time.drop()}
      label={time()}
      tooltipText={date()}
    />
  );
}

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const anchor =
    Astal.WindowAnchor.BOTTOM |
    Astal.WindowAnchor.LEFT |
    Astal.WindowAnchor.RIGHT;

  return (
    <window
      className="bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={anchor}
      application={App}
    >
      <centerbox>
        <box hexpand halign={Gtk.Align.START} spacing={20}>
          <Workspaces />
          <FocusedClient />
        </box>
        <box></box>
        <box hexpand halign={Gtk.Align.END} spacing={20}>
          <Volume />
          <IdleInhibitor />
          <Clock />
        </box>
      </centerbox>
    </window>
  );
}
