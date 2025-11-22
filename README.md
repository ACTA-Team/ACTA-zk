# ZK Circuits Overview

This directory groups the ZK proofs used in the repository. Each circuit is ready to compile with `nargo`, execute with `Prover.toml`, and optionally prove/verify with Barretenberg (`bb`).

## Circuits

- `noir-acta` — Age check (adult)
  - Private input: `age: u8`
  - Public output: `bool` → `age >= 18`
  - ACIR artifact: `target/noir_workshop.json`
- `noir-not-expired` — Not expired
  - Private inputs: `expiry_ts: u64`, `now_ts: u64`
  - Public output: `bool` → `expiry_ts > now_ts`
  - ACIR artifact: `target/noir_not_expired.json`
- `noir-valid-status` — Status is valid
  - Private input: `valid: Field` (1 valid, 0 invalid)
  - Public output: `bool` → `valid == 1`
  - ACIR artifact: `target/noir_valid_status.json`

## Common Commands (WSL/Linux)

```
cd "/mnt/c/Users/Josué Brenes/Downloads/Argentina/hackathon/zks/<circuit>"

nargo compile
nargo check

# Configure inputs (examples)
# noir-acta
printf 'age = 19\n' > Prover.toml
# noir-not-expired
printf 'expiry_ts = "1767225600000"\nnow_ts = "1731734400000"\n' > Prover.toml
# noir-valid-status
printf 'valid = "1"\n' > Prover.toml

nargo execute

bb prove -b ./target/<acir>.json -w ./target/<acir>.gz -o ./target
bb write_vk -b ./target/<acir>.json -o ./target
bb verify -k ./target/vk -p ./target/proof -i ./target/public_inputs
```

## Common Commands (Windows PowerShell)

```powershell
cd "C:\Users\Josué Brenes\Downloads\Argentina\hackathon\zks\<circuit>"

nargo compile
nargo check

# Configure inputs (examples)
# noir-acta
Set-Content -Path .\Prover.toml -Value "age = 19"
# noir-not-expired
Set-Content -Path .\Prover.toml -Value "expiry_ts = \"1767225600000\"`nnow_ts = \"1731734400000\""
# noir-valid-status
Set-Content -Path .\Prover.toml -Value "valid = \"1\""

nargo execute

bb prove -b .\target\<acir>.json -w .\target\<acir>.gz -o .\target
bb write_vk -b .\target\<acir>.json -o .\target
bb verify -k .\target\vk -p .\target\proof -i .\target\public_inputs
```

## Publish to Web App

- Copy ACIR JSON to `Web\ACTA-dApp\public\zk\` so the dApp can use them:
  - `noir_workshop.json`, `noir_not_expired.json`, `noir_valid_status.json`
- The dApp loads them in `src\lib\zk.ts` and generates/verifies proofs with `@noir-lang/noir_js` + `@aztec/bb.js`.

## Cleanup (optional)

```
rm -f ./target/proof ./target/public_inputs
```

> Note: The `Prover.toml` samples are examples. Adjust values to your real credential data.