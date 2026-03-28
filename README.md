# 🛡️ Credential Stuffing Simulator

> A controlled, educational web application that simulates credential stuffing attacks against a mock authentication system — built to understand how attackers exploit reused passwords and how defenders can stop them.

---

## ⚠️ Disclaimer

**This tool is strictly for educational and academic purposes.**  
It operates entirely against a hardcoded in-memory mock database with no connection to any real system, network, or service. Do not use this tool or its concepts against any real system without explicit written authorization. The author assumes no liability for misuse.

---

## 👨‍💻 Author

**Jejo J**  
B.E. Cybersecurity Engineering  
Sri Krishna College of Technology, Coimbatore  
*College Assignment — Cybersecurity Concepts & Tools*

---

## 📌 About This Project

Credential stuffing is one of the most prevalent attack vectors in the wild today. Attackers take username:password pairs from data breach dumps and automatically test them across other services, exploiting the fact that many users reuse passwords.

This simulator replicates that attack loop in a **safe, sandboxed environment** so students can:

- Understand how credential stuffing works mechanically
- See the impact of weak/reused passwords
- Observe defensive controls (rate limiting, account lockout) in action
- Visualize attack results in real time

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Backend | Python 3 + Flask |
| Frontend | HTML5, CSS3, Vanilla JavaScript |
| Data Store | In-memory (no database) |
| Fonts | IBM Plex Mono + IBM Plex Sans |

---

## 📁 Project Structure

```
credential-stuffing-simulator/
├── app.py                  ← Flask backend (routes, auth logic, lockout)
├── requirements.txt        ← Python dependencies
├── setup.sh                ← Auto setup script (Linux/macOS)
├── setup.bat               ← Auto setup script (Windows)
├── run.sh                  ← Run script (Linux/macOS)
├── run.bat                 ← Run script (Windows)
├── templates/
│   └── index.html          ← Main UI page
└── static/
    ├── style.css           ← Grayscale minimal design
    └── script.js           ← Simulation logic, progress bar, results
```

---

## 🔐 Features

### Mock User Database (In-Memory)

The app ships with 8 hardcoded test accounts:

| Username | Password |
|---|---|
| user1 | 123456 |
| admin | admin123 |
| jejo | securepass |
| alice | password1 |
| bob | qwerty99 |
| charlie | letmein |
| diana | sunshine |
| root | toor |

### Security Controls Simulated

| Control | Implementation |
|---|---|
| **Rate Limiting** | Max 5 attempts per second (200ms enforced delay) |
| **Account Lockout** | Account locked after 3 consecutive failed attempts |
| **Locked Account Persistence** | Correct password rejected if account is locked |
| **Reset Mechanism** | Full state reset via `/reset` endpoint |

### Attack Simulation

- Accepts a newline-separated list of `username:password` pairs
- Loops through each credential sequentially with enforced delay
- Matches against the mock user database
- Returns per-attempt results: `success`, `failed`, or `locked`

### Results Dashboard

- Real-time animated progress bar during simulation
- Per-attempt log with status indicators
- Attack summary card: Total / Compromised / Failed / Locked / Success Rate

---

## 🖥️ Gallery

### Home Screen
![Home Screen](https://raw.githubusercontent.com/jejo205713/credential-stuffing-simulator/main/Images/homescreen.png)

### Credential Input
![Credential Input](https://raw.githubusercontent.com/jejo205713/credential-stuffing-simulator/main/Images/credential-input.png)

### Attack Simulation Results
![Attack Simulation Results](https://raw.githubusercontent.com/jejo205713/credential-stuffing-simulator/main/Images/attack-simulation-results.png)

---

## 🚀 Installation & Setup

### Prerequisites

- Python 3.8 or higher
- pip (bundled with Python)
- A terminal (bash / zsh / cmd / PowerShell)

---

### Linux / macOS

**Step 1 — Clone the repository**

```bash
git clone https://github.com/YOUR_USERNAME/credential-stuffing-simulator.git
cd credential-stuffing-simulator
```

**Step 2 — Run setup**

```bash
bash setup.sh
```

This will:
- Check your Python version
- Create a virtual environment (`venv/`)
- Install all dependencies from `requirements.txt`

**Step 3 — Start the app**

```bash
bash run.sh
```

**Step 4 — Open in browser**

```
http://127.0.0.1:5000
```

---

### Windows

**Step 1 — Clone the repository**

```cmd
git clone https://github.com/YOUR_USERNAME/credential-stuffing-simulator.git
cd credential-stuffing-simulator
```

**Step 2 — Run setup**

```cmd
setup.bat
```

**Step 3 — Start the app**

```cmd
run.bat
```

**Step 4 — Open in browser**

```
http://127.0.0.1:5000
```

---

### Manual Setup (Alternative)

```bash
python3 -m venv venv
source venv/bin/activate          # Windows: venv\Scripts\activate
pip install -r requirements.txt
python app.py
```

---

## 🔁 API Reference

### `POST /simulate`

Run the credential stuffing simulation.

**Request Body**
```json
{
  "credentials": "user1:123456\nadmin:wrongpass\njejo:securepass"
}
```

**Response**
```json
{
  "results": [
    { "username": "user1", "password": "123456", "status": "success", "message": "Login Successful — COMPROMISED" },
    { "username": "admin", "password": "wrongpass", "status": "failed", "message": "Invalid Credentials" },
    { "username": "jejo", "password": "securepass", "status": "success", "message": "Login Successful — COMPROMISED" }
  ],
  "summary": {
    "total": 3,
    "successful": 2,
    "failed": 1,
    "locked": 0,
    "success_rate": 66.67
  }
}
```

**Status Values**

| Status | Meaning |
|---|---|
| `success` | Credentials matched — account compromised |
| `failed` | Credentials did not match |
| `locked` | Account locked due to too many failures |

---

### `POST /reset`

Reset all account lockout states.

**Response**
```json
{ "message": "All account states reset." }
```

---

## 🧪 Sample Credential List (for testing)

Paste this into the simulator's textarea to see all three outcomes:

```
user1:wrongpass
admin:admin123
jejo:badpass
alice:password1
bob:badpass
bob:badpass
bob:qwerty99
charlie:letmein
diana:wrongpass
root:toor
unknown:nopass
```

Expected outcomes:
- `admin`, `alice`, `charlie`, `root` → **Compromised**
- `bob` → **Locked** (3 failed attempts, then correct password rejected)
- Others → **Failed**

---

## 🎨 UI Design

The interface follows a strict **grayscale / brutalist monospace** aesthetic:

- White background only
- Black text and borders only
- IBM Plex Mono for all data and code elements
- IBM Plex Sans for body text
- No colors, no gradients
- Clean card-based layout with thin black borders

---

## 🧠 Key Cybersecurity Concepts Demonstrated

| Concept | Demonstrated By |
|---|---|
| Credential Stuffing | Core simulation loop |
| Password Reuse Risk | Matching leaked creds against mock DB |
| Rate Limiting | Server-side 200ms delay enforcement |
| Account Lockout | 3-strike lockout policy |
| Defense in Depth | Both rate limiting AND lockout combined |
| Attack Visibility | Per-attempt logging with status |

---

## 📚 References

- [OWASP — Credential Stuffing](https://owasp.org/www-community/attacks/Credential_stuffing)
- [OWASP — Testing for Account Lockout](https://owasp.org/www-project-web-security-testing-guide/)
- [NIST SP 800-63B — Digital Identity Guidelines](https://pages.nist.gov/800-63-3/sp800-63b.html)
- [Have I Been Pwned — About Credential Stuffing](https://haveibeenpwned.com/FAQs)

---

## 📄 License

This project is submitted as an academic assignment and is intended for educational use only.  
© 2025 Jejo J — Sri Krishna College of Technology
