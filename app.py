from flask import Flask, request, jsonify, render_template
import time
import threading

app = Flask(__name__)

# Mock user database (in-memory)
USER_DB = {
    "user1": "123456",
    "admin": "admin123",
    "jejo": "securepass",
    "alice": "password1",
    "bob": "qwerty99",
    "charlie": "letmein",
    "diana": "sunshine",
    "root": "toor",
}

# Account lockout state (in-memory)
account_state = {}
account_lock = threading.Lock()

MAX_FAILED = 3
RATE_LIMIT = 5  # max attempts per second


def reset_state():
    with account_lock:
        account_state.clear()


def get_account(username):
    with account_lock:
        if username not in account_state:
            account_state[username] = {"failed": 0, "locked": False}
        return dict(account_state[username])


def record_failure(username):
    with account_lock:
        state = account_state.setdefault(username, {"failed": 0, "locked": False})
        state["failed"] += 1
        if state["failed"] >= MAX_FAILED:
            state["locked"] = True


def record_success(username):
    with account_lock:
        if username in account_state:
            account_state[username]["failed"] = 0


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/simulate", methods=["POST"])
def simulate():
    data = request.get_json()
    credentials_raw = data.get("credentials", "").strip()

    if not credentials_raw:
        return jsonify({"error": "No credentials provided"}), 400

    lines = [l.strip() for l in credentials_raw.splitlines() if l.strip()]

    results = []
    successful = []
    failed = []
    locked = []
    total = 0

    # Rate-limit enforcement: max RATE_LIMIT attempts/sec
    delay = 1.0 / RATE_LIMIT  # 0.2s between attempts

    for line in lines:
        if ":" not in line:
            continue

        username, password = line.split(":", 1)
        username = username.strip()
        password = password.strip()
        total += 1

        time.sleep(delay)

        state = get_account(username)

        if state["locked"]:
            result = {
                "username": username,
                "password": password,
                "status": "locked",
                "message": "Account Locked"
            }
            locked.append(username)
        elif username in USER_DB and USER_DB[username] == password:
            record_success(username)
            result = {
                "username": username,
                "password": password,
                "status": "success",
                "message": "Login Successful — COMPROMISED"
            }
            successful.append(username)
        else:
            record_failure(username)
            # Check if just got locked
            new_state = get_account(username)
            if new_state["locked"]:
                result = {
                    "username": username,
                    "password": password,
                    "status": "locked",
                    "message": f"Account Locked (too many failures)"
                }
                locked.append(username)
            else:
                result = {
                    "username": username,
                    "password": password,
                    "status": "failed",
                    "message": "Invalid Credentials"
                }
                failed.append(username)

        results.append(result)

    success_rate = round((len(successful) / total * 100), 2) if total > 0 else 0.0

    return jsonify({
        "results": results,
        "summary": {
            "total": total,
            "successful": len(successful),
            "failed": len(failed),
            "locked": len(set(locked)),
            "success_rate": success_rate
        }
    })


@app.route("/reset", methods=["POST"])
def reset():
    reset_state()
    return jsonify({"message": "All account states reset."})


if __name__ == "__main__":
    app.run(debug=True, port=5000)
