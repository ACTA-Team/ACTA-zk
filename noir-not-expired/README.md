# Noir ACTA — Not Expired Proof

This circuit proves: “The credential is not expired” without revealing the actual expiration date.

## Circuit

- `src/main.nr`
  - Inputs: `expiry_ts: u64`, `now_ts: u64`
  - Output: `bool` → true if `expiry_ts > now_ts`

## WSL/Linux

```
cd "/mnt/c/Users/Josué Brenes/Downloads/Argentina/hackathon/Web/ACTA-dApp/zk/noir-not-expired"
nargo compile
nargo check
# Configure inputs (example values in milliseconds)
printf 'expiry_ts = "1767225600000"\nnow_ts = "1731734400000"\n' > Prover.toml
nargo execute
# Optional: prove/verify with barretenberg CLI
bb prove -b ./target/noir_not_expired.json -w ./target/noir_not_expired.gz -o ./target
bb write_vk -b ./target/noir_not_expired.json -o ./target
bb verify -k ./target/vk -p ./target/proof -i ./target/public_inputs
# Publish ACIR JSON for the web app
cp ./target/noir_not_expired.json \
  "/mnt/c/Users/Josué Brenes/Downloads/Argentina/hackathon/Web/ACTA-dApp/public/zk/noir_not_expired.json"
```

## Windows PowerShell

```powershell
cd "C:\Users\Josué Brenes\Downloads\Argentina\hackathon\Web\ACTA-dApp\zk\noir-not-expired"
nargo compile
nargo check
# Configure inputs (example values in milliseconds)
Set-Content -Path .\Prover.toml -Value "expiry_ts = \"1767225600000\"`nnow_ts = \"1731734400000\""
nargo execute
# Optional: prove/verify with barretenberg CLI
bb prove -b .\target\noir_not_expired.json -w .\target\noir_not_expired.gz -o .\target
bb write_vk -b .\target\noir_not_expired.json -o .\target
bb verify -k .\target\vk -p .\target\proof -i .\target\public_inputs
# Publish ACIR JSON for the web app
Copy-Item -Force .\target\noir_not_expired.json \
  "C:\Users\Josué Brenes\Downloads\Argentina\hackathon\Web\ACTA-dApp\public\zk\noir_not_expired.json"
```

## Artifacts

- `./target/noir_not_expired.json` — compiled circuit (ACIR)
- `./target/noir_not_expired.gz` — witness
- `./target/proof`, `./target/public_inputs`, `./target/vk` — proof, public inputs, and verification key

## Integration Notes

- The web app loads ACIR from `public/zk/noir_not_expired.json` and verifies proofs via `src/lib/zk.ts`.
- Inputs are timestamps in milliseconds; compute `now_ts` at runtime off‑chain.