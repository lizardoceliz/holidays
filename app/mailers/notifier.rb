class Notifier < ActionMailer::Base
  default from: "info@holidaysreminder.com"
  
  def notifier_customer(user, customer, date)
      @user = user
      @customer = customer
      @date = date
      mail(:to => customer.email, :subject => "A holiday is coming for #{user.name}")
  end
end
