# 🧪 PAM TUTORIAL - SSH Authentication Demo (Docker-based)

This project is a hands-on exercise to understand how **Linux PAM (Pluggable Authentication Modules)** work by demonstrating how to customize SSH authentication behavior using PAM.

---

## 📦 Project Overview

This setup runs **three Docker containers**:

- **Client**: Simulates a user attempting to SSH into the servers.
- **Server 1**: A standard SSH server using default password authentication.
- **Server 2**: An SSH server using a custom PAM script that requires the user to enter the **current system time in `HH:MM` format** as the password.

---

## 🔧 Server Behavior

### ✅ Server 1
- Uses standard `pam_unix.so` authentication with a fixed password.

### 🕒 Server 2
- Uses a PAM script (`pam_time_password.sh`) that authenticates users **only if the password matches the current time** in `HH:MM` format.
- PAM configuration is modified using `pam_exec.so` to invoke the script.

---

## 🗂️ Project Structure

```
.
├── README.md
├── client
│   └── Dockerfile
├── docker-compose.yml
├── server1
│   ├── Dockerfile
│   └── src
│       ├── README.md
│       └── std_ssh_pam
└── server2
    ├── Dockerfile
    ├── pam.d
    │   ├── README.md
    │   └── modified_ssh_pam
    └── pam_time_password.sh
```

---

## 🚀 Getting Started

### 1. Build and Start Containers

```bash
docker-compose up --build
```

### 2. Access the Client Container

```bash
docker exec -it client /bin/bash
```

### 3. Test SSH Connections

```bash
ssh testuser@server1.example.com
ssh testuser@server2.example.com
```

### 4. Credentials

- **Username**: `testuser`
- **Passwords**:
  - Server 1: `testpassword`
  - Server 2: Current time in `HH:MM` format

Check current time using:

```bash
date +"%H:%M"
```

---

## 🔧 PAM Configuration Files

- **Server 1** PAM config: `server1/src/std_ssh_pam`
- **Server 2** PAM config: `server2/pam.d/modified_ssh_pam`

---

## 📘 Additional Resource

You can also review the PAM training slide deck provided for background:

- `PAM-presentation.pdf` or `PAM-presentation.pptx`

---

## ✅ Summary

This project demonstrates:

- How Linux PAM modules work in practice
- How to use `pam_exec` to implement custom authentication logic
- How to simulate real-world SSH access in a controlled environment using Docker
