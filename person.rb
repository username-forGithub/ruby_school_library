require './nameable'
require './capitalize_decorator'
require './trimmer_decorator'

class Person < Nameable
  attr_accessor :name, :age, :parent_permission
  attr_reader :id

  def initialize(age, name = 'unknown', parent_permission: true)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
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

  private

  def of_age?
    age >= 18
  end
end

# person = Person.new(22, 'maximilianus')
# p  person.correct_name
#   capitalizedPerson = CapitalizeDecorator.new(person)
# p  capitalizedPerson.correct_name
#   capitalizedTrimmedPerson = TrimmerDecorator.new(capitalizedPerson)
# p capitalizedTrimmedPerson.correct_name
