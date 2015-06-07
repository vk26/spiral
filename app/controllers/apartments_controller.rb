class ApartmentsController < ApplicationController
  def index
    @apartments = Apartment.all
  end

  def new
    @apartment = Apartment.new
  end

  def create
    @apartment = Apartment.create(get_params)
    if @apartment.save
      redirect_to apartments_path
    else
      render 'new'
    end
  end

  def edit
    @apartment = Apartment.find(params[:id])
  end

  def update
    @apartment = Apartment.find(params[:id])
    if @apartment.update(get_params)
      redirect_to apartments_path
    else
      render 'edit'
    end    
  end

  def destroy
    @apartment = Apartment.find(params[:id])
    @apartment.destroy
    redirect_to apartments_path  
  end

  def show
  end

  private

  def get_params
    params.require(:apartment).permit(:description, :renter,:phone1)    
  end
end
