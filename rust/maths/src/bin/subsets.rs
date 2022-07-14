// YouTube: Olympiad level counting: How many subsets of {1,…,2000} have a sum divisible by 5?
// - https://www.youtube.com/watch?v=bOXCLR3Wric&t=401s&ab_channel=3Blue1Brown
// How Many Subsets of 25 are there?
// use std::collections::HashSet;
use itertools::Itertools;
use std::collections::{BTreeSet};

fn main() {
    subsets(10, 10)
}

#[allow(non_snake_case)]
fn subsets(range: u32, sum: u32) {
    let subsets = BTreeSet::from_iter(
        (1..=range).flat_map(|n|
            (1..=range).permutations(n as usize)
        )
        .filter(|vec| vec.iter().sum::<u32>() == sum)
        .map(|vec| BTreeSet::from_iter(vec.iter().cloned()))
    );
    let count = subsets.len();
    subsets.iter().for_each(|subset| println!("{:?}", subset));
    println!("subsets of 0..{} | sum() = {} | total = {}", range, sum, count);
}
