# base class
class Car
  attr_reader :price

  def initialize(price)
    @price = price
  end
end


# decoratior on the base class

class CarWithFlexibleSeats < Decorator
  def price
    mercedes + 5_000
  end
end


car = Car.new
car.price = 10_000

car = CarWithFlexibleSeats.new(car)

# use a simple delegator (decorator)
# SimpleDelgator is a Ruby class that provides means to easily delegate all method calls to an object
# passed to a constructor. A simple implementation of decorator is this


# decorator will basically
class UserDecorator < SimpleDelegator
  def full_name
    first_name + " " + last_name
  end

  def protected_email
    return "Private" if email_private?
    email
  end

  def formatted_birthday
    birthday.strftime("%d %b %Y")
  end
end

class UserController < ApplicationController
  def show
    user = User.first
    @user = UserDecorator.new(user)
  end
end
