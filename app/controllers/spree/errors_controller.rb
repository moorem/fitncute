class Spree::ErrorsController < Spree::StoreController
  def show
    render status_code.to_s, :status => status_code
  end

  protected

  def status_code
    params[:code] || 404
  end
end