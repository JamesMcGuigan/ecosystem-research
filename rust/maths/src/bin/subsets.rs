use std::collections::BTreeSet;
use std::time::Instant;

use cached::proc_macro::cached;
use itertools::Itertools;

// YouTube: Olympiad level counting: How many subsets of {1,…,2000} have a sum divisible by 5?
// - https://www.youtube.com/watch?v=bOXCLR3Wric&t=401s&ab_channel=3Blue1Brown
// How Many Subsets of 25 are there?
// TODO: This implements sum(subset) and not modulo_sum(subset)
fn main() {
    subsets(15, 15)  // M1 = 62.982s debug | 2.162s release
}


#[allow(non_snake_case)]
fn subsets(max_n: u32, sum: u32) {
    let start_time = Instant::now();
    let subsets = BTreeSet::from_iter(
        (1..=max_set_size(sum)).flat_map(|n|
            (1..=max_n).permutations(n as usize)
        )
        .filter(|vec| vec.iter().sum::<u32>() == sum)
        .map(|vec| BTreeSet::from_iter(vec.iter().cloned()))
    );
    let duration = (Instant::now() - start_time).as_millis();
    let count = subsets.len();
    subsets.iter().for_each(|subset| println!("{:?}", subset));
    println!("subsets of 0..{} | sum() = {} | total = {} | {}ms", max_n, sum, count, duration);
}


#[cached]
fn max_set_size(sum: u32) -> u32 {
    let mut count = 0;
    let mut iter  = 0;
    while count <= sum {
        count += iter;
        iter  += 1;
    }
    iter
}