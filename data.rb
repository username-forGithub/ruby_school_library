require 'json'

module Data
  def load_books
    if File.exist?('books.json')
      JSON.parse(File.read('books.json')).map do |book|
        Book.new(book['title'], book['author'])
      end
    else
      []
    end
  end

  def load_people
    if File.exist?('people.json')
      JSON.parse(File.read('people.json')).map do |person|
        if person['json_class'] == 'Teacher'
          Teacher.new(person['specialization'], person['age'], person['name'])
        else
          Student.new(person['classroom'], person['age'],
                      person['name'], parent_permission: person['parent_permission'], id: person['id'])
        end
      end
    else
      []
    end
  end

  def load_rentals(creator)
    if File.exist?('rentals.json')
      JSON.parse(File.read('rentals.json')).map do |rental|
        rental_person = creator.people.find { |person| person.id == rental['person']['id'] }
        rental_book = creator.books.find { |book| book.title == rental['book']['title'] }
        Rental.new(rental['date'], rental_person, rental_book)
      end
    else
      []
    end
  end

  def list_all_books(books)
    if books.empty?
      puts 'The book list is empty, add some books... '
    else
      puts "Books list :\n\n"
      books.each_with_index do |book, index|
        puts "#{index + 1}) Title: '#{book.title}', Author: #{book.author}"
      end
    end
  end

  def list_all_people(people)
    if people.empty?
      puts 'The people list is empty, add some people...'
    else
      puts "People's list:\n\n"
      people.each_with_index do |person, index|
        puts "#{index + 1}) Type: #{person.type}, Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
  end

  def write_data(people, books, rentals)
    opts = {
      array_nl: "\n",
      object_nl: "\n",
      indent: '  ',
      space_before: ' ',
      space: ' '
    }
    File.write('books.json', JSON.pretty_generate(books, opts)) if books.any?
    File.write('people.json', JSON.pretty_generate(people, opts)) if people.any?
    File.write('rentals.json', JSON.pretty_generate(rentals, opts)) if rentals.any?
  end
end
