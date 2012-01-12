task :countries_states => :environment do
  p1 = Country.new(:name => "Argentina", :code => "AR")
  p1.save
  
  p2 = Country.new(:name => "Brasil", :code => "BR")
  p2.save
  
  p3 = Country.new(:name => "Chile", :code => "CH")
  p3.save
  
  s1 = State.new(:name => "Buenos Aires", :code => "BA", country_id: p1.id)
  s1.save
  
  s2 = State.new(:name => "Tucuman", :code => "TU", country_id: p1.id)
  s2.save
  
  s3 = State.new(:name => "Rio de Janeiro", :code => "RJ", country_id: p2.id)
  s3.save
  
  s4 = State.new(:name => "San Pablo", :code => "SP", country_id: p2.id)
  s4.save
  
  s5 = State.new(:name => "Santiago de Chile", :code => "SC", country_id: p3.id)
  s5.save
  
  s6 = State.new(:name => "Valparaiso", :code => "VP", country_id: p3.id)
  s6.save
end