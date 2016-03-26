require 'sequel'

environments = ["test", "development"]

environments.each do |env|
  database = Sequel.sqlite("db/robots_#{env}.sqlite")
  database.create_table :robots do
    primary_key :id
    String      :name
    String      :city
    String      :state
    String      :birthdate
    String      :date_hired
    String      :department
    String      :avatar
  end
end
