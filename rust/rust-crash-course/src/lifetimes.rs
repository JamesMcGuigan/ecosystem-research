// YouTube - Rust Lifetimes: https://www.youtube.com/watch?v=1QoT9fmPYr8&ab_channel=DougMilford
#[allow(unused_assignments, unused_mut)]
pub fn run() {
    //// Scope
    let mut a1 = 1;
    let mut a2 = &1;
    {
        let b = 2;
        a1 = b;   // This is valid because ownership transfers to a, thus deleting b
        // a2 = &b;  // BUG: borrowed value `b` does not live long enough
    }
    println!("a1: {} | a2 {}", a1, a2);
    println!("lesser_str('a','b'):     {}", lesser_str("a", "b"));
    println!("lesser_generic('a','b'): {}", lesser_generic(&"a".to_string(), &"b".to_string()));

}

// help: this function's return type contains a borrowed value,
//       but the signature does not say whether it is borrowed from `string1` or `string2`
// help: consider introducing a named lifetime parameter
// Lifetime 'b is a larger than 'a
// Use 'static for CONSTS
fn lesser_str<'a, 'b: 'a>(string1: &'a str, string2: &'b str) -> &'a str {
    return if string1 <= string2 { string1 } else { string2 }
}

fn lesser_generic<'a, T: std::cmp::PartialOrd>(string1: &'a T, string2: &'a T) -> &'a T {
    return if string1 <= string2 { string1 } else { string2 }
}