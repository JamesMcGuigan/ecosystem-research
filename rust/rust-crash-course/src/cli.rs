use std::env;

pub fn run() {
    let argv: Vec<String> = env::args().collect();
    println!("argv: {:?}", argv);
    for arg in argv {
        println!("{} ", arg);
    }
}