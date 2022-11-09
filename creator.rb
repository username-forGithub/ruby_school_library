require './book'
require_relative './student'
require_relative './teacher'
require_relative './rental'
require_relative 'permissions'
require_relative 'data'
class Creator
  include Data
  attr_accessor :people, :books, :rentals

  def initialize
    @people = load_people
    @books = load_books
    @rentals = load_rentals(self)
    @permissions = Permissions.new
  end

  def create_book
    print 'Title: '
    title = gets.chomp

    print 'Author: '
    author = gets.chomp

    book = Book.new(title, author)
    @books << book unless @books.include?(book)

    puts "The book '#{title}' by #{author} was created successfully! "
  end

  def create_person
    puts 'Do you want to create a student (press 1) or a teacher (press 2)?'
    choice = gets.chomp.to_i
    case choice
    when 1
      register_student
    when 2
      register_teacher
    else
      puts 'Incorrect choice, choose a number between 1..2 '
      create_person
    end
  end

  def age_name
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp.to_s
    [name, age]
  end

  def register_student
    variables = age_name
    name = variables[0]
    age = variables[1]

    print 'Classroom: (B121, A233..) '
    classroom = gets.chomp

    has_permission = @permissions.permission?

    student = Student.new(classroom, age, name, parent_permission: has_permission)

    @people << student unless @people.include?(student)

    puts "The student '#{name}' aged '#{age}' with the classroom '#{classroom}' was created successfully!"
  end

  def register_teacher
    variables = age_name
    name = variables[0]
    age = variables[1]

    print 'Specialization: '
    specialization = gets.chomp

    teacher = Teacher.new(specialization, age, name)
    @people << teacher unless @people.include?(teacher)

    puts "The teacher '#{name}' aged '#{age}' with specialization in '#{specialization}' was created successfully!"
  end

  def create_rental
    print "Select a book from the following list by number:\n"
    list_all_books(@books)
    prompt_user if @books.empty?
    book_index = gets.chomp.to_i - 1

    print "Select a person from the following list by number:\n"
    list_all_people(@people)
    prompt_user if @people.empty?
    person_index = gets.chomp.to_i - 1

    print 'Date [yyyy/mm/dd] : '
    date = gets.chomp

    rental = Rental.new(date, @people[person_index], @books[book_index])
    @rentals << rental unless @rentals.include?(rental)

    puts 'Rental successfully created! '
  end
end
