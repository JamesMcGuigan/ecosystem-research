// DOCS: https://www.youtube.com/watch?v=s7z_sdPBwFg&t=456s&ab_channel=Bitsrfr

use std::num::ParseFloatError;

pub fn run() {
    parse_string();
    is_it_fifty_loop();
}

fn parse_string() {
    for price_string in ["420.69", "NaN", ""] {
        let _price_result: Result<f64, ParseFloatError> = price_string.trim().parse::<f64>();
        let price_float: f64 = match price_string.trim().parse::<f64>() {
            Ok(v) => v,
            Err(err) => { println!("ERROR: price_string {} | {}", price_string, err); 0.0 },
        };
        println!("price_float: {} => {}", price_string, price_float);
    }
}

fn is_it_fifty_loop() {
    for number in [42, 50] {
        match is_it_fifty(number) {
            Ok(x) => println!("is_it_fifty({}) = {}", number, x),
            Err(error) => println!("is_it_fifty({}) = {}", number, error),
        }
    }
}
fn is_it_fifty(number: i32) -> Result<i32, &'static str> {
    let error: &str = "Guess Again";
    if number == 50 {
        Ok(number)
    } else {
        Err(error)
    }
}