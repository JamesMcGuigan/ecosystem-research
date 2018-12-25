package com.company;

import static org.mockito.Mockito.*;
import junit.framework.*;

public class LongLoopTest extends TestCase {
    protected LongLoop looper;
    protected final long expected = 2305843005992468481L;

    protected void setUp(){
        looper = spy(new LongLoop());
    }

    public void testTimer() {
        LongLoop.timer(looper::littleLong);
        LongLoop.timer(looper::voidLittleLong);

        verify(looper, times(1)).voidLittleLong();
        verify(looper, times(2)).littleLong();
        verify(looper, times(0)).voidBigLong();
        verify(looper, times(0)).bigLong();
    }

    public void testVoidLittleLong() {
        looper.voidLittleLong();

        verify(looper, times(1)).voidLittleLong();
        verify(looper, times(1)).littleLong();
        verify(looper, times(0)).voidBigLong();
        verify(looper, times(0)).bigLong();
    }
    public void testVoidBigLong() {
        looper.voidBigLong();

        verify(looper, times(0)).voidLittleLong();
        verify(looper, times(0)).littleLong();
        verify(looper, times(1)).voidBigLong();
        verify(looper, times(1)).bigLong();
    }
    public void testLittleLong() {
        assertEquals(looper.littleLong(), expected);
    }
    public void testBigLong() {
        assertEquals((long) looper.bigLong(), expected);
    }
}
