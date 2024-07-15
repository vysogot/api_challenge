class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render :not_found, json: { id: params[:id], error: 'bike not found' }
  end
end
