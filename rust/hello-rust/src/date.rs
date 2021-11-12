use chrono::NaiveDateTime;

pub fn iso2timestamp() {
    // Date Format DOCS: https://docs.rs/chrono/0.4.0/chrono/format/strftime/index.html#specifiers
    let timestamp= NaiveDateTime::parse_from_str("2015-09-05 23:56:04", "%Y-%m-%d %H:%M:%S")
        .unwrap().timestamp_nanos() as u64;
    println!("timestamp: {}", timestamp);
}
