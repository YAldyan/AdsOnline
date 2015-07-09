class AdsController < ApplicationController 

  before_filter :check_logged_in, :only => [:edit, :update, :destroy]

  def new
    @ad = Ad.new
  end
  
  def create
    @ad = Ad.new(ad_params)
	
	if @ad.save
      redirect_to "/ads/#{@ad.id}"
    else
      render :template=>"ads/new"
    end
  end

  def show
    @ad = Ad.find(params[:id])
  end
  
  def index
    @ads = Ad.all()
  end
  
  def edit
    @ad = Ad.find(params[:id])
  end
  
  def update
    @ad = Ad.find(params[:id])
	if @ad.update_attributes(ad_params)
      redirect_to "/ads/#{@ad.id}"
    else
      render :template=>"/ads/edit"
    end
  end
  def destroy
    @ad = Ad.find(params[:id])
    @ad.destroy
    redirect_to '/ads/'
  end
  
  private
  def ad_params
    params.require(:ad).permit(:name, :price, :description, :seller_id, :email)
  end
  
  def check_logged_in
    authenticate_or_request_with_http_basic("Ads") do |username, password|
      username == "admin" && password == "t4k3th3r3dpi11"
    end
  end 
  
end
