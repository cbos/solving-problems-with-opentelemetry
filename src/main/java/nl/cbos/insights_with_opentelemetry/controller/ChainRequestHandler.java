package nl.cbos.insights_with_opentelemetry.controller;

import java.io.IOException;
import java.net.URI;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

@RestController
public class ChainRequestHandler {

    private final Logger logger = LoggerFactory.getLogger(ChainRequestHandler.class);

    @Value("${downstream.hostname}")
    String hostname;

    private static final HttpClient httpClient = HttpClient.newBuilder()
            .version(HttpClient.Version.HTTP_1_1)
            .connectTimeout(Duration.ofSeconds(10))
            .build();


    @GetMapping("/chain")
    public String chainRequest() throws InterruptedException, IOException {

        logger.info("In chain request handler");

        return callDownstream();
    }

    private synchronized String callDownstream() throws IOException, InterruptedException {
        HttpRequest request = HttpRequest.newBuilder()
                .GET()
                .uri(URI.create(String.format("http://%s:8080/random", hostname)))
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        if (response.statusCode() == 200) {
            return response.body();
        } else {
            logger.error( String.format("Error from external call with status %s: %s", response.statusCode(), response.body()));
            throw new RuntimeException("Something went wrong");
        }
    }
}
