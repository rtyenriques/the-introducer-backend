class UserSerializer < ActiveModel::Serializer
  attributes :usernmae, :email, :avatar, :bio
end
