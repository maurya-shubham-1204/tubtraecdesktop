# TubTrace Desktop — Developer Notes

Internal notes for engineers. **Do not surface encryption details in the end-user UI.**

**Tenant business logic (web source of truth):** [WEB_BUSINESS_LOGIC.md](WEB_BUSINESS_LOGIC.md)

## Encrypted `.tt` backup

### What users see
- Settings → **Export .tt** / **Import .tt**
- Import asks for the **registration license key** (same key entered at lab activation)
- Unlock **password** (optional security) is separate and does **not** encrypt backups

### How encryption works (devs only)

1. Read the stored registration `licenseKey` from `app_settings`.
2. Derive the AES secret by wrapping the key:

```text
tubetrace_<licenseKey>_tubetrace
```

Example: license `DEMO-KEY-2026` → secret `tubetrace_DEMO-KEY-2026_tubetrace`.

3. Encrypt UTF-8 JSON with **AES-256-GCM** + **PBKDF2-HMAC-SHA256** (120 000 iterations).
4. Binary file layout (`TtCrypto`, magic `TT01`):

| Bytes | Content |
|------:|---------|
| 0–3 | Magic `TT01` |
| 4 | Format version `1` |
| 5–20 | Salt (16) |
| 21–32 | Nonce (12) |
| 33… | Ciphertext + 16-byte GCM tag |

### Portable JSON payload

Inner JSON format: `tubtrace.portable` v1 (web-aligned field names for future sync).

| Section | Maps toward web |
|---------|-----------------|
| `manifest` | Lab code/name/license + local security flags |
| `doctors` | `doctors` |
| `tests` | `tests` (`test_code`, `test_name`, …) |
| `test_parameters` | `test_parameters` |
| `patients` | `patients` (`pre_name`, `first_name`, …) |
| `patient_tests` | `patient_tests` |
| `test_readings` | `test_readings` (`reading`, `patient_test_id`, …) |

**Code**
- Desktop: `lib/services/tt_crypto.dart`, `portable_pack.dart`, `backup_service.dart`, `auth_service.dart` (`backupSecretFromLicenseKey`)
- Web helper (JSON only, no UI yet): `app/Services/TtPortable.php`

### Import rules
- Wrong license key → decrypt fails (“Wrong password or corrupt .tt file”).
- Successful import replaces local operational tables with the archive contents.

---

## Web ↔ Desktop parity checklist

Full tenant business rules: [WEB_BUSINESS_LOGIC.md](WEB_BUSINESS_LOGIC.md).

Desktop matches tenant ops for billing (line price + post-save), patients (filters/actions), catalog enter/verify with **formulas + group_sum**, report HTML (View vs Print), doctors (fields/wallet/protect Self), tests (price/maxDisc/parameters), analytics (range/tabs/CSV), and dashboard due + click-through. Still out of scope: online sync, withdraw history, multi-user auth, L/H range flags polish.

---

## Demo license (offline)

```text
Lab code: DEMO01
Key:      DEMO-KEY-2026
Ver:      1.0
```

### Import default web tenant (dev testing)

1. Clear desktop DB (with app quit):

```bash
rm -f ~/.local/share/com.tubtrace.tubtrace_desktop/tubtrace_offline.sqlite*
```

2. Export from Laravel (default tenant = central DB):

```bash
php artisan tt:export-portable default \
  --out=storage/app/default_tenant_portable.json \
  --lab-code=DEMO01 --license-key=DEMO-KEY-2026
```

3. Encrypt to `.tt` (Python example, same as `TtCrypto`):

```bash
# produces storage/app/default_tenant.tt
```

Or use `dart run tool/pack_tt.dart <json> DEMO-KEY-2026 <out.tt>` from `tubtrace_desktop/`.

4. Launch desktop → register `DEMO01` / `DEMO-KEY-2026` / `1.0` → **Import .tt** and pick the file (use the same license key when asked).

---

## When changing backup crypto

1. Bump `TtCrypto.formatVersion` and support reading old versions.
2. Update this doc and `TtPortable` / `PortablePack` together.
3. Keep end-user Settings copy free of algorithm / wrap-string details.
