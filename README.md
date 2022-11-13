# Road to Continuous Build, Testing and Integration

## Karate - Gradle - Jenkins

| Tools                                                                   | Description |
|-------------------------------------------------------------------------| ----------- |
| [Karate](https://github.com/karatelabs/karate)  |Quality Automation System |
| [Gradle](https://gradle.org/)                                | Build Tool  |
| [Jenkins](https://www.jenkins.io/)           |Continuous Integration System |


### Build Gradle

```groovy
buildscript {

    ext {
        karateVersion = '1.2.0'
    }

    repositories {
        mavenCentral()
    }
    dependencies {
        classpath("com.intuit.karate:karate-junit5:1.2.0")
        classpath("com.intuit.karate:karate-core:1.2.0")
        classpath("com.intuit.karate:karate-apache:0.9.6")
        classpath("org.junit.jupiter:junit-jupiter-api:5.9.0")
    }
}

plugins {
    id 'java'
}
repositories {
    mavenCentral()
}
sourceSets {
    test {
        resources {
            srcDir file('src/test/java')
            exclude '**/*.java'
        }
    }
}
dependencies {
    implementation 'com.intuit.karate:karate-junit5:1.2.0'
    implementation 'com.intuit.karate:karate-mock-http:0.4.3.1'
    implementation 'com.intuit.karate:karate-core:1.2.0'
    implementation 'org.junit.jupiter:junit-jupiter-api:5.7.2'
    implementation 'org.junit.jupiter:junit-jupiter-engine:5.7.2'
}
test {
    useJUnitPlatform()
    systemProperty "karate.options", System.properties.getProperty("karate.options")
    systemProperty "karate.env", System.properties.getProperty("karate.env")
    outputs.upToDateWhen { false }
}
task karateDebug(type: JavaExec) {
    classpath = sourceSets.test.runtimeClasspath
    main = 'com.intuit.karate.Main'
}
```


### Karate Feature Description

```gherkin
Feature: Example Test Feature

  Scenario Outline: Go to Yahoo, perform search for news
    * configure driver = <config>
    Given driver 'http://www.yahoo.com'
    Then waitFor('{label}Search query')

    Examples:
    | config |
    | {type: 'chromedriver', executable: '/usr/local/bin/chromedriver' , webDriverSession: { desiredCapabilities: { browserName: 'chrome' , "goog:chromeOptions": { args: [ '--headless', 'window-size=1280,720' ] }  } } } |
    | {type: 'geckodriver', executable: '/usr/local/bin/geckodriver', webDriverSession: { "capabilities": { "alwaysMatch": { "moz:firefoxOptions": { args: ["-headless"] } } } } }|

```

### Jenkins Configuration Steps

![img_2.png](images/img_2.png)

![img_1.png](images/img_1.png)

![img.png](images/img.png)


### Successful Jenkins Build

```html
Starting a Gradle Daemon, 1 incompatible Daemon could not be reused, use --status for details
> Task :compileJava NO-SOURCE
> Task :processResources NO-SOURCE
> Task :classes UP-TO-DATE
> Task :jar
> Task :assemble
> Task :compileTestJava
> Task :processTestResources
> Task :testClasses
> Task :test
> Task :check
> Task :build

Deprecated Gradle features were used in this build, making it incompatible with Gradle 8.0.

You can use '--warning-mode all' to show the individual deprecation warnings and determine if they come from your own scripts or plugins.

See https://docs.gradle.org/7.6-rc-3/userguide/command_line_interface.html#sec:command_line_warnings

BUILD SUCCESSFUL in 32s
4 actionable tasks: 4 executed
Build step 'Invoke Gradle script' changed build result to SUCCESS
Finished: SUCCESS
```

### Karate Test Reports in Jenkins
You can find the test reports in Jenkins by navigating inside the project workspace

![img_3.png](images/img_3.png)

Go to Test Reports folder

![img_4.png](images/img_4.png)

Click on index.html to view the report

![img_5.png](images/img_5.png)