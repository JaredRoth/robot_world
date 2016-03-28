ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require "minitest/autorun"
require "minitest/pride"
require "capybara/dsl"
require "tilt/erb"

Capybara.app = RobotWorld

module TestHelpers
  def setup
    robots.delete_all
    super
  end

  def teardown
    robots.delete_all
    super
  end

  def robots
    database = Sequel.sqlite('db/robots_test.sqlite')
    @robots ||= Robots.new(database)
  end

  def create_robots(num = 2)
    num.times do |i|
      robots.create({
        :name => "#{i + 1} name",
        :city => "#{i + 1} city",
        :state => "#{i + 1} state",
        :birthdate => "2/10/#{2000 + i}",
        :date_hired => "1/1/#{2006 + i}",
        :department => "#{i + 1} department",
        :avatar => "https://robohash.org/abcd#{i + 1}",
        })
    end
  end

  def create_analysis_robots
    robots.create({
      :name => "First name",
      :city => "First city",
      :state => "First state",
      :birthdate => "2/10/2000",
      :date_hired => "1/1/2004",
      :department => "First department",
      :avatar => "https://robohash.org/abcd",
      })

    robots.create({
      :name => "Second name",
      :city => "Second city",
      :state => "First state",
      :birthdate => "2/10/2000",
      :date_hired => "1/1/2005",
      :department => "First department",
      :avatar => "https://robohash.org/abcd",
      })

    robots.create({
      :name => "Third name",
      :city => "Second city",
      :state => "First state",
      :birthdate => "2/10/2002",
      :date_hired => "1/1/2006",
      :department => "Second department",
      :avatar => "https://robohash.org/abcd",
      })

    robots.create({
      :name => "Fourth name",
      :city => "Second city",
      :state => "Second state",
      :birthdate => "2/10/2004",
      :date_hired => "1/1/2007",
      :department => "Second department",
      :avatar => "https://robohash.org/abcd",
      })

    robots.create({
      :name => "Fifth name",
      :city => "First city",
      :state => "Third state",
      :birthdate => "2/10/2004",
      :date_hired => "1/1/2007",
      :department => "Third department",
      :avatar => "https://robohash.org/abcd",
      })
  end
end
