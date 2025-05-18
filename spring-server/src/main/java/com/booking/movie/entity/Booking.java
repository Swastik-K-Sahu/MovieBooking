package com.booking.movie.entity;

import java.time.LocalDateTime;

@Entity
public class Booking {
    @Id @GeneratedValue
    private Long id;

    private String userId;
    private Long showId;
    private String seatNumber;

    @Enumerated(EnumType.STRING)
    private BookingStatus status;

    private LocalDateTime createdAt;
}

