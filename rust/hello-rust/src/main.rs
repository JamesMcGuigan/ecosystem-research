//// Simple Hello World
//fn main() {
//    println!("Hello, world!");
//}

mod date;

//// A Small Rust application
// DOCS: https://www.rust-lang.org/learn/get-started
use ferris_says::say; // from the previous step
use std::io::{stdout, BufWriter};

fn main() {
    let stdout = stdout();
    let out = b"Hello fellow Rustaceans!";
    let width = 24;

    let mut writer = BufWriter::new(stdout.lock());
    say(out, width, &mut writer).unwrap();

    date::iso2timestamp()
}
