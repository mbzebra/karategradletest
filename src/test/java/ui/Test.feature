Feature: Example Test Feature

  Scenario Outline: Go to Yahoo, perform search for news
    * configure driver = <config>
    Given driver 'http://www.yahoo.com'
    Then waitFor('{label}Search query')

    Examples:
    | config |
    | {type: 'chromedriver', executable: '/usr/local/bin/chromedriver' , webDriverSession: { desiredCapabilities: { browserName: 'chrome' , "goog:chromeOptions": { args: [ '--headless', 'window-size=1280,720' ] }  } } } |
    | {type: 'geckodriver', executable: '/usr/local/bin/geckodriver', webDriverSession: { "capabilities": { "alwaysMatch": { "moz:firefoxOptions": { args: ["-headless"] } } } } }|

