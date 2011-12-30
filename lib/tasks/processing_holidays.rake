desc "This task will be called by the Heroku scheduler add-on"

anio  = Time.now.year
hoy   = Time.now
hoy   = Time.strptime("{ #{anio}, 4, 28}", "{ %Y, %m, %d }")
delta = 14 # dias con anterioridad para notificar

def prueba
  puts "esto es una subrutina"
end  

task :processing_holidays => :environment do
  User.all.each do |user|
    puts "Usuario: #{user.name}"
    user.holidays.each do |holiday|
      feriado    = Time.strptime("{#{anio}, #{holiday.month}, #{holiday.day} }", "{ %Y, %m, %d }")
      diferencia = (((feriado - hoy).to_i / 60).to_i / 60).to_i / 24 

      puts "La fecha del feriado #{holiday.name} es: #{feriado} para el usuario: #{user.name}"
      puts "diferencia en dias: #{diferencia}"
      
      if diferencia >= 0 && diferencia <= delta
          user.customers.where(:remember_me => true).each do |customer|
            cantidad = Reminder.where("user_id = ? and customer_id = ? and holiday = ?", user.id, customer.id, feriado).count
            if cantidad == 0
              @reminder             = Reminder.new
              @reminder.user_id     = user.id
              @reminder.customer_id = customer.id
              @reminder.holiday     = feriado
              @reminder.save
              puts "Se agrego el feriado para envio de mail"
            else
              puts "Ya existia el registro de envio en Reminder"  
            end
          end 
      else
          puts "No se agrego el feriado"    
      end
    end
  end
    
  # Enviar emails
  Reminder.order("holiday ASC").where("holiday >= ?", hoy).where(:sent => nil).each do |reminder|
    Notifier.notifier_customer(reminder.user_id, reminder.customer_id, reminder.holiday).deliver
    reminder.sent = true
    reminder.save
    puts "Envio email para usuario: #{reminder.user_id}, customer: #{reminder.customer_id}, holiday: #{reminder.holiday}"
  end   
end

# puts RUBY_VERSION
# prueba