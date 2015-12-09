class MyApplication < Sinatra::Base

  get "/" do
    erb :index
  end

  get "/contacto" do
    erb :contacto
  end

  post "/contacto" do
    @lead = Lead.create(params[:lead])
    @invalid = @lead.errors.size > 0
    @success = !@invalid
    erb :contacto
  end

  get "/galleries/:gallery_id" do

      @images = Image.where( galeria: params[:gallery_id] )
      erb :galleries
  end


end
