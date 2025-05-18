package com.booking.movie.service;

import com.booking.movie.repository.BookingRepository;
import org.springframework.stereotype.Service;

import java.time.Duration;

@Service
@RequiredArgsConstructor
public class SeatAvailabilityService {

    private final BookingRepository bookingRepo;
    private final StringRedisTemplate redisTemplate;

    public boolean isSeatAvailable(Long showId, String seatNumber) {
        String key = "seat:" + showId + ":" + seatNumber;
        String cached = redisTemplate.opsForValue().get(key);

        if (cached != null) {
            return "available".equals(cached);
        }

        boolean taken = bookingRepo.existsByShowIdAndSeatNumber(showId, seatNumber);
        redisTemplate.opsForValue().set(key, taken ? "unavailable" : "available", Duration.ofMinutes(5));
        return !taken;
    }

    public void markSeatUnavailable(Long showId, String seatNumber) {
        String key = "seat:" + showId + ":" + seatNumber;
        redisTemplate.opsForValue().set(key, "unavailable", Duration.ofMinutes(10));
    }
}

