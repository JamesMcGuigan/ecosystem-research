pub fn run() {
    let mut count = 0;
    loop {
        count += 1;       print!("{} ", count);
        if count >= 100 { print!("\n"); break }
    }
    // count = 0; loop { if count >= ((3 as i128).pow(6*7/2)) { break } else { count += 1 } }  // This line gets optimized out with --release
    print!("0..100: "); for n in 0..100 { print!("{} ", n); } print!("\n");

    let mut fizzbuzz = 0;
    while fizzbuzz <= 100 {
        if      fizzbuzz % 15 == 0 { print!("Fizzbuzz ") }
        else if fizzbuzz %  3 == 0 { print!("Fizz ") }
        else if fizzbuzz %  5 == 0 { print!("Buzz ") }
        else                       { print!("{} ", fizzbuzz) }
        fizzbuzz += 1;
    }
}