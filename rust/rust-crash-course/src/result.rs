// DOCS: https://www.youtube.com/watch?v=s7z_sdPBwFg&t=456s&ab_channel=Bitsrfr

use std::{fs, io};
use std::fs::File;
use std::io::{ErrorKind, Read, Write};
use std::net::IpAddr;
use std::num::ParseFloatError;
const PATH: &str = "nonexistent.txt";

pub fn run() {
    parse_ip();
    parse_string();
    is_it_fifty_loop();
    open_file();
    read_file().expect("ERROR: read_file()");
    delete_file();
}

fn parse_ip() {
    let ip_address: IpAddr = "127.0.0.1".parse().unwrap();
    println!("ip_address: {}", ip_address);
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

fn open_file() {
    let file_result: io::Result<File> = File::open(PATH);
    let mut file: File = match file_result {
        Ok(f) => f,
        Err(error) => match error.kind() {
            ErrorKind::NotFound => match File::create(PATH) {
                Ok(fc) => fc,
                Err(error) => panic!("ERROR: File::create({}) = {}", PATH, error)
            },
            unknown_error_var => {
                panic!("ERROR: error.kind({}) = {}", PATH, unknown_error_var)
            }
        }
    };
    match file.write("Hello World!".as_bytes()) {
        Ok(_size) => {},
        Err(error) => panic!("ERROR: file.write({}) = {}", PATH, error),
    }
}
fn read_file() -> Result<String, io::Error> {
    let mut buffer: String = String::new();
    File::open(PATH)?.read_to_string(&mut buffer)?;
    println!("read_file({}) = {}", PATH, buffer);
    Ok(buffer)
}
fn delete_file() {
    fs::remove_file(PATH)
        .expect(format!("ERROR: fs::remove_file({PATH})").as_str());
}