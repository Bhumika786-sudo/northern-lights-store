class ProvincesController < ApplicationController
  before_action :authenticate_user!  # only logged-in users can manage taxes

  def index
    @provinces = Province.order(:name)
  end

  def edit
    @province = Province.find(params[:id])
  end

  def update
    @province = Province.find(params[:id])

    if @province.update(province_params)
      redirect_to provinces_path, notice: "Tax rates updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def province_params
    params.require(:province).permit(:gst_rate, :pst_rate, :hst_rate)
  end
end
