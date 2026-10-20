class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  before_action :configure_sign_up_params, only: [:create]

  # Полностью переопределяем стандартный метод создания Devise
  def create
    build_resource(sign_up_params)

    # Просто сохраняем пользователя в PostgreSQL напрямую
    if resource.save
      render json: { 
        message: 'Регистрация прошла успешно. Теперь вы можете войти под своим аккаунтом!', 
        user: resource 
      }, status: :ok
    else
      # Если пароль короткий или email занят — возвращаем массив ошибок
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role])
  end
end
