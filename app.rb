require_relative 'creator'
require_relative 'data'

class App
  include Data

  def initialize
    @creator = Creator.new
  end

  def run
    prompt_user
  end

  def prompt_user
    menu
    choice = gets.chomp.to_i
    choice == 7 ? quit_app : option_case(choice)
    prompt_user
  end

  def quit_app
    puts 'Thank you for using this app! Exiting...'
    write_data(@creator.people, @creator.books, @creator.rentals)
    puts 'Have a great time...'
    exit
  end

  def option_case(choice)
    case choice
    when 1
      list_all_books(@creator.books)
    when 2
      list_all_people(@creator.people)
    when 3
      @creator.create_person
    when 4
      @creator.create_book
    when 5
      @creator.create_rental
    when 6
      list_rentals_by_id
    else
      puts "\n Incorrect choice, choose a number between 1..7"
    end
  end

  def list_rentals_by_id
    print "Enter a person's ID: "
    person_id = gets.chomp.to_i
    if !@creator.people.find { |person| person.id == person_id }
      puts "No rental found with ID: #{person_id} "
    elsif @creator.rentals.empty?
      puts 'The rental list is empty, add some rentals...'
    else
      puts "Rentals list :\n\n"
      @creator.rentals.select do |rental|
        if rental.person.id == person_id
          puts "Date: #{rental.date}, Book: '#{rental.book.title}' rented by #{rental.person.name}"
        end
      end
    end
  end
end
