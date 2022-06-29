class ApplicationController < ActionController::Base
  
  before_action :authenticate_customer!, except: [:top,
                                                  :index, 
                                                  :show, 
                                                  :about, 
                                                  :search, 
                                                  :item_search, 
                                                  :get_category_children, 
                                                  :menu_search, 
                                                  :shop_search, 
                                                  :blog_search,
                                                  :customer_search]
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    if resource.is_a?(Admin)
      admin_root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    else
      new_customer_session_path
    end
  end

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:[:user_name,
                                                      :last_name,
                                                      :first_name,
                                                      :last_name_kana,
                                                      :first_name_kana,
                                                      :postal_code,
                                                      :address,
                                                      :telephone_number])
  end
  
end
