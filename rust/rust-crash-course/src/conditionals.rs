#[allow(unused_variables, dead_code)]
pub fn run() {
    let age: u8 = 18;
    if age >= 21 { println!("age {} >= 21" , age); } else { println!("age {} < 21" , age); }

    const A: bool = true;
    const B: bool = false;
    const C: bool = if A && B { true } else { false };  // || age > 1 == attempt to use a non-constant value in a constant
    if A && B      { println!("A && B");   }
    else if A || B { println!("A || B");   }
    else           { println!("!A && !B"); }
}