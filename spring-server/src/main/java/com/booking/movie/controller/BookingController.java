package com.booking.movie.controller;

import com.booking.movie.dto.BookingRequest;
import com.booking.movie.kafka.producer.BookingEventProducer;
import com.booking.movie.util.RedisLockUtil;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/bookings")
@RequiredArgsConstructor
public class BookingController {

    private final RedisLockUtil lockUtil;
    private final BookingEventProducer producer;

    @PostMapping
    public ResponseEntity<String> bookSeat(@RequestBody BookingRequest request) {
        String lockKey = "booking_lock:" + request.getShowId() + ":" + request.getSeatNumber();
        boolean acquired = lockUtil.tryLock(lockKey, 10);
        if (!acquired) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Seat temporarily locked. Try again.");
        }

        producer.sendBookingEvent(request); // async
        return ResponseEntity.ok("Booking request accepted");
    }
}

