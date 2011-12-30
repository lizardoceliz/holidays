class Notifier < ActionMailer::Base
  default from: "info@holidaysreminder.com"
  
  def notifier_customer(user, customer, date)
      @user = User.find(user)
      @customer = Customer.find(customer)
      @date = date.strftime("%Y-%m-%d")
      mail(:to => @customer.email, :subject => "[Holidays Reminder] A holiday is coming for #{@user.name}")
  end
end
