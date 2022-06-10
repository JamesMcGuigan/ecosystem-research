extern crate yew;
extern crate yewcounter;  // import lib.js
use yewcounter::Counter;  // import ib.rs::Counter

fn main() {
    // yew::start_app::<Counter>();
    yew::Renderer::<Counter>::new().render();
}
