// YouTube: https://www.youtube.com/watch?v=lQ7XF-6HYGc&ab_channel=DougMilford
// YouTube: https://www.youtube.com/watch?v=1QoT9fmPYr8&ab_channel=DougMilford

#[derive(Debug)]  // Copy, Clone
struct Test {
    a: i32,
    b: f64,
}

#[derive(Debug, Copy, Clone)]
struct TestCopy {
    a: i32,
    b: f64,
}


#[allow(unused_variables)]
#[allow(unused_mut, unused_assignments)]
pub fn run() {
    let stack_f64: f64     =  std::f64::consts::PI;
    let mut heap_vec: Vec<i32> = vec![1,2,3,4,5];

    //// Stack

    stack_fn(stack_f64);
    println!("stack_f64(): {}", stack_f64);

    // Structs either need to passed by reference, with returnable borrowing
    let mut stack_struct = Test { a: 1, b:2.0 };
    // stack_struct_fn(stack_struct);
    // println!("stack_struct(): {:?}", stack_struct);  // value borrowed here after move
    stack_struct_fn(&mut stack_struct);
    println!("stack_struct(): {:?}", stack_struct);  // value borrowed here after move

    // Alternative solution is to derive(Copy) and pass by value
    let stack_struct2 = TestCopy { a: 1, b:2.0 };
    stack_struct_fn2(stack_struct2);
    println!("stack_struct2(): {:?}", stack_struct2);  // value is not mutated outside of function


    //// Heap

    // BUG: borrow of moved value: `heap_vec`
    // heap_fn_return(heap_vec);
    // println!("heap_vec(): {:?}", heap_vec);

    heap_vec = heap_fn_return(heap_vec);
    println!("heap_vec(): {:?}", heap_vec);

    heap_fn_borrow(&mut heap_vec);
    println!("heap_fn_borrow(): {:?}", heap_vec);

    // References cannot be modified
    let heap_string1 = String::from("Hello World");
    let heap_string2 = heap_string1;  // heap_string1 loses ownership and cannot be accessed/printed afterwards
    let heap_string3 = &heap_string2;    // immutable borrow occurs here
    let heap_string4 = &heap_string2;
    // heap_string2.push('!');  // BUG: mutable borrow occurs here
    // heap_string3.push('!');  // BUG: heap_string3` is a `&` reference, so the data it refers to cannot be borrowed as mutable

    println!("heap_strings: {}, {}, {}", heap_string2, heap_string3, heap_string4);
}

fn stack_fn(mut stack_f64: f64) {
    stack_f64 += std::f64::consts::E;
    println!("stack_fn(): {}", stack_f64);
}

fn stack_struct_fn(stack_struct: &mut Test) {
    stack_struct.a = 42;
    println!("stack_struct_fn(): {:?}", stack_struct);
}
fn stack_struct_fn2(mut stack_struct: TestCopy) {
    // pass by value | value is not mutated outside of function
    stack_struct.a = 42;
    println!("stack_struct_fn2(): {:?}", stack_struct);
}


#[allow(dead_code)]
fn heap_fn_return(mut heap_vev: Vec<i32>) -> Vec<i32> {
    heap_vev[0] = 10;
    println!("heap_vev(): {:?}", heap_vev);
    heap_vev
}

#[allow(dead_code)]
fn heap_fn_borrow(heap_vev: &mut Vec<i32>) {
    heap_vev[0] = 20;
    println!("heap_vev(): {:?}", heap_vev);
}