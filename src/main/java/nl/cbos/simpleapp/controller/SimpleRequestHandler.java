package nl.cbos.simpleapp.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.ThreadLocalRandom;

@RestController
public class SimpleRequestHandler {

    private final Logger logger = LoggerFactory.getLogger(SimpleRequestHandler.class);

    private final ThreadLocalRandom random = ThreadLocalRandom.current();

    @Value("${spring.application.name}")
    private String appName;

    @GetMapping("/")
    public String index() {
        logger.info("In index handler");
        return String.format("Greetings from Observability demo app '%s'!", appName);
    }

    @GetMapping("/random")
    public String randomBehaviour() throws InterruptedException {

        logger.info("In random behavior handler");

        Thread.sleep((long) (Math.abs((random.nextGaussian() + 1.0) * 300.0)));
        if (random.nextInt(10) < 3) {
            logger.error("Randomly failing to simulate an error");
            throw new RuntimeException("simulating an error");
        }

        return String.format("Random greetings from Observability demo app '%s'!", appName);
    }
}
