class ItemsController < ApplicationController
  def index
    @items = Item.search_by_name(params[:search])
    render json: @items
  end

  def create
    if current_user_admin?
      @item = Item.new(item_params)
      if @item.save
        render json: @item, status: :created
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Доступ запрещен. Вы не админ." }, status: :forbidden
    end
  end

  def update
    if current_user_admin?
      @item = Item.find(params[:id])
      if @item.update(item_params)
        render json: @item
      else
        render json: @item.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Доступ запрещен. Вы не админ." }, status: :forbidden
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price)
  end

  def current_user_admin?
    user = User.find_by(id: request.headers['User-Id'])
    user&.admin?
  end
end
