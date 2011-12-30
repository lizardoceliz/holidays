desc "This task will be called by the Heroku scheduler add-on"

anio  = Time.now.year
hoy   = Time.now
hoy   = Time.strptime("{ #{anio}, 4, 21}", "{ %Y, %m, %d }")
delta = 14 # dias con anterioridad para notificar

def prueba
  puts "esto es una subrutina"
end  

task :processing_holidays => :environment do
  User.all.each do |user|
    puts "Usuario: #{user.name}"
    user.holidays.each do |holiday|
      feriado    = Time.strptime("{ #{anio}, #{holiday.month}, #{holiday.day} }", "{ %Y, %m, %d }")
      diferencia = (((feriado - hoy).to_i / 60).to_i / 60).to_i / 24 

      puts "La fecha del feriado #{holiday.name} es: #{feriado} para el usuario: #{user.name}"
      puts "diferencia en dias: #{diferencia}"
      
      if diferencia >= 0 && diferencia <= 14
          user.customers.each do |customer|
            Notifier.notifier_customer(user, customer, feriado).deliver
            puts "Se agregara el feriado para envio de mail"
          end  
      else
          puts "No se agregara el feriado"    
      end
    end
    prueba
  end
  
#   User.all.each do |user|
#     puts "Usuario: #{user.name}"
#   end
   
#   Customer.all.each do |customer|
#     puts "Cliente: #{customer.name}"
#   end
   
#   Holiday.all.each do |holiday|
#     puts "Holiday name: #{holiday.name} "
#   end
   
#   puts RUBY_VERSION 
end