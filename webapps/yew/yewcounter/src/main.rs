extern crate yew;
extern crate yewcounter;  // import lib.js
use yewcounter::Counter;  // Import from lib.rs

fn main() {
    yew::start_app::<Counter>();
}
