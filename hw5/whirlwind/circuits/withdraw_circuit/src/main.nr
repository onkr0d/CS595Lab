use std::hash::pedersen_hash;
use std::merkle::compute_merkle_root;

global TREE_DEPTH: u32 = 8;

struct PrivateInputs {
    r:     Field,
    index: Field,
    path:  [Field; TREE_DEPTH]
}

fn main(
    priv_inputs: PrivateInputs,

    root: pub Field,
    id:   pub Field
) {
    // 1. Re-compute the commitment: H(id || r)
    let commitment = pedersen_hash([id, priv_inputs.r]);

    // 2. Re-compute the Merkle root from (commitment, index, path)
    let calculated_root = compute_merkle_root(commitment, priv_inputs.index, priv_inputs.path);

    // 3. Constrain the result to equal the known root
    assert_eq(calculated_root, root);
}