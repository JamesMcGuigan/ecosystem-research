extern crate num_bigint_dig as num_bigint;
extern crate num_traits;

use std::time::Instant;

use num::pow::pow;
use num_bigint::BigUint;
use num_bigint::prime::probably_prime;

fn main() {
    for n in 0..21 {
        let time_start = Instant::now();

        let value = fermat_number(n);
        let is_prime = probably_prime(&value, 128);

        let time_taken = time_start.elapsed();
        println!("{time_taken:?} | num_bigint::prime::probably_prime() = {is_prime:?} | fermat({n}) = {value}\n");
    }
}

fn fermat_number(n: usize) -> BigUint {
    let one = BigUint::from(1_u32);
    let two = BigUint::from(2_u32);
    pow(two, pow(2, n)) + one
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
            .map(|n| BigUint::parse_bytes(n.as_bytes(), 10).unwrap())
            .collect::<Vec<_>>()
        ;
        for (n, expected) in a000215.into_iter().enumerate() {
            let actual = fermat_number(n);
            assert_eq!(actual, expected, "fermat_number({n})");
        }
    }
}