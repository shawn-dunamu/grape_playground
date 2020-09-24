Rails.application.routes.draw do
  def draw(routes_name)
    instance_eval(File.read(Rails.root / "config/routes/#{routes_name}.rb"))
  end

  draw :swagger

  mount V1::Mount => V1::Mount::PREFIX
end