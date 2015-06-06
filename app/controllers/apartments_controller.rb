class ApartmentsController < ApplicationController
  def index
    @apartments = Apartment.all
  end

  def new
    @apartment = Apartment.new
  end

  def create
    if Apartment.create!(get_params)
      redirect_to apartments_path
    else
      render 'edit'
    end
  end

  def edit
    @apartment = Apartment.find_by_id(params[:id])
  end

  def update
    @apartment = Apartment.find_by_id(params[:id])
    if @apartment.update(get_params)
      redirect_to apartments_path
    else
      render 'edit'
    end    
  end

  def destroy
    @apartment = Apartment.find_by_id(params[:id])
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
