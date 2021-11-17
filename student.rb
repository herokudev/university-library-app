require './person'

class Student < Person
  def initialize(age:, classroom:, name: 'Unknown', parent_permission: true)
    super(name: name, age: age, parent_permission: parent_permission)
    @classroom = classroom.add_student(self) unless classroom.nil?
  end

  attr_accessor :classroom

  def play_hooky
    '¯\(ツ)/¯'
  end
end
