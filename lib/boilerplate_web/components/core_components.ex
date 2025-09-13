defmodule BoilerplateWeb.CoreComponents do
  @moduledoc """
  Provides core UI components.
  """
  use Phoenix.Component
  use Gettext, backend: BoilerplateWeb.Gettext

  alias Phoenix.LiveView.JS

  @doc """
  Renders flash notices.

  ## Examples

      <.flash kind={:info} flash={@flash} />
      <.flash kind={:info} phx-mounted={show("#flash")}>Welcome Back!</.flash>
  """
  attr :id, :string, doc: "the optional id of flash container"
  attr :flash, :map, default: %{}, doc: "the map of flash messages to display"
  attr :title, :string, default: nil
  attr :kind, :atom, values: [:info, :error], doc: "used for styling and flash lookup"
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the flash container"

  slot :inner_block, doc: "the optional inner block that renders the flash message"

  def flash(assigns) do
    assigns = assign_new(assigns, :id, fn -> "flash-#{assigns.kind}" end)

    ~H"""
    <div
      :if={msg = render_slot(@inner_block) || Phoenix.Flash.get(@flash, @kind)}
      id={@id}
      phx-click={JS.push("lv:clear-flash", value: %{key: @kind}) |> hide("##{@id}")}
      role="alert"
      class="toast toast-top toast-end z-50"
      {@rest}
    >
      <div class={[
        "alert w-80 sm:w-96 max-w-80 sm:max-w-96 text-wrap",
        @kind == :info && "alert-info",
        @kind == :error && "alert-error"
      ]}>
        <.icon :if={@kind == :info} name="hero-information-circle" class="size-5 shrink-0" />
        <.icon :if={@kind == :error} name="hero-exclamation-circle" class="size-5 shrink-0" />
        <div>
          <p :if={@title} class="font-semibold">{@title}</p>
          <p>{msg}</p>
        </div>
        <div class="flex-1" />
        <button type="button" class="group self-start cursor-pointer" aria-label={gettext("close")}>
          <.icon name="hero-x-mark" class="size-5 opacity-40 group-hover:opacity-70" />
        </button>
      </div>
    </div>
    """
  end

  attr :name, :string, required: true
  attr :rest, :global, include: ~w(size rotate inline flip noobserver)

  def icon(assigns) do
    ~H"""
    <.iconify icon={"lucide:#{@name}"} {@rest} />
    """
  end

  @doc ~S"""
  Renders an icon from any of the available icon sets. All the available
  icon sets can be found here in the following page: https://icon-sets.iconify.design.

  ## Examples

  ```heex
  <.iconify icon="3d-glasses" />
  <.iconify icon="3d-glasses" size="64" />
  <.iconify icon="3d-glasses" inline />
  <.iconify icon="3d-glasses" rotate="90deg" />
  <.iconify icon="3d-glasses" flip="vertical" />
  <.iconify icon="3d-glasses" class="text-red-100 bg-red-500" />
  ```

  Sizing the icons might be a bit tricky in some scenarios, sometimes you want to specify the size through
  the component, other times you might want to specify the size through CSS, see the official documentation
  for guidance on the available options: https://iconify.design/docs/iconify-icon/dimensions.html.
  """

  attr :icon, :string, required: true
  attr :size, :string, default: nil
  attr :class, :string, default: nil
  attr :rest, :global, include: ~w(size rotate inline flip noobserver)

  def iconify(assigns) do
    ~H"""
    <iconify-icon
      icon={@icon}
      width={@size}
      height={@size}
      class={[@size != nil && "size-min", @class]}
      {@rest}
    >
    </iconify-icon>
    """
  end

  def show(js \\ %JS{}, selector) do
    JS.show(js,
      to: selector,
      time: 300,
      transition:
        {"transition-all ease-out duration-300",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
         "opacity-100 translate-y-0 sm:scale-100"}
    )
  end

  def hide(js \\ %JS{}, selector) do
    JS.hide(js,
      to: selector,
      time: 200,
      transition:
        {"transition-all ease-in duration-200", "opacity-100 translate-y-0 sm:scale-100",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"}
    )
  end
end
