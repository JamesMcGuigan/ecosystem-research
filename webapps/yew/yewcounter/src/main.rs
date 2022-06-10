extern crate yew;
extern crate yewcounter;  // import lib.js
use yewcounter::Counter;  // import lib.rs::Counter

fn main() {
    yew::start_app::<Counter>();
}
