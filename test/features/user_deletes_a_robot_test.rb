require_relative '../test_helper'

class UserCanDeleteAnExistingRobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_existing_robot_is_deleted_successfully
    create_robots(1)

    visit '/robots'
    assert page.has_content? '1 name'

    click_link robots.all.last.id.to_s
    click_button 'Remove Robot (but why?)'

    refute page.has_content? '1 name'
  end
end
