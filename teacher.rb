require './person'

class Teacher < Person
  attr_reader :specialization, :type

  def initialize(specialization, age, name: 'Unknown', parent_permission: true, type: 'Teacher')
    super(age, name: name, parent_permission: parent_permission, id: id)
    @specialization = specialization
    @type = type
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      :name => @name,
      :age => @age,
      :specialization => @specialization,
      :parent_permission => @parent_permission,
      :type => @type
    }.to_json(*args)
  end

  def can_use_services?
    true
  end
end
