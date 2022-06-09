extern crate yew;
extern crate yewcounter;  // import lib.js

use yew::prelude::*;
use yew::services::console::ConsoleService;  // using v0.4, available in v0.18, removed in v0.19
// use gloo_console;                         // TODO replace ConsoleService - is module not struct
use yewcounter::Model;

pub struct Context {
    console: ConsoleService,
}
impl AsMut<ConsoleService> for Context {
    fn as_mut(&mut self) -> &mut ConsoleService {
        &mut self.console
    }
}

fn main() {
    yew::initialize();
    let context = Context {
        console: ConsoleService {},
    };
    let app: App<_, Model> = App::new(context);
    app.mount_as_body();
    yew::run_loop();
}
