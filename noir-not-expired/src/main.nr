fn main(expiry_ts: u64, now_ts: u64) -> pub bool {
    let ok = expiry_ts > now_ts;
    ok
}