mod print;
mod vars;
mod types;
mod tuples;
mod arrays;
mod conditionals;
mod loops;
mod functions;
mod pointers;
mod structs;
mod enums;
mod cli;
mod borrowing;
mod lifetimes;
mod threads;
mod option;

fn main() {
    print::run();
    vars::run();
    types::run();
    tuples::run();
    arrays::run();
    conditionals::run();
    loops::run();
    option::run();
    functions::run();
    pointers::run();
    structs::run();
    enums::run();
    cli::run();
    borrowing::run();
    lifetimes::run();
    threads::run();
}
