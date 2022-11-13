package feature;

import com.intuit.karate.junit5.Karate;

public class KarateGradleTest {


    @Karate.Test
    Karate testUi() {
        return Karate.run("classpath:ui/Test.feature");
    }

}

