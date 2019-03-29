class User < ApplicationRecord
    has_many :articles
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
    include DeviseTokenAuth::Concerns::User
    enum role: {visitor: 0, journalist: 1, subscriber: 2, editor: 3}
end
