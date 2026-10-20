class User < ApplicationRecord
  # Встроенная магия Devise для авторизации
  devise :database_authenticatable, :registerable, :validatable

  # Связь: у одного пользователя может быть много заказов (Таблица 3)
  has_many :orders, dependent: :destroy

  # Метод для удобной проверки, админ ли это
  def admin?
    role == 'admin'
  end
end
