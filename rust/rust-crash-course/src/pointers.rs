pub fn run() {
    let arr1 = [1,2,3];
    let mut arr2 = arr1;
    arr2[2] = 4;
    println!("arr1 {:?} != arr2 {:?}", arr1, arr2);

    let vec1 = vec![1,2,3];
    let vec2 = &vec1;
    // vec2[2] = 4;  // unsure how to make this work
    println!("vec1 {:?} != vec2 {:?}", vec1, vec2);
}