require './person'

class Student < Person
  attr_accessor :classroom

  def initialize(classroom, age, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission = true)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end

student_obj = Student.new(10)
p student_obj.play_hooky
