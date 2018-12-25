package com.company;

import java.security.Provider;
import java.time.Instant;
import java.time.Duration;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.function.Supplier;

public class LongLoop {
    public LongLoop() {
    }

    public void run() {
        this.littleLong();
        this.bigLong();

        LongLoop.timer(() -> this.littleLong());
        LongLoop.timer(() -> this.bigLong());

        LongLoop.timer(() -> this.voidLittleLong());
        LongLoop.timer(() -> this.voidBigLong());

        LongLoop.timer(this::littleLong);
        LongLoop.timer(this::bigLong);

        LongLoop.timer(this::voidLittleLong);
        LongLoop.timer(this::voidBigLong);
    }

    // For: void littleLong()
    public static void timer(Runnable func) {
        Instant start = Instant.now();

        func.run();

        Instant end = Instant.now();
        System.out.println(Duration.between(start, end).toMillis() + " ms");
    }

    // For: void bigLong()
    public static void timer(Supplier<Long> func) {
        Instant start = Instant.now();

        func.get();

        Instant end = Instant.now();
        System.out.println(Duration.between(start, end).toMillis() + " ms");
    }


    public void voidLittleLong() {
        littleLong();
        return;
    }
    public long littleLong() {
        Instant start = Instant.now();

        long sum = 0L;
        for (long i = 0; i < Integer.MAX_VALUE; i++) {
            sum += i;
        }
        System.out.println("littleLong: " + sum);

        Instant end = Instant.now();
        System.out.println(Duration.between(start, end).toMillis() + " ms");

        return sum;
    }

    public void voidBigLong() {
        bigLong();
        return;
    }
    public Long bigLong() {
        Instant start = Instant.now();

        Long sum = 0L;
        for (long i = 0; i < Integer.MAX_VALUE; i++) {
            sum += i;
        }
        System.out.println("bigLong:    " + sum);

        Instant end = Instant.now();
        System.out.println(Duration.between(start, end).toMillis() + " ms");

        return sum;
    }
}
