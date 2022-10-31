require './person'

class Teacher < Person
  attr_accessor :specialization

  def initialize(specialization, age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission = true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end

teacher_obj = Teacher.new('math')
p teacher_obj.can_use_services?
