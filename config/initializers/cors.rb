allow do
  origins "*"
  resource "*",
    headers: :any,
    methods: %i[get post put patch delete options]
end