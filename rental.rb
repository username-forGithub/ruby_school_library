class Rental
  attr_accessor :date, :book, :person

  def initialize(date, person, book)
    @date = date

    @person = person
    person.rentals << self

    @book = book
    book.rentals << self
  end

  def to_json(*args)
    {
      JSON.create_id => self.class.name,
      :date => @date,
      :book => {
        JSON.create_id => @book.class.name,
        :title => @book.title,
        :author => @book.author
      },
      :person => {
        JSON.create_id => @person.class.name,
        :name => @person.name,
        :age => @person.age,
        :id => @person.id
      }
    }.to_json(*args)
  end
end
