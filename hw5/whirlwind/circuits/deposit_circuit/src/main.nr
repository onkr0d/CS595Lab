use std::hash::pedersen_hash;
use std::merkle::compute_merkle_root;

global DEPTH: u32 = 8;

struct PrivateInputs {
    id:  Field,
    r:   Field,
    old_path: [Field; DEPTH]
}

fn main(
    // private
    priv: PrivateInputs,

    // public
    old_root: pub Field,
    new_root: pub Field,
    commitment: pub Field,
    index: pub Field
) {
    // 1. commit correctness
    assert_eq(commitment, pedersen_hash([priv.id, priv.r]));  // 

    // 2. old root was empty at this index
    assert_eq(old_root,
              compute_merkle_root(0, index , priv.old_path)); // 

    // 3. New root after inserting commitment
    assert_eq(new_root,
              compute_merkle_root(commitment, index, priv.old_path));
}