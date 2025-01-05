use sort_algorithms::heap::{remove_root, *};

#[test]
fn change_priority_max_test() {
    let mut arr = vec![50, 48, 45, 29, 15, 35, 40, 27, 26, 14, 12, 33, 30, 37, 20, 21, 19, 25];
    change_priority(&mut arr, 10,0);
    assert_eq!(arr, [48,29,45,27,15,35,40,21,26,14,12,33,30,37,20,10,19,25], "change_priority_max_test failed");
}

#[test]
fn change_priority_min_test() {
    let mut arr = vec![12,14,20,19,15,30,37,21,25,48,50,33,35,45,40,29,27,26];
    change_priority(&mut arr, 10,0);
    assert_eq!(arr, [10,14,20,19,15,30,37,21,25,48,50,33,35,45,40,29,27,26], "change_priority_min_test failed");
}

#[test]
fn insert_max_test() {
    let mut arr = vec![50, 48, 45, 29, 15, 35, 40, 27, 26, 14, 12, 33, 30, 37, 20, 21, 19, 25];
    insert(&mut arr, 47);
    assert_eq!(arr, [50,48,45,47,15,35,40,27,29,14,12,33,30,37,20,21,19,25,26], "insert_max_test failed");
}

#[test]
fn insert_min_test() {
    let mut arr = vec![12,14,20,19,15,30,37,21,25,48,50,33,35,45,40,29,27,26];
    insert(&mut arr, 47);
    assert_eq!(arr, [12, 14, 20, 19, 15, 30, 37, 21, 25, 48, 50, 33, 35, 45, 40, 29, 27,26, 47], "insert_min_test failed");
}

#[test]
fn remove_root_test() {
    let mut arr = vec![50, 48, 45, 29, 15, 35, 40, 27, 26, 14, 12, 33, 30, 37, 20, 21, 19, 25];
    remove_root(&mut arr);
    assert_eq!(arr, [48,29,45,27,15,35,40,25,26,14,12,33,30,37,20,21,19], "remove_root failed");
}

#[test]
fn construct_heap_max_test() {
    let mut arr = vec![7, 5, 12, 4, 8, 9, 3, 14, 1, 15];
    construct_heap(&mut arr, true);
    assert_eq!(arr, [15,14,12,7,8,9,3,4,1,5], "construct_heap_max failed");
}

#[test]
fn construct_heap_min_test() {
    let mut arr = vec![7, 5, 12, 4, 8, 9, 3, 14, 1, 15];
    construct_heap(&mut arr, false);
    assert_eq!(arr, [1,4,3,5,8,9,12,14,7,15], "construct_heap_min failed");
}

// fn main() {
//     let mut heap = vec![50, 48, 45, 29, 15, 35, 40, 27, 26, 14, 12, 33, 30, 37, 20, 21, 19, 25];
//     let mut to_be_heap = vec![7, 5, 12, 4, 8, 9, 3, 14, 1, 15];

//     println!("Heap original: {:?}", heap);
//     change_priority(&mut heap, 10, 0);
//     println!("Heap atualizado: {:?}", heap);

//     insert(&mut heap, 47);
//     println!("Heap com novo elemento: {:?}", heap);

//     remove_root(&mut heap);
//     println!("Heap sem raiz: {:?}", heap);

//     construct_heap(&mut to_be_heap, true);
//     println!("Heap construída (máx): {:?}", to_be_heap);

//     construct_heap(&mut to_be_heap, false);
//     println!("Heap construída (mín): {:?}", to_be_heap);
// }
