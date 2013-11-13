require_relative 'order'
require_relative 'mail'
require 'active_support/all'
def   smallest_period(orders)
    (orders.min {|x| x.period}.period/1.day).to_i
end

def   what_is_the_most_popular(orders, key)
  freq = orders.inject(Hash.new(0)) { |h,v| h[v.send(key)] += 1; h }
  orders.sort_by { |v| freq[v.send(key)] }.last.send(key)
end

def top_three_books(orders)
  temp=orders.clone
  readers=[]
  3.times do
     book=what_is_the_most_popular(temp, "book_name") unless temp.empty?
     temp.map!{|order| if order.book_name==book
                         readers<<order.reader_name unless readers.include?  order.reader_name
                         nil
                       else
                         order
                       end
                         }
    temp.compact!
  end
  readers.count
end
def   number_of_parcels_sent_to_city(mails,city_name)
  mails.select{|mail| mail.city == city_name}.count
end

def   how_many_parcels_with_value_higher_than_10_were_sent(mails)
  mails.select{|mail| mail.value>10 }.count
end

def  number_of_not_satisfied(orders)
  orders.select{|order| order.issue_date.nil?}.count
end


a = Order.new({reader_name:"Vasya", book_name:"Garry",order_date:10.day.ago, issue_date:5.day.ago})
b = Order.new({reader_name:"Galya", book_name:"Math1",order_date:15.day.ago, issue_date:1.day.ago})
c = Order.new({reader_name:"Vasya", book_name:"Math1",order_date:10.day.ago})

orders = [a, b ,c]
puts 'Tasks about orders'
puts "First task. The smallest period for which library found a book: #{smallest_period (orders)}"
puts "Second task. How many orders were not satisfied: #{number_of_not_satisfied(orders)}"
puts "Third task. Who often takes the book:  #{what_is_the_most_popular(orders, 'reader_name')}"
puts "Fourth task. What is the most popular book: #{what_is_the_most_popular(orders, 'book_name')}"
puts "Fifth task. How many people ordered one of the three most popular books:  #{top_three_books(orders)}"


mail1 = Mail.new ({city:"Dnepr",   street:"Oktyabrskaya",  house:33, apartment:12, destination: "dest1", value:2})
mail2 = Mail.new ({city:"Kharkov", street:"Oktyabrskaya",  house:33, apartment:12, destination: "dest1", value:0})
mail3 = Mail.new ({city:"Dnepr",   street:"Oktyabrskaya",  house:33, apartment:12, destination: "dest1", value:90})

mails=[mail1, mail2, mail3]
puts 'Tasks about mails'
puts "First task. The number of parcels sent to some city: #{number_of_parcels_sent_to_city(mails,"Kharkov")}"
puts "Second task. How many parcels with value higher than 10 were sent: #{how_many_parcels_with_value_higher_than_10_were_sent(mails)}"
puts "Third task. What is the most popular address: #{what_is_the_most_popular(mails, "address")}"
