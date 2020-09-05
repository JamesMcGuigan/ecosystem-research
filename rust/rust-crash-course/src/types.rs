use regex::Regex;

pub fn run() {
    let mut hello_world = String::from("Hello");
    hello_world.push_str(" World");
    hello_world.push('!');
    println!("{} (length: {} | capacity: {} | empty: {})",
             hello_world, hello_world.len(), hello_world.capacity(), hello_world.is_empty());
    println!("{} contains 'World': {}", hello_world, hello_world.contains("World!"));
    for word in hello_world.replace("Hello", "Goodbye").split_whitespace() {
        println!("{}", word);
    }


    // DOCS: https://docs.rs/regex/1.3.9/regex/
    let us_date_re= Regex::new(r"(\d+)/(\d+)/(\d+)").unwrap();
    let us_date = "09/04/2020";  // US Date Format
    let iso_date = us_date_re.replace_all(us_date, "$3-$1-$2");
    assert_ne!(us_date, iso_date);
    assert!(us_date_re.is_match(us_date));
    assert!(!us_date_re.is_match(hello_world.as_str()));
    println!("US Date {} to ISO Date {}", us_date, String::from(iso_date));


    // std:i128:MIN = -170141183460469231731687303715884105728
    // std:i164:MIN = -9223372036854775808
    // std:i32:MIN  = -2147483648
    // std:i16:MIN  = -32768
    // std:i8:MIN   = -128
    // std:u128:MIN = 0
    // std:u164:MIN = 0
    // std:u16:MIN  = 0
    // std:u32:MIN  = 0
    // std:u8:MIN   = 0
    // std:i8:MAX   = 127
    // std:u8:MAX   = 255
    // std:i16:MAX  = 32767
    // std:u16:MAX  = 65535
    // std:i32:MAX  = 2147483647
    // std:u32:MAX  = 4294967295
    // std:i164:MAX = 9223372036854775807
    // std:u164:MAX = 18446744073709551615
    // std:i128:MAX = 170141183460469231731687303715884105727
    // std:u128:MAX = 340282366920938463463374607431768211455

    println!("std:i128:MIN = {}", std::i128::MIN);
    println!("std:i164:MIN = {}", std::i64::MIN);
    println!("std:i32:MIN  = {}", std::i32::MIN);
    println!("std:i16:MIN  = {}", std::i16::MIN);
    println!("std:i8:MIN   = {}", std::i8::MIN);
    println!("std:u128:MIN = {}", std::u128::MIN);
    println!("std:u164:MIN = {}", std::u64::MIN);
    println!("std:u16:MIN  = {}", std::u16::MIN);
    println!("std:u32:MIN  = {}", std::u32::MIN);
    println!("std:u8:MIN   = {}", std::u8::MIN);

    println!("std:i8:MAX   = {}", std::i8::MAX);
    println!("std:u8:MAX   = {}", std::u8::MAX);
    println!("std:i16:MAX  = {}", std::i16::MAX);
    println!("std:u16:MAX  = {}", std::u16::MAX);
    println!("std:i32:MAX  = {}", std::i32::MAX);
    println!("std:u32:MAX  = {}", std::u32::MAX);
    println!("std:i164:MAX = {}", std::i64::MAX);
    println!("std:u164:MAX = {}", std::u64::MAX);
    println!("std:i128:MAX = {}", std::i128::MAX);
    println!("std:u128:MAX = {}", std::u128::MAX);

    
}