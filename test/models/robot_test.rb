require_relative '../test_helper'

class RobotTest < Minitest::Test
  include TestHelpers

  def test_assigns_attributes_correctly
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
end
