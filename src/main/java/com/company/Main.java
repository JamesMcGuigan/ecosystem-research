package com.company;

public class Main {
    public static void main(String[] args) {
        System.out.println("public static void main(String[] args)");

        FileReader fileReader = new FileReader();
        fileReader.run();

        LongLoop looper = new LongLoop();
        looper.run();
    }
}
