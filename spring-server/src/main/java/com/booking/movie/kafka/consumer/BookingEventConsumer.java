package com.booking.movie.kafka.consumer;

import com.booking.movie.dto.BookingRequest;
import com.booking.movie.entity.Booking;
import com.booking.movie.entity.BookingStatus;
import com.booking.movie.repository.BookingRepository;
import com.booking.movie.service.SeatAvailabilityService;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
@RequiredArgsConstructor
public class BookingEventConsumer {

    private final BookingRepository repository;
    private final SeatAvailabilityService seatAvailabilityService;
    public BookingEventConsumer(BookingRepository repository) {
        this.repository = repository;
    }

    @KafkaListener(topics = "booking_topic", groupId = "booking_group")
    public void handleBooking(BookingRequest request) {
        if (bookingRepository.existsByShowIdAndSeatNumber(request.getShowId(), request.getSeatNumber())) {
            return; // already booked
        }

        Booking booking = new Booking();
        booking.setUserId(request.getUserId());
        booking.setShowId(request.getShowId());
        booking.setSeatNumber(request.getSeatNumber());
        booking.setStatus(BookingStatus.CONFIRMED);
        booking.setCreatedAt(LocalDateTime.now());

        repository.save(booking);
        seatAvailabilityService.markSeatUnavailable(request.getShowId(), request.getSeatNumber());
    }

}

