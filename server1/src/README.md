# PAM Configuration for SSH Explained

This document explains the default PAM configuration for the SSH daemon, typically found in `/etc/pam.d/sshd`.

---

## 🔐 Authentication

```pam
# Standard Un*x authentication.
@include common-auth
```

- Delegates authentication to `common-auth` (usually uses `pam_unix.so`, `pam_faildelay.so`, etc.).
- It handles verifying the user’s password or other authentication mechanisms.

---

## 👤 Account Rules

```pam
account required pam_nologin.so
```

- Prevents non-root users from logging in if `/etc/nologin` exists (used for maintenance mode).
- Root can still log in.

```pam
# account required pam_access.so
```

- (Commented out by default) Enables fine-grained access control via `/etc/security/access.conf`.

```pam
@include common-account
```

- Delegates account checks (e.g., expired account, valid login shell) to `common-account`.

---

## 🧾 Session Rules

```pam
session [success=ok ignore=ignore module_unknown=ignore default=bad] pam_selinux.so close
```

- Ensures SELinux context is properly closed for the session.

```pam
session required pam_loginuid.so
```

- Sets the `loginuid`, which is essential for user auditing.

```pam
session optional pam_keyinit.so force revoke
```

- Initializes a new session keyring, useful for cryptographic operations.

```pam
@include common-session
```

- Delegates standard session setup (like mounting home directories) to `common-session`.

```pam
session optional pam_motd.so motd=/run/motd.dynamic
session optional pam_motd.so noupdate
```

- Displays the Message of the Day (MOTD). One dynamic, one static.

```pam
session optional pam_mail.so standard noenv
```

- Notifies the user if they have new mail.

```pam
session required pam_limits.so
```

- Enforces resource limits as defined in `/etc/security/limits.conf`.

```pam
session required pam_env.so
session required pam_env.so user_readenv=1 envfile=/etc/default/locale
```

- Loads environment variables from system files, including locale settings.

```pam
session [success=ok ignore=ignore module_unknown=ignore default=bad] pam_selinux.so open
```

- Ensures processes start in the correct SELinux context.

---

## 🔄 Password Management

```pam
@include common-password
```

- Delegates password change functionality to `common-password` (typically uses `pam_unix.so`).

---

## ✅ Summary Table

| Section | Purpose | Modules Used |
|---------|---------|---------------|
| auth    | Authentication | `@include common-auth` |
| account | Access control, maintenance mode | `pam_nologin.so`, `@include common-account` |
| session | Session setup, SELinux, limits, env, MOTD, mail | `pam_selinux.so`, `pam_limits.so`, `pam_env.so`, `pam_motd.so`, `pam_mail.so`, `pam_keyinit.so`, etc. |
| password | Password updates | `@include common-password` |

---

## 📝 Notes

- PAM is **modular**; the actual behavior depends on what `common-*` files include.
- This configuration is **typical for Debian-based systems** like Ubuntu.
- SELinux modules are active only if SELinux is enabled on the system.

