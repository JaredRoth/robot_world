require_relative '../test_helper'

class UserCanCreateANewRobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_robot_creation_with_valid_attributes
    visit '/robots/new'

    fill_in 'robot[name]', with: 'Example Name'
    fill_in 'robot[city]', with: 'Example City'
    fill_in 'robot[state]', with: 'Example State'
    fill_in 'robot[birthdate]', with: 'Example Birthdate'
    fill_in 'robot[date_hired]', with: '10/10/10'
    fill_in 'robot[department]', with: 'Bees'
    fill_in 'robot[avatar]', with: 'https://robohash.org/abcd'
    click_button 'Create This Robot'

    assert_equal '/robots', current_path

    within '.robot' do
      assert page.has_content? 'Example Name'
    end
  end
end
