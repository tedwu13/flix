class UsersController < ApplicationController
  def index
    @wish_lists = current_user.wish_lists

    render json: @wish_lists
  end
end

# sql relationships
# 1-Many
class WishList < ApplicationRecord
  has_many :books
end

class Book < ApplicationRecord
  belongs_to :wishlist
end

class User < ApplicationRecord
  has_many :books
end

# [
#    {
#       "id":43,
#       "user":
#           {
#               "id": 1,
#               "username": "Vaidehi"
#           },
#       "name":"Favorite Shakespeare Plays To Re-Read",
#       "created_at":"2015-06-23T21:07:30.108Z",
#       "updated_at":"2015-06-23T21:07:30.108Z",
#       "books":
#           [
#               {
#                   "id": 24,
#                   "title": "A Midsummer Night's Dream",
#                   "author": "William Shakespeare"
#               },
#               {
#                   "id": 48,
#                   "title": "The Tempest",
#                   "author": "William Shakespeare"
#               },
#               {
#                   "id": 13,
#                   "title": "Much Ado About Nothing",
#                   "author": "William Shakespeare"
#               }
#           ]
#    }
# ]
