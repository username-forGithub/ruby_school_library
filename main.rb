require_relative './app'

def menu
  puts "\nPlease choose an option by entering a number:"
  options = [
    '1 - List all books',
    '2 - List all people',
    '3 - Create a person',
    '4 - Create a book',
    '5 - Create a rental',
    '6 - List all rentals for a given person (id)',
    '7 - Exit App'
  ]
  puts options
end

def main
  puts "\n Welcome to School Library App! \n"
  app = App.new
  app.run
end

main
