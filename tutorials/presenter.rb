#Presenter is a subpattern of decorator pattern

# decorator pattern is a side effect which provides flexible alternative to subclasses
# decorator over subclassing because it can be applied on runtime

class CoffeeMachine
  attr_reader :price

  def initialize(price)
    @price = price
  end
end

# class SteamedMilkCoffeeMachineDecorator
#   def initialize(obj)
#     @obj = obj
#   end

#   def price
#     @obj.price + 300
#   end

#   def can_steam_milk?
#     true
#   end
# end
#instead of that we can use SimpleDelegator

class SteamedMilkCoffeeMachineDecorator < SimpleDelegator
  def price
    super + 300
  end

  def can_steam_milk?
    true
  end
end



machine = CoffeeMachine.new(500)
with_steamer = SteamedMilkCoffeeMachineDecorator.new(machine)
