use std::mem;
use std::mem::size_of_val;

pub fn run() {
    // Arrays are stack allocated
    let numbers: [i32; 5] = [1, 2, 3, 4, 5];
    println!("numbers:        {:?}", numbers);
    println!("numbers[0]:     {:?}", numbers[0]);
    println!("&numbers:       {:?}", &numbers);
    println!("&numbers[1..3]: {:?}", &numbers[1..3]);  // create a view slice
    println!("&numbers[2..]:  {:?}", &numbers[2..]);   // create a view slice
    println!("&numbers[..2]:  {:?}", &numbers[..2]);   // create a view slice

    // Vectors are heap allocated
    let mut vector: Vec<i32> = vec![1, 2, 3, 4, 5];
    vector.push(6);
    vector.push(7);
    vector.extend_from_slice(&[8,9,10]);
    vector.pop();
    println!("vector:         {:?}", vector);
    for n in vector.iter_mut() { *n *= 2; }     // inplace .map()
    println!("vector:         {:?}", vector);
    for n in vector.iter() { println!("{}", n); }


    println!("std::mem::size_of_val(&vector): {}", std::mem::size_of_val(&vector));
    println!("std::mem::size_of_val(&numbers): {}", std::mem::size_of_val(&numbers));
    println!("use std::mem; mem::size_of_val(&numbers): {}", mem::size_of_val(&numbers));     // with use std::mem;
    println!("use std::mem::size_of_val; size_of_val(&numbers): {}", size_of_val(&numbers));  // with use std::mem::size_of_val;
    println!("use std::mem::size_of_val; size_of_val(&numbers): {}", size_of_val(&numbers));

}