package com.company;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collector;
import java.util.stream.Collectors;

/**
 * TODO:
 * - Read text file (both whole and as file buffer)
 * - TreeMap data structure
 * - Threads and ThreadPool
 */
public class FileReader {
    protected static String filepath = "src/main/resources/Frank Herbert - Dune.txt";

    /**
     * main() for debugging and testing purposes
     * @param args
     */
    public static void main(String[] args) {
        FileReader fileReader = new FileReader();
        LongLoop.timer(() -> fileReader.nioTreeMap(FileReader.filepath));
    }

    public FileReader() {
    }

    public void run() {
        LongLoop.timer(() -> ioFileInputStream(FileReader.filepath));
        LongLoop.timer(() -> nioBufferedReader(FileReader.filepath));
        LongLoop.timer(() -> nioFilesReadAllBytes(FileReader.filepath));
        LongLoop.timer(() -> nioTreeMap(FileReader.filepath));

        LongLoop.timer(() -> ioFileInputStream(FileReader.filepath));
        LongLoop.timer(() -> nioBufferedReader(FileReader.filepath));
        LongLoop.timer(() -> nioFilesReadAllBytes(FileReader.filepath));
        LongLoop.timer(() -> nioTreeMap(FileReader.filepath));
    }

    /**
     * Reads file one byte at a time, using fileInputStream.read(), storing data in a char[] array
     * 51ms - slowest method
     * @param filepath
     * @return
     */
    public String ioFileInputStream(String filepath) {
        File file = new File(filepath);
        int fileLength = (int) file.length();
        int charCount  = 0;
        char[] charArray = new char[fileLength];

        try {
            // NOTE: new FileInputStream(file) alone fails testFileContentsSame() test due to UTF-8 char
            BufferedReader fileInputStream = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF8"));
            int fileByte;
            while( (fileByte = fileInputStream.read()) != -1 ) {
                charArray[charCount] = (char) fileByte;
                charCount++;
            }
        } catch (FileNotFoundException exception) {
            System.out.println("ioFileInputStream() - FileNotFoundException: " + exception.toString());
        } catch (IOException exception) {
            System.out.println("ioFileInputStream() - IOException: " + exception.toString());
        }

        System.out.println("ioFileInputStream() - charCount: " + charCount);
        System.out.println("ioFileInputStream() - fileLength: " + fileLength);

        assert fileLength >= charCount;                 // fileLength == 1187237; charCount == 1187231; due to UTF8 chars
        return String.valueOf(charArray, 0, charCount); // testFileContentsSame() fails if null chars[] at end of array are not stripped
    }

    /**
     * Reads file one line at a time using Files.newBufferedReader() and StringBuilder()
     * 26ms - use of StringBuilder actually makes this method slower than nioFilesReadAllBytes()
     * @param filepath
     * @return
     */
    public String nioBufferedReader(String filepath) {
        StringBuilder lines = new StringBuilder();
        int lineCount = 0;
        try {
            BufferedReader reader = Files.newBufferedReader(Paths.get(filepath), StandardCharsets.UTF_8);
            String line;
            while( (line = reader.readLine()) != null ) {
                //System.out.println(line);
                lines.append(line+"\n");
                lineCount++;
            }
        } catch (IOException exception) {
            System.out.println("nioBufferedReader() - IOException: " + exception.toString());
        }

        System.out.println("nioBufferedReader() - lineCount: " + lineCount);

        return lines.toString();
    }

    /**
     * Reads entire file in one go
     * 5ms - strangely enough, this is actually the fastest method for just extracting content
     * @param filepath
     * @return
     */
    public String nioFilesReadAllBytes(String filepath) {
        String content = "";
        try {
            content = new String(Files.readAllBytes(Paths.get(filepath)), StandardCharsets.UTF_8);
        } catch (IOException exception) {
            System.out.println("nioFilesReadAllBytes() - IOException: " + exception.toString());
        }

        System.out.println("nioFilesReadAllBytes() - content.length(): " + content.length());
        return content;
    }

    /**
     * Returns file contents sorted by reverse line length, using TreeMap and Java 8 Streams
     * @param filepath
     * @return
     */
    public String nioTreeMap(String filepath) {
        try {
            List<String> lines = Files.readAllLines(Paths.get(filepath), StandardCharsets.UTF_8);
            SortedMap<Integer, List<String>> linesByLength = new TreeMap<>((i1, i2) -> i2.compareTo(i1)); // shortest lines first

            for( String line : lines ) {
                int key = line.length();
                List<String> value = linesByLength.getOrDefault(key, new ArrayList<String>());
                value.add(line);
                linesByLength.put(key, value);
            }

            Integer averageLineLength = linesByLength
                    .entrySet()
                    .stream()
                    .map( (entry) -> (Integer) (entry.getKey() * entry.getValue().size()) )
                    .collect(Collectors.summingInt(Integer::intValue))
                    / lines.size()
            ;

            String content = linesByLength
                    .values()
                    .stream()
                    .flatMap(List::stream)
                    //.collect(Collectors.toList());   // flatten to List<String>
                    .collect(Collectors.joining("\n")) // flatten to String.join()
            ;

            System.out.println("nioTreeMap() - totalLines: " + lines.size());
            System.out.println("nioTreeMap() - averageLineLength: " + averageLineLength);
            System.out.println("nioTreeMap() - longestLineLength: " + linesByLength.firstKey());

            return content;

        } catch (IOException exception) {
            System.out.println("nioTreeMap() - IOException: " + exception.toString());
        }

        return "";
    }
}
