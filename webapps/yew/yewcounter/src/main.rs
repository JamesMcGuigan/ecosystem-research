extern crate yew;
extern crate yewcounter;  // import lib.rs

mod counter;
use crate::counter::Counter;

fn main() {
    yew::Renderer::<Counter>::new().render();
}
