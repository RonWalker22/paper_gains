class OrdersController < ApplicationController
  before_action :check_signed_in
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_league_user, only: [:destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    order = @league_user.orders.find(params[:id])
    if !order.open?
      flash[:alert] = "Order cancel unsuccessful. This order has already been filled."
    elsif order.ready?
       flash[:alert] = "Order cancel unsuccessful. The conditions for this order have
                        already been met. This order will fill shortly."
    elsif order
      if order.side == 'buy'
        reserve_coin = @league_user.wallets.find order.quote_currency_id
      else
        reserve_coin = @league_user.wallets.find order.base_currency_id
      end
      reserve_coin.decrement! 'reserve_quantity', order.reserve_size
      if order.destroy
        flash[:notice] = "Order cancel was successful."
      end
    else
      flash[:alert] = "Order cancel unsuccessful."
    end
    redirect_back(fallback_location: root_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def set_league_user
      @league_user = LeagueUser.find_by user_id: current_user.id, league_id: params[:lid]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.fetch(:order, {})
    end
end
