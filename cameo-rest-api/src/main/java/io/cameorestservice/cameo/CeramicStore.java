package io.cameorestservice.cameo;
import java.util.*;
import java.util.concurrent.*;
import java.util.stream.*;

public class CeramicStore {
    public static void runAndWait(List<Runnable> runnables) {
        //throw new UnsupportedOperationException("Waiting to be implemented.");
    }
        
    public static void main(String[] args) {
        List<Runnable> runnables = Arrays.asList(() -> {
            try {
                Thread.sleep(800);
                System.out.println("Slow function");
            } catch(Exception e) {}
        }, () -> {
            try {
                Thread.sleep(100);
                System.out.println("Fast function");
            } catch(Exception e) {}
        });
        
        // Expected output:
        // Fast function
        // Slow function
        // Returned from the method!
        runAndWait(runnables);
        System.out.println("Returned from the method!");
    }
}