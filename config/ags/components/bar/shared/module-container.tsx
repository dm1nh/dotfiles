import { Accessor, type CCProps } from "ags"
import { Gtk } from "ags/gtk4"

type ModuleContainerProps = Partial<
  CCProps<Gtk.Button, Gtk.Button.ConstructorProps>
> & {
  icon?: string | Accessor<string>
  label?: string | Accessor<string>
}

function ModuleContainer({
  icon,
  label,
  class: className,
  ...props
}: ModuleContainerProps) {
  return (
    <button class={"module-container" + " " + className} {...props}>
      <box>
        <label class="icon" label={icon} />
        <label class="label" label={label} />
      </box>
    </button>
  )
}

export { ModuleContainer }
