use std::time::Instant;

fn main() {
    for n in 0..20 {
        let time_start = Instant::now();
        let value = fermat(n);
        let time_taken = time_start.elapsed().as_micros();
        println!("{time_taken:5}us | fermat({n}) = {value}");
    }
}

fn fermat(n: u32) -> u128 {
    u128::pow(2, u32::pow(2, n)) + 1
}


#[cfg(test)]
mod tests {
    use super::*;

    // DOCS: https://en.wikipedia.org/wiki/Fermat_number
    #[test]
    fn fermat_numbers() {
        let a000215: Vec<u128> = vec![
            3,
            5,
            17,
            257,
            65537,
            4294967297,
            18446744073709551617,
            // 340282366920938463463374607431768211457,
            // 115792089237316195423570985008687907853269984665640564039457584007913129639937,
        ];
        for (n, value) in a000215.into_iter().enumerate() {
            assert_eq!(fermat(n as u32), value, "fermat({n})");
        }
    }
}