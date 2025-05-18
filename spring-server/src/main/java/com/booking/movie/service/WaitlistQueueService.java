package com.booking.movie.service;

import com.booking.movie.dto.BookingRequest;
import com.booking.movie.kafka.producer.BookingEventProducer;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class WaitlistQueueService {

    private final StringRedisTemplate redisTemplate;
    private final BookingEventProducer producer;

    public void addToWaitlist(BookingRequest request) {
        String key = "waitlist:" + request.getShowId();
        String json = new Gson().toJson(request);
        long score = System.currentTimeMillis() + 5000; // retry in 5s
        redisTemplate.opsForZSet().add(key, json, score);
    }

    @Scheduled(fixedRate = 5000)
    public void processWaitlist() {
        long now = System.currentTimeMillis();
        Set<String> entries = redisTemplate.opsForZSet().rangeByScore("waitlist:*", 0, now);

        for (String json : entries) {
            BookingRequest request = new Gson().fromJson(json, BookingRequest.class);
            String lockKey = "booking_lock:" + request.getShowId() + ":" + request.getSeatNumber();

            Boolean locked = redisTemplate.opsForValue().setIfAbsent(lockKey, "LOCKED", Duration.ofSeconds(10));
            if (Boolean.TRUE.equals(locked)) {
                producer.sendBookingEvent(request);
                redisTemplate.opsForZSet().remove("waitlist:" + request.getShowId(), json);
            }
        }
    }
}

