// How Many Subsets of 25 are there
use std::collections::HashSet;
use itertools::Itertools;

fn main() {
    let N = 25;
    let perms = (0..N).permutations(N);
    let subsets = perms.iter()
        .filter(|vec| vec.iter().sum() == 5)
        .collect();
    ;
    let count = subsets.len();
    println!("{} subsets of {}", count, N);
    println!("{:?}", subsets)
}