require 'test/unit'
require 'selenium-webdriver'
require_relative 'our_module'
include Test::Unit::Assertions

class TestRegistration < Test::Unit::TestCase
  include OurModule

  def setup
    @driver = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_positive
    register_user

    expected_text = 'Your account has been activated. You can now log in.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)
  end

  def test_log_out
    register_user
    logout_user


    @wait = Selenium::WebDriver::Wait.new(:timeout => 5)

    login_button = @driver.find_element(:class, 'login')
    assert(login_button.displayed?)
  end


  def test_changepassword
    register_user

    @driver.find_element(:class, 'my-account').click

    @wait.until { @driver.find_element(:css, ".icon + *").displayed? }
    @driver.find_element(:css, ".icon + *").click

    @wait.until { @driver.find_element(:id, "password").displayed? }

    @driver.find_element(:id, "password").send_keys("kdkdkdkqwer")
    @driver.find_element(:id, "new_password").send_keys("changeme")
    @driver.find_element(:id, "new_password_confirmation").send_keys("changeme")
    @driver.find_element(:name, "commit").click

    expected_text_passwordchange = 'Password was successfully updated.'
    actual_text_passwordchange = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text_passwordchange, actual_text_passwordchange)

  end

  def test_createproject
    register_user
    create_project

    expected_text_project = 'Successful creation.'
    actual_text_project = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text_project, actual_text_project)

  end

  def test_adduser
    adduser

    expected_role = "Developer"
    actual_role = @driver.find_element(:css, ".even span").text
    assert_equal(expected_role, actual_role)

    expected_name = @login.to_s + ' Hill'
    actual_name = @driver.find_element(:css, ".odd .name .user").text
    assert_equal(expected_name, actual_name)

  end

  def test_edit_users_roles
    adduser
    edit_users_roles

    expected_roles = "Manager, Developer, Reporter"
    actual_roles   = @driver.find_element(:css, ".even span").text
    assert_equal(expected_roles, actual_roles)

  end

  def test_create_project_version
    register_user
    create_project
    create_project_version

    expected_text = 'Successful creation.'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_text, actual_text)

    expected_name = @new_version_name
    actual_name = @driver.find_element(:css, "#tab-content-versions .name>a").text
    assert_equal(expected_name, actual_name)
  end

  def test_all_issues
    register_user
    create_project
    create_bug

    expected_text = 'Issue #'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert(actual_text.include?(expected_text))

    create_feature
    expected_text = 'Issue #'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert(actual_text.include?(expected_text))

    create_support
    expected_text = 'Issue #'
    actual_text = @driver.find_element(:id, 'flash_notice').text
    assert(actual_text.include?(expected_text))

  end

  def test_create_bug
    register_user
    create_project
    create_bug
    expected_text = @subject1.to_s
    actual_text = @driver.find_element(:css, ".subject").text
    assert_equal(actual_text, expected_text)

  end

  def test_create_feature
    register_user
    create_project
    create_feature
    expected_text = @subject2.to_s
    actual_text = @driver.find_element(:css, ".subject").text
    assert_equal(actual_text, expected_text)

  end

  def test_create_support
    register_user
    create_project
    create_support
    expected_text = @subject3.to_s
    actual_text = @driver.find_element(:css, ".subject").text
    assert_equal(actual_text, expected_text)

  end

  def teardown
    @driver.quit
  end
end