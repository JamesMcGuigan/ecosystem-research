pub fn run() {
    greet("Hello", "World");
    println!("1 + 2 == {}", add(1,2));

    let n3 = 0.5;
    let half_product = |n1: i32, n2: i32| (n1 * n2) as f64 * n3;  // inline closure
    println!("2 * 3 / 2 == {}", half_product(2,3));
}

fn greet(greet: &str, name: &str) {
    println!("{} {}!", greet, name);
}

fn add( n1: i32, n2: i32 ) -> i32 { return n1 + n2; }