defmodule Utilx.EctoUtils do
  import Ecto.Query, warn: false

  def apply_filters(query, opts) when is_list(opts) do
    Enum.reduce(opts, query, fn
      {:where, filters}, query ->
        where(query, ^filters)

      {:fields, fields}, query ->
        select(query, [i], map(i, ^fields))

      {:order_by, criteria}, query ->
        order_by(query, ^criteria)

      {:limit, criteria}, query ->
        limit(query, ^criteria)

      {:preloads, preloads}, query when is_list(preloads) ->
        Enum.reduce(preloads, query, fn preload, query ->
          preload(query, ^preload)
        end)

      {:preloads, preload}, query ->
        preload(query, ^preload)

      {:preload, preload}, query ->
        preload(query, ^preload)

      _, query ->
        query
    end)
  end
end
