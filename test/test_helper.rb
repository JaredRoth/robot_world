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
        :birthdate => "Birthdate: #{i + 1}",
        :date_hired => "Date hired: #{i + 1}",
        :department => "#{i + 1} department",
        :avatar => "https://robohash.org/abcd#{i + 1}",
        })
    end
  end
end
