// DOCS: https://doc.rust-lang.org/std/option/
// DOCS: https://www.ameyalokare.com/rust/2017/10/23/rust-options.html

pub fn run() {
    let a = divide(1.0, 2.0);
    let b = divide(1.0, 0.0);
    assert_eq!(a, Some(0.5));
    assert_eq!(b, None);

    match a {
        Some(x) => println!("a: {x}"),
        None => println!("a: divide by 0"),
    }
    match b {
        Some(x) => println!("b: {x}"),
        None => println!("b: divide by 0"),
    }

    let name_option: Option<&str> = Some("Alice");
    // let name_option: Option<&str> = None;       // will cause panic
    let name_unwrap: &str = name_option.unwrap();  // might panic
    println!("name_unwrap didn't panic: {}", name_unwrap);

}

fn divide(numerator: f64, denominator: f64) -> Option<f64> {
    if denominator == 0.0 {
        None
    } else {
        Some(numerator / denominator)
    }

    //// warning: floating-point types cannot be used in patterns
    // match denominator {
    //     0.0 => None,
    //     _   => Some(numerator / denominator),
    // }
}