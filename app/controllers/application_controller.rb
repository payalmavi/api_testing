class ApplicationController < ActionController::API
  
   def authorize_request
    header = request.headers['Authorization']
    if header.present?
      jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
      current_user = User.find(jwt_payload['sub'])

    else
      render json: { error: 'Authorization header missing or Invalid Token' }, status: :unprocessable_entity
    end
  end

 
end
