require "date"

class Robots
  attr_reader :database

  def initialize(database)
    @database = database
  end

  def create(robot)
    database.from(:robots).insert(robot)
  end

  def all
    database.from(:robots).map {|data| Robot.new(data)}
  end

  def find(id)
    Robot.new(database.from(:robots).where(:id => id).to_a.first)
  end

  def update(id, robot)
    database.from(:robots).where(:id => id).update({
      :name => robot[:name],
      :city => robot[:city],
      :state => robot[:state],
      :avatar => robot[:avatar],
      :birthdate => robot[:birthdate],
      :date_hired => robot[:date_hired],
      :department => robot[:department]
    })
  end

  def destroy(id)
    database.from(:robots).where(:id => id).delete
  end

  def delete_all
    database.from(:robots).delete
  end

  def avg_age
    database.from(:robots).map do |robot|
      2016 - robot[:birthdate][-4..-1].to_i
    end.reduce(:+)/all.count


  end

  def per_year(year)
    database.from(:robots).where(Sequel.like(:date_hired, "%#{year.to_s}")).to_a.count
  end

  def in_category(category)
    # database.from(:robots).group_and_count(category)

    all.each_with_object({}) do |robot, results|
      if results.key?(robot.send(category))
        results[robot.send(category)] += 1
      else
        results[robot.send(category)] = 1
      end
    end
  end
end
