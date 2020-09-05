#[derive(Copy, Clone)]
enum Movement { Up, Down, Left, Right }

fn print_direction(m: Movement) {
    match m {
        Movement::Up    => println!("^"),
        Movement::Down  => println!("v"),
        Movement::Left  => println!(">"),
        Movement::Right => println!("<"),
    }
}

pub fn run() {
    for m in [ Movement::Up, Movement::Down, Movement::Left, Movement::Right ].iter()  {
        print_direction(*m);  // BUGFIX: move occurs because `*m` has type `enums::Movement`, which does not implement the `Copy` trait
    }
}

