class Api::V1::UserController < Api::ApiController
  include ActionController::MimeResponds
  respond_to :json
  # def index
  #   render json:@current_user
  # end
  def index
    if params[:authentication_token] != nil
      if User.find_by_authentication_token(authentication_token = params[:authentication_token])
        @user = User.find_by_authentication_token(authentication_token = params[:authentication_token])
        logger.info("Successful #{@user.name} connection to user json.")
        render :status =>200,
               :json=>@user
      else
        logger.info("Failed connection to user json, a user cannot be found by that authentication_token.")
        render :status =>200,
               :json=>{:message=>"Failed connection to user json, a user cannot be found by that authentication_token."}
      end
    else
      logger.info("Failed connection to user json, no authentication token posted.")
      render :status=>400,
            :json=>{:message=>"Did you add the user's authentication_token?"}
      return
    end
  end
  def update
    if params[:authentication_token] != nil
      if User.find_by_authentication_token(authentication_token = params[:authentication_token])
        @user = User.find_by_authentication_token(authentication_token = params[:authentication_token])
        @user.preferences = params[:preferences]
        @user.save!
      else
        logger.info("Failed connection to user/edit json, a user cannot be found by that authentication_token.")
        render :status =>200,
               :json=>{:message=>"Failed connection to user/edit json, a user cannot be found by that authentication_token."}
      end
    else
      logger.info("Failed connection to user/edit json, no authentication token posted.")
      render :status=>400,
            :json=>{:message=>"Did you add the user's authentication_token?"}
      return
    end
  end
end
