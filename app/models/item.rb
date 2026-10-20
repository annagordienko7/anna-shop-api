class Item < ApplicationRecord
  # Связь: товар может присутствовать во многих строках описания заказов (Таблица 4)
  has_many :order_descriptions

  # Поиск по названию (для Шага 2 вашего ТЗ). Игнорирует регистр букв.
  scope :search_by_name, ->(query) { query.present? ? where("name ILIKE ?", "%#{query}%") : all }
end
