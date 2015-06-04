class ApartmentsController < ApplicationController
  def index
    @apartment = Apartment.all
  end

  def new
  end

  def create
    if Apartment.create!(get_params)
      redirect_to 'index'
    else
      render 'edit'
    end
  end

  def edit
  end

  def show
  end

  private

  def get_params
    params.require(:apartment).permit(:description, :renter,:phone1)    
  end
end
