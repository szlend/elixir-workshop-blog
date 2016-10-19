defmodule Blog.PostView do
  use Blog.Web, :view

  def render("show.json", %{post: post, changeset: changeset}) do
    %{post: %{title: post.title, body: post.body}, errors: errors(changeset.errors)}
  end

  def errors(errors) do
    # this would be easier with https://hexdocs.pm/ecto/Ecto.Changeset.html#traverse_errors/2
    Enum.map(errors, fn {field, {message, _}} -> %{field => message} end)
  end
end
