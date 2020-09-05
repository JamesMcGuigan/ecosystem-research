// Source: https://stackoverflow.com/questions/21747136/how-do-i-print-the-type-of-a-variable-in-rust?answertab=votes#tab-top
fn type_of<T>(_: &T) -> String {
    return format!("{}", std::any::type_name::<T>())
}

pub fn run() {
    let name = "James";
    let mut age: f64 = 37.0;
    age = age + 1.0 / (2 as f64);
    println!("My name is {} and I am {} years old", name, age);

    const ID: i128 = 001;
    println!("ID: {} ({})", ID, type_of(&ID));

    let (thing_1, thing_2) = ("Hello", "World");
    println!("thing_1 = {} | thing_2 = {}", thing_1, thing_2);
}