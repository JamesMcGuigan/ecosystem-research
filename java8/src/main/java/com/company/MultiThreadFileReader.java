package com.company;

import javax.swing.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class MultiThreadFileReader {
    protected static volatile int lineNumber = 0;
    protected static final int maxThreads = 100;
    protected static final String filepath = "src/main/resources/Frank Herbert - Dune.txt";
    protected List<Thread> threads;
    protected BufferedReader reader;
    protected StringBuffer   content;
    protected ExecutorService executorService;

    public static void main(String[] args) {
        MultiThreadFileReader multiThreadFileReader = new MultiThreadFileReader();
        //multiThreadFileReader.simpleThreadRead();
        multiThreadFileReader.executorThreadRead();
    }

    public MultiThreadFileReader() {
    }
    public String simpleThreadRead() {
        try {
            reader  = Files.newBufferedReader(Paths.get(MultiThreadFileReader.filepath), StandardCharsets.UTF_8);
        } catch (IOException e) {
            e.printStackTrace();
        }
        content = new StringBuffer();
        threads = new ArrayList<>();

        for( int i = 0; i < maxThreads; i++ ) {
            Thread thread = new ThreadReader(i, reader, content);
            threads.add(thread);
        }
        for( Thread thread : threads ) {
            thread.start();
        }
        for (Thread thread : threads) {
            try {
                thread.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        return content.toString();
    }

    public String executorThreadRead() {
        try {
            reader  = Files.newBufferedReader(Paths.get(MultiThreadFileReader.filepath), StandardCharsets.UTF_8);
        } catch (IOException e) {
            e.printStackTrace();
        }
        content = new StringBuffer();

        executorService = Executors.newFixedThreadPool(maxThreads);
        for( int i = 0; i < maxThreads; i++ ) {
            executorService.execute(new ThreadReader(i, reader, content));
        }
        executorService.shutdown();
        try {
            executorService.awaitTermination(Long.MAX_VALUE, TimeUnit.NANOSECONDS);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return content.toString();
    }

    private class ThreadReader extends Thread {
        private String line;
        public final int threadNumber;
        public BufferedReader reader;
        public StringBuffer   content;

        public ThreadReader(int threadNumber, BufferedReader reader, StringBuffer content) {
            this.threadNumber = threadNumber;
            this.reader = reader;
            this.content = content;
        }

        @Override
        public void run() {
            try {
                while(true) {
                    synchronized(reader) {
                        lineNumber++;
                        String line = line = reader.readLine();
                        if( line == null ) {
                            break;
                        }
                        System.out.format("(thread %02d) -> %d: %s\n", threadNumber, lineNumber, line);

                        content.append(line+"\n");
                    }
                    Thread.currentThread().sleep(10);
                }
            } catch (IOException | InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
