# BrezyWeather forecast storage (Terraform)

Terraform for the forecast API's data storage in the resource group `rg-brezyweather-forecast-drift`. State is local in this folder.

Run each Terraform command on its own, without pipes or extra commands, so I see its full output.

## Checking for drift

1. Run `terraform plan -refresh-only`. It changes nothing.
2. For each attribute that changed outside Terraform, say what changed (old value -> new value), what it does, and whether it looks deliberate, risky, or like provider noise. Propose codify (update the HCL to the new value) or revert (leave the HCL, so the next apply puts it back).
3. Stop. I decide each change.

## Making the decision real

1. Codify a change by editing the `.tf` files. Never codify a change I didn't approve.
2. Save the plan and show it to me:

   ```bash
   terraform plan -out=tfplan
   ```

3. Apply only the saved plan, and only after I approve it:

   ```bash
   terraform apply tfplan
   ```

4. Never run `terraform apply` without the plan file, never use `-auto-approve`, and never change Azure resources with `az`.
5. Verify with `terraform plan -detailed-exitcode` (exit code 0 means no changes).
