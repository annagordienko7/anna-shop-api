class UsersController < ApplicationController
  def index
    current_user = User.find_by(id: request.headers['User-Id'])
    if current_user&.admin?
      render json: User.all
    else
      render json: { error: "Доступ запрещен" }, status: :forbidden
    end
  end

  def update
    current_user = User.find_by(id: request.headers['User-Id'])
    target_user = User.find(params[:id])

    if current_user&.admin? || current_user == target_user
      if target_user.update(user_params)
        render json: { message: "Данные обновлены", user: target_user }
      else
        render json: target_user.errors, status: :unprocessable_entity
      end
    else
      render json: { error: "Вы можете редактировать только свой профиль" }, status: :forbidden
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role)
  end
end
