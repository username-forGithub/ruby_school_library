require_relative './person'

class Student < Person
  attr_reader :classroom, :type, :parent_permission

  def initialize(classroom, age, name, parent_permission: true, id: Random.rand(1..1000))
    super(age, name: name, parent_permission: parent_permission, id: id)
    @classroom = classroom
    @type = 'Student'
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      :age => @age,
      :name => @name,
      :parent_permission => @parent_permission,
      :type => @type,
      :classroom => @classroom,
      :id => @id
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

fff = Student.new('classssssroom', 55, 'nameeee')
p fff
