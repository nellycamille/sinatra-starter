
class MyApplication < Sinatra::Base
  include Sinatra::Auth::Helpers

  get "/admin" do
    if authenticated?
      redirect '/admin/leads'
    else
      erb :login
    end
  end

  post "/admin" do
    authenticate(params['email'], params['password'])

    if authenticated?
      redirect '/admin/leads'
    else
      @error = "Invalid email/password combination"
      erb :login
    end
  end

  get "/admin/logout" do
    super_protected!
    logout! (false)

    redirect '/admin'

  end

  get "/admin/leads" do
    super_protected!
    @leads = Lead.paginate( page: params[:page] , per_page: 10 )
    @leads = @leads.order(name: :asc)

    if params[:search]
      @leads = @leads.where("name ILIKE ?" , "%#{params[:search]}%" )
    end

    if params[:status] != nil && params[:status] != ""
      @leads = @leads.where( status: params[:status] )
    end

    erb :admin_leads, layout: :admin_layout
  end

  get "/admin/leads/:id" do
    super_protected!
    @lead = Lead.find( params[:id] )
    erb :admin_lead, layout: :admin_layout
  end

  post "/admin/leads/:id/change_status" do
    super_protected!
    @lead = Lead.find( params[:id] )
    @lead.status = params[:status]
    @lead.save

    redirect "/admin/leads/" + @lead.id.to_s

  end

  post "/admin/leads/:id" do
    super_protected!
    @lead = Lead.find( params[:id] )


    c = Comment.new
    c.comment = params[:comments]
    c.lead    = @lead
    c.user    = authenticated_user
    c.save

    erb :admin_lead, layout: :admin_layout
  end

  get "/admin/leads/comments/:comment_id" do
    super_protected!

    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    redirect "/admin/leads/#{@comment.lead.id}"
  end

  get "/admin/uploads/delete/images/:image_id" do

    super_protected!

    @image = Image.find(params[:image_id])
    @image.destroy
    redirect "/admin/uploads"

  end

    get "/admin/uploads" do

      super_protected!
      @images = Image.order( galeria: :asc )
      @galleries = { "bellie_painting" => "Belly Painting" , "blessing" => "Blessings" , "embarazo" => "Embarazo" , "parto" => "Parto" , "pos-parto" => "Pos Parto" , "lactancia" => "Lactancia" , "familia" => "Familia" , "ninosyninas" => "Niños y Niñas" }
      erb :admin_uploads , layout: :admin_layout

    end

    post "/admin/uploads" do
      super_protected!
      #Create new Image Model
      img = Image.new

      #Save the data from the request
      img.image    = params[:file] #carrierwave will upload the file automatically
      img.caption = params[:caption] #Or recieve it from params
      img.galeria = params[:galeria]

      success = img.save
      if success
        flash[:success] = "Uploaded File"
      else
        flash[:danger] = "Error Uploading File"
      end



      redirect "/admin/uploads"
    end

  end
