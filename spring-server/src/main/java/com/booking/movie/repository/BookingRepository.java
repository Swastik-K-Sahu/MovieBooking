package com.booking.movie.repository;

import com.booking.movie.entity.Booking;

public interface BookingRepository extends JpaRepository<Booking, Long> {
    boolean existsByShowIdAndSeatNumber(Long showId, String seatNumber);
}
