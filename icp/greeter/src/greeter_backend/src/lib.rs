#![feature(local_key_cell_methods)]

use std::cell::RefCell;

thread_local! {
    static COUNT: RefCell<u64> = RefCell::new(0);
}

#[ic_cdk_macros::update]
fn greet(name: String) -> String {
    COUNT.with(|count| *count.borrow_mut() += 1);
    format!("Hello, {}!", name)
}

#[ic_cdk_macros::query]
fn get_count() -> u64 {
    COUNT.with(|count| count.borrow().clone())
}
