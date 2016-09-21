module OurModule

  def register_user
    @driver.navigate.to 'http://demo.redmine.org'
    @driver.find_element(:class, 'register').click

    @wait.until {@driver.find_element(:id, 'user_login').displayed?}

    login = ('login' + rand(99999).to_s)

    @driver.find_element(:id, 'user_login').send_keys login
    @driver.find_element(:id, 'user_password').send_keys 'kdkdkdkqwer'
    @driver.find_element(:id, 'user_password_confirmation').send_keys 'kdkdkdkqwer'
    @driver.find_element(:id, 'user_firstname').send_keys 'kdkdkdkqwer'
    @driver.find_element(:id, 'user_lastname').send_keys 'kdkdkdkqwer'
    @driver.find_element(:id, 'user_mail').send_keys(login + '@drv.er')


    @driver.find_element(:name, 'commit').click

  end

  def create_project
    @driver.find_element(:class, 'projects').click

    @wait.until { @driver.find_element(:xpath, "//*[@id='content']/div[1]/a[1]").displayed? }
    creator = @driver.find_element(:xpath, "//*[@id='content']/div[1]/a[1]")

    @driver.action.move_to(creator).perform
    @driver.find_element(:xpath, "//*[@id='content']/div[1]/a[1]").click
    @driver.find_element(:id, "project_name").send_keys("project" + rand(999).to_s)
    @driver.find_element(:id, "project_identifier").send_keys("kiss" + rand(999).to_s)
    @driver.find_element(:name, "commit").click
  end

  def adduser

    @driver.find_element(:class, 'settings').click

    @wait.until { @driver.find_element(:id, 'tab-members').displayed? }

    @driver.find_element(:id, 'tab-members').click
    @driver.find_element(:xpath, "//div[@id='tab-content-members']/p/a").click

    @wait.until { @driver.find_element(:id, 'principal_search').displayed? }

    @driver.find_element(:id, 'principal_search').send_keys('Dave Hill')


    @wait.until { @driver.find_element(:class, "items").text == '(1-1/1)' }

    @driver.find_element(:xpath, "//div[@id='principals']/label/input").click
    @driver.find_element(:xpath, "//div[@class = 'roles-selection']/label[2]/input").click
    @driver.find_element(:id, "member-add-submit").click

  end

  def edit_users_roles
    @wait.until { @driver.find_element(:css, ".even .icon-edit").displayed? }
    @driver.find_element(:css, ".even .icon-edit").click

    @wait.until { @driver.find_element(:css, ".even input[value='3']").displayed? }

    @driver.find_element(:css, ".even input[value='3']").click
    @driver.find_element(:css, ".even input[value='5']").click
    @driver.find_element(:css, ".even .small").click
    sleep 5
    @wait.until { @driver.find_element(:css, "tr[class='even member'] span").displayed? }

  end

  def create_project_version
    @driver.find_element(:id, 'tab-versions').click

    @wait.until { @driver.find_element(:css, '#tab-content-versions .icon-add').displayed? }

    @driver.find_element(:css, '#tab-content-versions .icon-add').click
    @wait.until { @driver.find_element(:id, 'version_name').displayed? }
    @new_version_name = "version" + rand(999).to_s
    @driver.find_element(:id, 'version_name').send_keys(@new_version_name)
    @driver.find_element(:name, 'commit').click

  end

  def create_bug
    @driver.find_element(:class, 'new-issue').click
    @subject1 = 'name' + rand(9999).to_s

    @wait.until { @driver.find_element(:id, 'issue_subject').displayed? }

    @driver.find_element(:id, 'issue_subject').send_keys @subject1
    @driver.find_element(:name, 'commit').click
  end

  def create_feature
    @driver.find_element(:class, 'new-issue').click
    @wait.until { @driver.find_element(:id, "issue_tracker_id").displayed? }
    @driver.find_element(:id, "issue_tracker_id").send_keys 'Feature'

    @subject2 = 'name' + rand(9999).to_s
    @driver.find_element(:id, 'issue_subject').send_keys @subject2
    @driver.find_element(:name, 'commit').click
  end

  def create_support
    @driver.find_element(:class, 'new-issue').click
    @wait.until { @driver.find_element(:id, "issue_tracker_id").displayed? }
    @driver.find_element(:id, "issue_tracker_id").send_keys 'Support'

    @subject3 = 'name' + rand(9999).to_s
    @driver.find_element(:id, 'issue_subject').send_keys @subject3
    @driver.find_element(:name, 'commit').click
  end
end