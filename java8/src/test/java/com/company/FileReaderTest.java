package com.company;

import junit.framework.TestCase;

import java.util.ArrayList;
import java.util.List;

import static org.mockito.Mockito.spy;

public class FileReaderTest extends TestCase {
    protected FileReader fileReader;

    protected void setUp(){
        fileReader = spy(new FileReader());
    }
    public void testFileContentsSame() {
        List<String> fileContents = new ArrayList<>();
        fileContents.add(fileReader.ioFileInputStream(fileReader.filepath));
        fileContents.add(fileReader.nioFilesReadAllBytes(fileReader.filepath));
        fileContents.add(fileReader.nioBufferedReader(fileReader.filepath));

        assertEquals(fileContents.get(0), fileContents.get(0));
        assertEquals(fileContents.get(1), fileContents.get(0));
        assertEquals(fileContents.get(2), fileContents.get(1));
    }
}
