pub fn ismax<T: PartialOrd>(arr: & [T]) -> bool {
    arr[0] > arr[1]
}

pub fn down<T: PartialOrd>(arr: &mut [T], position: usize, is_max_heap: bool, heap_size: usize) {
    let mut largest_or_smallest = position;
    let left_child = 2 * position + 1;
    let right_child = 2 * position + 2;

    if left_child < heap_size &&
       ((is_max_heap && arr[left_child] > arr[largest_or_smallest]) ||
        (!is_max_heap && arr[left_child] < arr[largest_or_smallest])) {
        largest_or_smallest = left_child;
    }

    if right_child < heap_size &&
       ((is_max_heap && arr[right_child] > arr[largest_or_smallest]) ||
        (!is_max_heap && arr[right_child] < arr[largest_or_smallest])) {
        largest_or_smallest = right_child;
    }

    if largest_or_smallest != position {
        arr.swap(position, largest_or_smallest);
        down(arr, largest_or_smallest, is_max_heap, heap_size);
    }
}

pub fn up<T: PartialOrd>(arr: &mut [T], position: usize, is_max_heap: bool) {
    if position == 0 {
        return;
    }

    let parent = (position - 1) / 2;
    if (is_max_heap && arr[position] > arr[parent]) ||
       (!is_max_heap && arr[position] < arr[parent]) {
        arr.swap(position, parent);
        up(arr, parent, is_max_heap);
    }
}

pub fn change_priority<T: PartialOrd>(arr: &mut [T], new_number: T, position: usize) {
    let is_max_heap = ismax(arr);
    arr[position] = new_number;

    if position > 0 {
        let parent = (position - 1) / 2;
        if (is_max_heap && arr[position] > arr[parent]) ||
           (!is_max_heap && arr[position] < arr[parent]) {
            up(arr, position, is_max_heap);
            return;
        }
    }

    down(arr, position, is_max_heap, arr.len());
}

pub fn insert<T: PartialOrd>(arr: &mut Vec<T>, new_number: T) {
    arr.push(new_number);
    let position = arr.len() - 1;
    let is_max = ismax(arr);
    up(arr, position, is_max);
}

pub fn remove_root<T: PartialOrd>(arr: &mut Vec<T>) {
    if arr.len() > 1 {
        let is_max_heap = ismax(arr);
        let position = arr.len();
        arr.swap(0, position-1);
        arr.pop();
        down(arr, 0, is_max_heap, position);
    }
}

pub fn construct_heap <T: PartialOrd>(arr: &mut [T], is_max_heap: bool) {
    let size = arr.len();
    for i in (0..size / 2).rev() {
        down(arr, i, is_max_heap, size);
    }
}

pub fn heap_sort<T: PartialOrd>(arr: &mut [T]) {
    construct_heap(arr, false);
    let mut heap_size = arr.len();

    for i in (1..heap_size).rev() {
        arr.swap(0, i);
        heap_size -= 1;
        down(arr, 0, false, heap_size);
    }
}