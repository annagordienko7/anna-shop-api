class Order < ApplicationRecord
  # Связь: заказ строго принадлежит конкретному пользователю (Таблица 1)
  belongs_to :user

  # Связь: у заказа много строк с описанием (Таблица 4)
  has_many :order_descriptions, dependent: :destroy
  # Связь: через описание заказа мы можем быстро вытащить сами товары
  has_many :items, through: :order_descriptions
end
