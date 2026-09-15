# TubTrace Web — Tenant Business Logic (brief)

Source of truth for desktop parity. Covers **lab tenant** day-to-day use (not platform admin).

## End-to-end spine

```
Login(lab_code) → Dashboard
  → Register patient → Billing (tests, discount, cash|upi|due)
      → Generate Bill → Enter & Verify queue
      → Bill and Entry → patient entry screen
      → commissions + doctor wallet
  → Enter & Verify → Save | Save & Verify → Report print
  → Patients (history / Enter / View / Print)
  → Tests (price / maxDisc)
  → Doctors (CRUD, wallet, withdraw)
  → Analytics / Profile / Logout
```

## Hard rules

| Area | Rule |
|------|------|
| Registration | `first_name` required min 3; `age` required numeric; `mobile` exactly 10 digits; gender + referred_by required in UI |
| Lists | Only **billed** patients (`total_amount > 0`) |
| Status | Pending = no `approved_at`; Completed/Verified = has `approved_at` |
| Billing | At least one test; payable = max(0, total − discount); cash/upi; due allows partial/zero pay |
| Line price | Editable but capped at catalog price (web UI) |
| Commission | On bill if referring doctor set; % from doctor (or test override / lab default) |
| Enter & Verify | Parameters from booked tests; Save keeps pending; Save & Verify sets approved |
| Tenant tests | Edit price + maxDisc primarily (desktop also allows offline catalog CRUD) |
| Internal doctor | “Self (Lab)” — protected from delete / wallet abuse |

## Module notes

### Dashboard
KPIs today/all-time: patients, tests, collection, due, pending, verified, doctors. Quick links + recent/pending/top tests.

### Billing
Discount % ↔ amount. Payment: cash | upi | due. Actions after save: Generate Bill / Bill and Entry.

### Patients
Filters: date range, status, search (name/mobile/id). Actions: Enter, View, Print.

### Enter & Verify
Queue of pending. Readings per parameter; float / text / qualitative / negative_positive; formulas (`#paramId`, live calc, hide until ready). Group-sum ±0.01 on save. Verify → report.

### Report
Recalc formulas (hide incomplete); section headers; View vs Print (Print auto-opens printable HTML).

### Doctors
Name, phone, org, email, address, commission %. Wallet = sum of commissions − withdrawals.

### Tests
Catalog with parameters (title, unit, order, value_type, formula, section, group_sum, ranges).

### Analytics
Date range; Collections / Commissions / Volume; CSV export.

## Desktop mapping

| Web | Desktop |
|-----|---------|
| Completed | Verified |
| New Registration | New Billing (2-step) |
| Profile + Logout | Settings + Lock/Exit |
| Lab settings (admin) | Offline license in Settings |

See also: [BACKUP_AND_WEB_PARITY.md](BACKUP_AND_WEB_PARITY.md) for `.tt` crypto (devs only).
