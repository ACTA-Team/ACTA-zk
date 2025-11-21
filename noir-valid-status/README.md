# Noir ACTA — Valid Status Proof

This circuit proves: “The credential status is valid” without revealing the status field.

## Circuit

- `src/main.nr`
  - Inputs: `valid: Field`
  - Output: `bool` → true if `valid == 1`

## WSL/Linux

```
cd "/mnt/c/Users/Josué Brenes/Downloads/Argentina/hackathon/Web/ACTA-dApp/zk/noir-valid-status"
nargo compile
nargo check
# Configure inputs (1 for valid, 0 for invalid)
printf 'valid = "1"\n' > Prover.toml
nargo execute
# Optional: prove/verify with barretenberg CLI
bb prove -b ./target/noir_valid_status.json -w ./target/noir_valid_status.gz -o ./target
bb write_vk -b ./target/noir_valid_status.json -o ./target
bb verify -k ./target/vk -p ./target/proof -i ./target/public_inputs
# Publish ACIR JSON for the web app
cp ./target/noir_valid_status.json \
  "/mnt/c/Users/Josué Brenes/Downloads/Argentina/hackathon/Web/ACTA-dApp/public/zk/noir_valid_status.json"
```

## Windows PowerShell

```powershell
cd "C:\Users\Josué Brenes\Downloads\Argentina\hackathon\Web\ACTA-dApp\zk\noir-valid-status"
nargo compile
nargo check
# Configure inputs (1 for valid, 0 for invalid)
Set-Content -Path .\Prover.toml -Value "valid = \"1\""
nargo execute
# Optional: prove/verify with barretenberg CLI
bb prove -b .\target\noir_valid_status.json -w .\target\noir_valid_status.gz -o .\target
bb write_vk -b .\target\noir_valid_status.json -o .\target
bb verify -k .\target\vk -p .\target\proof -i .\target\public_inputs
# Publish ACIR JSON for the web app
Copy-Item -Force .\target\noir_valid_status.json \
  "C:\Users\Josué Brenes\Downloads\Argentina\hackathon\Web\ACTA-dApp\public\zk\noir_valid_status.json"
```

## Artifacts

- `./target/noir_valid_status.json` — compiled circuit (ACIR)
- `./target/noir_valid_status.gz` — witness
- `./target/proof`, `./target/public_inputs`, `./target/vk` — proof, public inputs, and verification key

## Integration Notes

- The web app loads ACIR from `public/zk/noir_valid_status.json` and verifies proofs via `src/lib/zk.ts`.
- Off‑chain, compute `valid` from your policy (`status === 'valid' ? 1 : 0`).