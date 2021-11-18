require './student'
require './teacher'
require './book'
require './rental'

class App
  def initialize
    @books = []
    @people = []
    @exit_program = false
  end

  puts 'Welcome to School Library App!'

  def choose_option
    puts
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
    puts

    print 'Option: '
    gets.chomp
  end

  def list_books
    if @books.empty?
      puts 'There are no books created!'
    else
      @books.each do |e|
        puts "Title: \"#{e.title}\", Author: #{e.author}"
      end
    end
  end

  def list_people
    if @people.empty?
      puts 'There are no people created!'
    else
      @people.each do |e|
        puts "[#{e.class}] Name: #{e.name}, ID: #{e.id}, Age: #{e.age}"
      end
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_type = gets.chomp
    print 'Age: '
    person_age = gets.chomp.to_i
    print 'Name: '
    person_name = gets.chomp

    case person_type
    when '1'
      print 'Has parent permission? [Y/N]: '
      has_permission = gets.chomp
      case has_permission
      when 'y', 'Y'
        has_perm = true
      when 'n', 'N'
        has_perm = false
      end

      @people.push(Student.new(age: person_age, name: person_name, parent_permission: has_perm))
      puts 'Person created successfully'
    when '2'
      print 'Specialization: '
      specialization = gets.chomp
      @people.push(Teacher.new(specialization: specialization, age: person_age, name: person_name))
      puts 'Person created successfully'
    else
      puts 'Please, select a correct person type'
    end
  end

  def create_book
    print 'Title: '
    book_title = gets.chomp
    print 'Author: '
    book_author = gets.chomp
    @books.push(Book.new(title: book_title, author: book_author))
    puts 'Book created successfully'
  end

  def create_rental
    if @books.empty? || @people.empty?
      puts 'There are no books and/or people created!'
    else
      puts 'Select a book from the following list by number'
      @books.each_with_index do |e, index|
        puts "#{index}) Title: \"#{e.title}\", Author: #{e.author}"
      end
      book_number = gets.chomp.to_i
      puts

      puts 'Select a person from the following list by number (not id)'
      @people.each_with_index do |e, index|
        puts "#{index}) [#{e.class}] Name: #{e.name}, ID: #{e.id}, Age: #{e.age}"
      end
      person_number = gets.chomp.to_i

      puts
      print 'Date: '
      rental_date = gets.chomp
      Rental.new(rental_date, @people[person_number], @books[book_number])
      puts 'Rental created successfully'
    end
  end

  def list_rentals
    print 'ID of person: '
    person_id = gets.chomp.to_i

    person_found = false
    person_selected = nil
    @people.each do |e|
      if e.id == person_id
        person_found = true
        person_selected = e
      end
    end

    if person_found == false
      puts 'ID does not exist!'
    elsif person_selected.rentals.length.zero?
      puts 'This person does not have rentals'
    else
      person_selected.rentals.each do |e|
        puts "Date: #{e.date}, Book \"#{e.book.title}\" by #{e.book.author}"
      end
    end
  end

  def run
    loop do
      case choose_option
      when '1'
        list_books
      when '2'
        list_people
      when '3'
        create_person
      when '4'
        create_book
      when '5'
        create_rental
      when '6'
        list_rentals
      when '7'
        exit_program = true
      else
        puts 'That\'s not a correct option'
      end
      break if exit_program
    end
  end
end

def main
  app = App.new
  app.run
end

main()
