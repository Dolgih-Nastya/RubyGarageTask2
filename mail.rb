class Mail
  attr_accessor  :city, :street, :house, :apartment, :destination, :value
  def initialize (address)
    @city=address[:city]
    @street=address[:street]
    @house=address[:house]
    @apartment=address[:apartment]
    @destination=address[:destination]
    @value=address[:value]
  end

  def address
    "#{@city} #{@street} #{@house} #{@apartment}"
  end

end