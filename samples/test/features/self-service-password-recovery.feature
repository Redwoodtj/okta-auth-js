Feature: Direct Auth Password Recovery

Background:
  Given an App that assigned to a test group
    And a Policy that defines "Authentication"
    And with a Policy Rule that defines "Password as the only factor"
    And a user named "Mary"
    And she has an account with "active" state in the org

  Scenario: Mary resets her password
    When she clicks the "login" button
    Then she is redirected to the "Login" page
    When she clicks the "Forgot Password" link
    Then she is redirected to the "Self Service Password Reset" page
    When she inputs her correct Email
    And she submits the form
    # ENG_REMEMBER_LAST_USED_FACTOR_OIE feature avoids these steps
    # Then she is redirected to the "Select Authenticator" page
    # And password authenticator is not in options
    # When she selects the "Email" factor
    # And she submits the form
    Then she sees a page to challenge her email authenticator
    When she inputs the correct code from her "Email"
    And she submits the form
    Then she is redirected to the "Reset Password" page
    When she fills a password that fits within the password policy
    And she confirms that password
    And she submits the form
    Then she is redirected to the "Root" page

  Scenario: Mary tries to reset a password with the wrong email
    Given the app is assigned to "Everyone" group
    When she clicks the "login" button
    Then she is redirected to the "Login" page
    When she clicks the "Forgot Password" link
    Then she is redirected to the "Self Service Password Reset" page
    When she inputs an Email that doesn't exist
    And she submits the form
    Then she should see the message "There is no account with the Username test_with_really_invalid_email@invalidemail.com."
