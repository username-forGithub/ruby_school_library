require './nameable'
require './capitalize_decorator'
require './trimmer_decorator'

class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id, :parent_permission

  def initialize(age, name: 'unknown', parent_permission: true, id: Random.rand(1..1000))
    super()
    @id = id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def correct_name
    @name
  end

  def can_use_services?
    if of_age? || @parent_permission
      true
    else
      false
    end
  end

  def add_rental(rental)
    @rentals.push(rental)
    rental.person = self
  end

  private

  def of_age?
    age >= 18
  end
end
