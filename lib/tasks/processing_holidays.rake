desc "This task will be called by the Heroku scheduler add-on"
hoy   = Time.now
anio  = hoy.year  
hoy   = Time.strptime("{ #{anio}, 12, 28}", "{ %Y, %m, %d }")
mes   = hoy.month
delta = 14 # dias con anterioridad para notificar

task :processing_holidays => :environment do
  def agregarNotificacion(user, delta, hoy, mes, anio)
      puts "entro en notificador"
      user.holidays.order("month ASC").where("month = ?", mes).each do |holiday|
        feriado    = Time.strptime("{#{anio}, #{holiday.month}, #{holiday.day} }", "{ %Y, %m, %d }")
        diferencia = (((feriado - hoy).to_i / 60).to_i / 60).to_i / 24 

        puts "La fecha del feriado #{holidaysy.name} es: #{feriado} para el usuario: #{user.name}"
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
  
  User.all.each do |user|
    puts "Usuario: #{user.name}"
    
    agregarNotificacion(user, delta, hoy, mes, anio)
    if(mes == 12)
        mes  = 1 
        anio = anio + 1
    else
        mes += 1
    end  
    agregarNotificacion(user, delta, hoy, mes, anio)
  # Enviar emails
  Reminder.order("holiday ASC").where("holiday >= ?", hoy).where(:sent => nil).each do |reminder|
    Notifier.notifier_customer(reminder.user_id, reminder.customer_id, reminder.holiday).deliver
    reminder.sent = true
    reminder.save
    puts "Envio email para usuario: #{reminder.user_id}, customer: #{reminder.customer_id}, holiday: #{reminder.holiday}"
  end
  
  end  
end

# puts RUBY_VERSION
# prueba