class OrdersController < ApplicationController
  def index
    user = User.find_by(id: request.headers['User-Id'])
    if user
      @orders = user.orders.includes(order_descriptions: :item)
      render json: @orders.to_json(include: { order_descriptions: { include: :item } })
    else
      render json: { error: "Пользователь не найден" }, status: :unauthorized
    end
  end

  def create
    user = User.find_by(id: request.headers['User-Id'])
    return render json: { error: "Необходима авторизация" }, status: :unauthorized unless user

    ActiveRecord::Base.transaction do
      @order = user.orders.build(amount: 0)
      total_amount = 0

      params[:items].each do |cart_item|
        item = Item.find(cart_item[:id])
        qty = cart_item[:quantity].to_i
        total_amount += item.price * qty

        @order.order_descriptions.build(item: item, quantity: qty)
      end

      @order.amount = total_amount
      @order.save!
    end

    render json: @order, include: :order_descriptions, status: :created
  rescue => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
