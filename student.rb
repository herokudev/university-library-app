require './person'

class Student < Person
  def initialize(classroom)
    super(age, name: 'unknown', parent_permission: true)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
