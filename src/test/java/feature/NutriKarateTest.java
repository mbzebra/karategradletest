package feature;

import com.intuit.karate.junit5.Karate;

public class NutriKarateTest {


    @Karate.Test
    Karate testUi() {
        return Karate.run("classpath:ui/Test.feature");
    }

}

