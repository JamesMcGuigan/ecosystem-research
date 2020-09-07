//  YouTube Video: Intro to Rust-lang (Concurrency, Threads, Channels, Mutex and Arc)
//  https://www.youtube.com/watch?v=_4fSLuvPMf8&ab_channel=TensorProgramming

use std::thread;
use std::sync::{mpsc, Arc, Mutex};
use std::time::Duration;  // mpsc = multiple producers single consumer

pub fn run() {
    // OS Threads
    let mut threads = vec![];
    let mut results = vec![];
    for i in 0..10 as i32 {
        threads.push(thread::spawn( move || {
            println!("thread #{}", i);
            return i.pow(2);
        }))
    }
    for thread in threads {
        match thread.join() {
            Ok(result) => results.push( result ),
            Err(_) => println!("thread panicked"),
        }
    }
    println!("results: {:?}", results);


    // Channels
    let (tx, rx) = mpsc::channel();
    thread::spawn(move || {
        tx.send(42).unwrap();
    });
    println!("Channel received: {}", rx.recv().unwrap());     // rx.recv() is blocking

    let (tx, rx) = mpsc::channel();  // redeclare as borrowed by previous thread
    for i in 0..10 as i32 {
        let tx_thread = tx.clone();  // clone to prevent borrowing
        thread::spawn( move || {
            thread::sleep(Duration::from_millis((1000 * i/2) as u64));
            tx_thread.send(i).unwrap();
        });
    }
    for value in rx.iter().take(10) {
        println!("Channel received: {}", value);
    }


    // Mutex
    let shared_mem = Arc::new(Mutex::new(0));
    let mut threads = vec![];
    for _ in 0..100 {
        let shared_mem_clone = shared_mem.clone();
        threads.push( thread::spawn(move || {
            let mut number = shared_mem_clone.lock().unwrap();
            *number += 1;
        }));
    }
    for thread in threads { thread.join().unwrap(); }
    println!("Mutex loop value: {:?}", shared_mem.lock().unwrap())
}