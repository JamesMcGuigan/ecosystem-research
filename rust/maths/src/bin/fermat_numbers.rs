use std::time::Instant;
use rug::{Integer, ops::Pow};

fn main() {
    for n in 0..21 {
        let time_start = Instant::now();
        let value = fermat_number(n);
        let is_prime= value.is_probably_prime(128);
        // let value = Float::with_val(128, value);  // BUG: https://gitlab.com/tspiteri/rug/-/issues/42
        let time_taken = time_start.elapsed();
        println!("{time_taken:?} | fermat({n}) = {is_prime:?} {value}");
    }
}

fn fermat_number(n: u32) -> Integer {
    Integer::from(2).pow( u32::pow(2,n) ) + 1
    // u128::pow(2, u32::pow(2, n)) + 1
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn fermat_numbers() {
        // DOCS: https://en.wikipedia.org/wiki/Fermat_number
        let a000215 = [
            "3",
            "5",
            "17",
            "257",
            "65537",
            "4294967297",
            "18446744073709551617",
            "340282366920938463463374607431768211457",
            "115792089237316195423570985008687907853269984665640564039457584007913129639937",
        ]
            .into_iter()
            .map(|n| Integer::from_str_radix(n, 10).unwrap())
            .collect::<Vec<_>>()
        ;
        for (n, value) in a000215.into_iter().enumerate() {
            assert_eq!(fermat_number(n as u32), value, "fermat({n})");
        }
    }
}