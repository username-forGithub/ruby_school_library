require_relative './person'

class Student < Person
  attr_reader :classroom, :type

  def initialize(classroom, age, name, parent_permission: true, type: 'Student')
    super(age, name: name, parent_permission: parent_permission)
    @classroom = classroom
    @type = type
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      :age => @age,
      :name => @name,
      :parent_permission => @parent_permission,
      :type => @type,
      :classroom => @classroom
    }.to_json(*args)
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
