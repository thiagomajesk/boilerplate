defmodule Boilerplate.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  @doc """
  Collects all error messages from a changeset and translates them.
  """
  def collect_errors(%Ecto.Changeset{} = changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  @doc """
  Gets the translated error message for a given key from a changeset.
  """
  def get_errors(%Ecto.Changeset{errors: errors}, key) do
    with {msg, opts} <- Keyword.get(errors, key, []), do: translate_error({msg, opts})
  end

  @doc """
  Adds a new error to the changeset if one does not already exist for the given key.
  """
  def add_new_error(%Ecto.Changeset{} = changeset, key, message) do
    if not Enum.any?(changeset.errors, &(elem(&1, 0) == key)),
      do: Ecto.Changeset.add_error(changeset, key, message),
      else: changeset
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # When using gettext, we typically pass the strings we want
    # to translate as a static argument:
    #
    #     # Translate the number of files with plural rules
    #     dngettext("errors", "1 file", "%{count} files", count)
    #
    # However the error messages in our forms and APIs are generated
    # dynamically, so we need to translate them by calling Gettext
    # with our gettext backend as first argument. Translations are
    # available in the errors.po file (as we use the "errors" domain).
    if count = opts[:count] do
      Gettext.dngettext(BoilerplateWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(BoilerplateWeb.Gettext, "errors", msg, opts)
    end
  end

  @doc """
  Translates the errors for a field from a keyword list of errors.
  """
  def translate_errors(errors, field) when is_list(errors) do
    for {^field, {msg, opts}} <- errors, do: translate_error({msg, opts})
  end
end
