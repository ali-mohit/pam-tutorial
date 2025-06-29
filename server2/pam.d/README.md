# PAM Configuration Explained

This document explains the meaning of the following PAM configuration lines used in the SSH server to enforce time-based authentication:

```
auth    required    pam_exec.so expose_authtok /usr/local/bin/pam_time_password.sh
account required    pam_permit.so
session required    pam_permit.so
```

---

## 🔐 `auth required pam_exec.so expose_authtok /usr/local/bin/pam_time_password.sh`

### Components:

- `auth`: Defines the **authentication phase**, which validates the user’s identity.
- `required`: If this module fails, the **entire authentication fails**, even if other modules succeed.
- `pam_exec.so`: Runs an **external script or binary**.
- `expose_authtok`: Exposes the **user's password** entered during login via **stdin** to the script.
- `/usr/local/bin/pam_time_password.sh`: The **custom script** that checks if the entered password equals the current system time in `HH:MM` format.

### What it does:

Runs your custom authentication logic. If the user types the **current system time as the password**, authentication succeeds.

---

## 👤 `account required pam_permit.so`

### Components:

- `account`: Manages **account validation** (e.g., checking if the account is expired, locked, or allowed).
- `required`: Required to succeed.
- `pam_permit.so`: A PAM module that **always returns success**.

### What it does:

Skips any real account checks and **permits all users**.

---

## 🧾 `session required pam_permit.so`

### Components:

- `session`: Runs during **session setup and teardown** (e.g., mounting directories, setting environment variables).
- `required`: Required to succeed.
- `pam_permit.so`: Always returns success.

### What it does:

Skips any actual session management and **permits the session to start**.

---

## ✅ Summary Table

| PAM Line | Purpose | Behavior |
|----------|---------|----------|
| `auth` | Authentication | Calls custom script that checks if password == `HH:MM` |
| `account` | Authorization | Always succeeds (no account lockout or expiry check) |
| `session` | Session management | Always succeeds (no setup/cleanup actions) |

---

## ⚠️ Note

- This configuration is suitable for **testing or educational purposes only**.
- It is **not secure for production** environments, as it bypasses standard password and account policies.
