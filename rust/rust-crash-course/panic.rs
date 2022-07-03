// DOCS: https://www.youtube.com/watch?v=wM6o70NAWUI&ab_channel=Let%27sGetRusty
// $ rustc panic.rs; RUST_BACKTRACE=1 ./panic
// thread 'main' panicked at 'Hello World!', panic.rs:23:5
// stack backtrace:
// 0: std::panicking::begin_panic
// 1: panic::c
// 2: panic::b
// 3: panic::a
// 4: panic::main
// 5: core::ops::function::FnOnce::call_once
// note: Some details are omitted, run with `RUST_BACKTRACE=full` for a verbose backtrace.

fn main() {
    a();
}
fn a() {
    b();
}
fn b() {
    c();
}
fn c() {
    panic!("Hello World!");
}
