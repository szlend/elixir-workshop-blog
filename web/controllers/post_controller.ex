defmodule Blog.PostController do
  use Blog.Web, :controller
  alias Blog.Post

  def index(conn, _params) do
    posts = Repo.all(Post)
    render(conn, "index.html", posts: posts)
  end

  def show(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    render(conn, "show.html", post: post)
  end

  def show_json(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(%Post{})
    render(conn, "show.json", post: post, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Post.changeset(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    changeset = Post.changeset(%Post{}, post_params)
    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Successfully created post")
        |> redirect(to: post_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Failed to create post")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Repo.get!(Post, id)
    changeset = Post.changeset(post, post_params)
    case Repo.update(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Successfully update post")
        |> redirect(to: post_path(conn, :show, post))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "Failed to update post")
        |> render("edit.html", post: post, changeset: changeset)
    end
  end
end
