module OurModule

  def register_user
    @driver.navigate.to 'http://demo.redmine.org'
    @wait.until {@driver.find_element(:class, 'register').displayed?}
    @driver.find_element(:class, 'register').click

    @wait.until {@driver.find_element(:id, 'user_login').displayed?}

    @login = ('login' + rand(99999).to_s)

    @driver.find_element(:id, 'user_login').send_keys @login
    @driver.find_element(:id, 'user_password').send_keys 'kdkdkdkqwer'
    @driver.find_element(:id, 'user_password_confirmation').send_keys 'kdkdkdkqwer'
    @driver.find_element(:id, 'user_firstname').send_keys @login
    @driver.find_element(:id, 'user_lastname').send_keys 'Hill'
    @driver.find_element(:id, 'user_mail').send_keys(@login + '@drv.er')


    @driver.find_element(:name, 'commit').click
    @login

  end

  def logout_user
    @wait.until {@driver.find_element(:class, 'logout').displayed?}
    @driver.find_element(:class, 'logout').click
  end

  def create_project
    @driver.find_element(:class, 'projects').click

    @wait.until { @driver.find_element(:xpath, "//*[@id='content']/div[1]/a[1]").displayed? }
    creator = @driver.find_element(:xpath, "//*[@id='content']/div[1]/a[1]")

    @driver.action.move_to(creator).perform
    @driver.find_element(:xpath, "//*[@id='content']/div[1]/a[1]").click
    @wait.until { @driver.find_element(:id, "project_name").displayed? }
    @driver.find_element(:id, "project_name").send_keys("project" + rand(999).to_s)
    @driver.find_element(:id, "project_identifier").send_keys("kiss" + rand(999).to_s)
    @driver.find_element(:name, "commit").click
  end

  def adduser
    @testuser = register_user
    logout_user

    register_user
    create_project
    @driver.find_element(:id, 'tab-members').click
    @wait.until { @driver.find_element(:css, "#tab-content-members .icon-add").displayed? }
    @driver.find_element(:css, "#tab-content-members .icon-add").click
    @wait.until { @driver.find_element(:id, 'principal_search').displayed? }
    @driver.find_element(:id, 'principal_search').send_keys @testuser
    @wait.until { @driver.find_element(:class, "items").text == '(1-1/1)' }
    @driver.find_element(:css, "#principals>label>input").click
    @driver.find_element(:css, ".roles-selection>label>input[value='4']").click
    @driver.find_element(:id, 'member-add-submit').click
    @wait.until { @driver.find_element(:css, "tbody>.even .user").displayed? }

  end

  def edit_users_roles


    var = @driver.find_elements(css:".members .name").select {|el| el.text.include? @testuser}.first
    index = @driver.find_elements(css:".members .name").index(var)

    button_edit = @driver.find_elements(class:"icon-edit")[index]

    button_edit.click


    button_input3 = @driver.find_elements(:css, ".roles input[value='3']")[index]
    button_input3.click

    button_input5 = @driver.find_elements(:css, ".roles input[value='5']")[index]
    button_input5.click

    button_save = @driver.find_elements(:css, ".roles .small")[index]
    button_save.click


   #  .roles .small

   # @driver.find_element(:css, ".even .small").click

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