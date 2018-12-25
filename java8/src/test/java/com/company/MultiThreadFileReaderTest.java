package com.company;

import junit.framework.TestCase;

import java.util.ArrayList;
import java.util.List;

import static org.mockito.Mockito.spy;

public class MultiThreadFileReaderTest extends TestCase {
    protected FileReader fileReader;
    protected MultiThreadFileReader multiThreadFileReader;

    protected void setUp() {
        fileReader = spy(new FileReader());
        multiThreadFileReader = spy(new MultiThreadFileReader());

    }
    public void testFileContentsSame() {
        List<String> fileContents = new ArrayList<>();
        fileContents.add(fileReader.nioFilesReadAllBytes(fileReader.filepath));
        fileContents.add(multiThreadFileReader.simpleThreadRead());
        fileContents.add(multiThreadFileReader.executorThreadRead());

        assertEquals(fileContents.get(0), fileContents.get(1));
        assertEquals(fileContents.get(0), fileContents.get(2));
    }
}
