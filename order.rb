class Order
 attr_accessor :book_name, :reader_name, :order_date, :issue_date
 def initialize (order_data)
   @book_name    =  order_data[:book_name]
   @reader_name  =  order_data[:reader_name]
   @order_date   =  order_data[:order_date]
   @issue_date   =  order_data[:issue_date]
   @is_satisfied =  order_data[:@is_satisfied]
 end

  def period
    if @issue_date
       @issue_date-@order_date
    else
        Float::MAX
    end
  end
end