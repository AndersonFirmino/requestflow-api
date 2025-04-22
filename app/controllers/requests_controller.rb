class RequestsController < ApplicationController
  before_action :set_request, only: [:approve, :reject]
  before_action :authorize_admin, only: [:approve, :reject, :index]

  # GET /requests
  def index
    @requests = Request.all
    render json: @requests
  end

  # POST /requests
  def create
    @request = @current_user.requests.build(request_params)
    @request.status = "pending"

    if @request.save
      render json: @request, status: :created
    else
      render json: @request.errors, status: :unprocessable_entity
    end
  end

  # PUT /requests/:id/approve
  def approve
    @request.update(status: "approved")
    render json: @request
  end

  # PUT /requests/:id/reject
  def reject
    @request.update(status: "rejected")
    render json: @request
  end

  private

  def set_request
    @request = Request.find(params[:id])
  end

  def authorize_admin
    render json: { error: "Acesso restrito" }, status: :forbidden unless @current_user&.admin?
  end

  def request_params
    params.require(:request).permit(:title, :description)
  end
end
