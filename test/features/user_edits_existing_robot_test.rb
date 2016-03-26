require_relative '../test_helper'

class UserCanEditAnExistingRobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_existing_robot_is_updated_with_new_information
    create_robots(1)

    visit '/robots/' + robots.all.last.id.to_s + '/edit'

    fill_in 'robot[name]', with: 'Updated Name'
    fill_in 'robot[city]', with: 'Updated City'
    fill_in 'robot[state]', with: 'Updated State'
    fill_in 'robot[birthdate]', with: 'Updated Birthdate'
    fill_in 'robot[date_hired]', with: '10/10/11'
    fill_in 'robot[department]', with: 'Bison'
    fill_in 'robot[avatar]', with: 'https://robohash.org/123'
    click_button 'Save Changes'

    assert_equal '/robots/' + robots.all.last.id.to_s, current_path

    within 'h3' do
      assert page.has_content? 'Updated Name'
    end

    within 'p' do
      assert page.has_content? 'Updated City'
    end
  end
end
