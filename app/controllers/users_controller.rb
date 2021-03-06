class UsersController < ApplicationController
  before_action :check_signed_in, only: [:show]
  before_action :set_user, only: [:show]

  def index
      @users = User.all.order("created_at")
    if params[:search]
      @users = User.search(params[:search]).order("created_at")
    else
      @users = User.all.order("created_at")
    end
  end

  def show
  end

  def current_user_home
    redirect_to current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user)
    end
end
