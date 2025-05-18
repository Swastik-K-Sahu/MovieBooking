package com.booking.movie.kafka.producer;

import com.booking.movie.dto.BookingRequest;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class BookingEventProducer {
    private final KafkaTemplate<String, BookingRequest> kafkaTemplate;

    public void sendBookingEvent(BookingRequest request) {
        kafkaTemplate.send("booking_topic", request);
    }
}
