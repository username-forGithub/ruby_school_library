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
                      person['name'], parent_permission: person['parent_permission'])
        end
      end
    else
      []
    end
  end

  def write_data(people, books)
    opts = {
      array_nl: "\n",
      object_nl: "\n",
      indent: '  ',
      space_before: ' ',
      space: ' '
    }
    File.write('books.json', JSON.pretty_generate(books, opts)) if books.any?
    File.write('people.json', JSON.pretty_generate(people, opts)) if people.any?
  end
end

