class Api::V1::UsersController < ApplicationController
    #doesnt ask a user to be authorized if no account
  skip_before_action :authorized, only: [:create]

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

    def create
      @user = User.create(user_params)
  
        # if @user.valid?
        #     render json: { user: UserSerializer.new(@user) }, status: :created
        if @user.valid?
            @token = encode_token(user_id: @user.id)
            render json: {
                     user: UserSerializer.new(@user),
                     jwt: @token,
                   },
                   status: :created
        else
            render json: {
                error: 'failed to create user',
            },
            #built in rails http status code symbol
            status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :bio, :avatar)
    end
end