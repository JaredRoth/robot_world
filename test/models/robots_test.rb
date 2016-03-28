require_relative '../test_helper'

class RobotsTest < Minitest::Test
  include TestHelpers
  def test_it_creates_a_robot
    create_robots(1)

    robot = robots.all.last
    assert_equal "1 name", robot.name
    assert_equal "1 city", robot.city
    assert_equal "1 state", robot.state
    assert_equal "2/10/2000", robot.birthdate
    assert_equal "1/1/2006", robot.date_hired
    assert_equal "1 department", robot.department
    assert_equal "https://robohash.org/abcd1", robot.avatar
  end

  def test_it_returns_all_robots
    create_robots(3)

    all = robots.all

    assert_equal Array, all.class
    assert_equal 3, all.length
    assert_equal Robot, all[0].class
    assert_equal "1 name", all.first.name
    assert_equal "3 name", all.last.name
  end

  def test_it_finds_a_specific_robot
    create_robots(2)

    all = robots.all

    robot = robots.find(all.first.id)
    assert_equal "1 name", robot.name
    assert_equal "1 city", robot.city
    assert_equal "2/10/2000", robot.birthdate
    assert_equal "1/1/2006", robot.date_hired
    assert_equal "1 department", robot.department
    assert_equal "https://robohash.org/abcd1", robot.avatar

    robot = robots.find(all.last.id)
    assert_equal "2 name", robot.name
    assert_equal "2 city", robot.city
    assert_equal "2/10/2001", robot.birthdate
    assert_equal "1/1/2007", robot.date_hired
    assert_equal "2 department", robot.department
    assert_equal "https://robohash.org/abcd2", robot.avatar
  end

  def test_it_updates_a_robot
    create_robots(1)

    before = robots.all.last
    assert_equal "1 name", before.name
    assert_equal "1 city", before.city
    assert_equal "2/10/2000", before.birthdate
    assert_equal "1/1/2006", before.date_hired
    assert_equal "1 department", before.department
    assert_equal "https://robohash.org/abcd1", before.avatar

    changes = { :name => "a changed name",
                :city => "a changed city",
                :birthdate => "a changed birthdate",
                :date_hired => "a changed date hired",
                :department => "a changed department",
                :avatar => "https://robohash.org/12345"
              }
    robots.update(before.id, changes)

    after = robots.all.last
    assert_equal "a changed name", after.name
    assert_equal "a changed city", after.city
    assert_equal "a changed birthdate", after.birthdate
    assert_equal "a changed date hired", after.date_hired
    assert_equal "a changed department", after.department
    assert_equal "https://robohash.org/12345", after.avatar
  end

  def test_it_destroys_a_robot
    create_robots(3)

    all = robots.all
    assert_equal 3, all.length
    assert all.any?{|robot| robot.name == "3 name"}
    assert all.any?{|robot| robot.name == "2 name"}
    assert all.any?{|robot| robot.name == "1 name"}

    robots.destroy(all[-2].id)
    all = robots.all
    assert_equal 2, all.length
    assert all.any?{|robot| robot.name == "3 name"}
    refute all.any?{|robot| robot.name == "2 name"}
  end

  def test_it_calculates_average_age_correctly
    create_analysis_robots

    assert_equal 14.0, robots.avg_age
  end

  def test_it_counts_year
    create_analysis_robots

    assert_equal 1, robots.per_year("2006")
    assert_equal 2, robots.per_year("2007")
  end

  def test_it_groups_robots_correctly
    create_analysis_robots

    city  = robots.in_category("city")
    state = robots.in_category("state")
    dept  = robots.in_category("department")

    assert_equal 2, city["First city"]
    assert_equal 3, city["Second city"]

    assert_equal 3, state["First state"]
    assert_equal 1, state["Third state"]

    assert_equal 2, dept["First department"]
    assert_equal 1, dept["Third department"]
  end
end
