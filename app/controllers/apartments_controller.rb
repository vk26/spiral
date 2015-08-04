class ApartmentsController < ApplicationController
  before_action :find_apartment, only: [:edit, :update, :destroy, :show]

  def index
    @apartments = Apartment.all
  end

  def new
    @apartment = Apartment.new
  end

  def create
    @apartment = Apartment.create(apartment_params)
    if @apartment.save
      redirect_to apartments_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @apartment.update(apartment_params)
      redirect_to apartments_path
    else
      render "edit"
    end
  end

  def destroy
    @apartment.destroy
    redirect_to apartments_path
  end

  def show
  end

  def download_ads
    Parser.pull_apartments
    redirect_to apartments_path
  end

  private

  def apartment_params
    params.require(:apartment).permit(:description, :renter, :phone1, :type_apartment, :price, assets_attributes: [:id, :photo])
  end

  def find_apartment
    @apartment = Apartment.find(params[:id])
  end
end
