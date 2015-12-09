class MyApplication < Sinatra::Base

  get "/" do
    erb :index
  end

  get "/nuestrahistoria" do
    erb :historia
  end

  get "/travesia" do
    erb :travesia
  end

  get "/embarazo" do
    erb :embarazo
  end

  get "/belliepainting" do
    erb :bellie
  end

  get "/blessing" do
    erb :blessing
  end

  get "/ninosyninas" do
    erb :comercial
  end

  get "/parto" do
    erb :parto
  end

  get "/pos-parto" do
    erb "post-parto".to_sym
  end

  get "/lactancia" do
    erb :lactancia
  end

  get "/familia" do
    erb :familia
  end

  get "/servicios" do
    erb :servicios
  end

end
