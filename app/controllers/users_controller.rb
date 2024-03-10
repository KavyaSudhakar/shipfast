class UsersController < ApplicationController
    before_action :set_customer, only: [:offboard]
   
    
    def customers
      @customers = User.where(role: :customer)
    end
  
    def delivery_partners
      @delivery_partners = User.where(role: :delivery_partner)
    end

    def onboard_form
        @user = User.new
    end
    
    def onboard
      if current_user.admin?
        @user = User.new(user_params)
        role = params[:user][:role] 
        @user.role = role if ['customer', 'delivery_partner'].include?(role&.downcase)
        if @user.save
          flash[:success] = "#{role&.titleize} onboarded successfully."
          redirect_to role&.downcase == 'customer' ? customers_path : delivery_partners_path
        else
          flash.now[:error] = "Failed to onboard #{role&.titleize}."
          render :onboard_form
        end
      else
        flash[:error] = "You are not authorized to onboard users."
        redirect_to customers_path
      end
    end
    
    def offboard
      if current_user.admin? && @user.present? && @user.deactivated == false
        @user.update(deactivated: true)
        flash[:success] = "User offboarded successfully."
      else
        flash[:error] = "You are not authorized to offboard this user."
      end
      redirect_back fallback_location: root_path
    end
  
    private
  
    def set_customer
      @customer = User.find(params[:id])
    end
  
    def user_params
        params.require(:user).permit(:full_name, :email, :password, :password_confirmation, :role)
    end


      
  end
  