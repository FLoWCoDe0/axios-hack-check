# Axios Hack Check (Windows)

PowerShell script to detect common indicators related to the recent Axios/npm supply-chain compromise on Windows systems.

> ⚠️ This version includes Arabic output (reversed for PowerShell compatibility)

---


### What it does

This script checks for:

- Compromised axios versions (`1.14.1`, `0.30.4`)
- Suspicious entries in `package-lock.json`
- Presence of `plain-crypto-js`
- Potential RAT artifacts (e.g. `wt.exe`, temp payload files)
- Active connection to known C2 (`142.11.206.73`)

---

## Download

### Option 1 — Download ZIP (recommended)
1. Click **Code**
2. Click **Download ZIP**
3. Extract the ZIP
4. Open the extracted folder

### Option 2 — Download only the script
1. Open `axios-hack-check-arabic.ps1`
2. Click **Raw**
3. Save it as `axios-hack-check-arabic.ps1`

### Option 3 — Clone repository (for developers)

```bash
git clone https://github.com/FLoWCoDe0/axios-hack-check.git
cd axios-hack-check
```

---

## Run

```powershell
Unblock-File .\axios-hack-check-arabic.ps1
.\axios-hack-check-arabic.ps1
```

---

## If blocked

```powershell
powershell -ExecutionPolicy Bypass -File .\axios-hack-check-arabic.ps1
```

---

## Notes

- Detection only — no automatic remediation
- Review the script before running it
- Arabic output is reversed intentionally for terminal compatibility

---

## Disclaimer

This script checks for known indicators only.  
It does not guarantee full system integrity or absence of compromise.

---

## License

MIT

---

> ⚠️ هذه النسخة تحتوي على مخرجات باللغة العربية (معكوسة بسبب مشاكل عرض PowerShell)

### وظيفة السكربت

يقوم السكربت بفحص:

- إصدارات axios المتأثرة (`1.14.1`, `0.30.4`)
- وجود مؤشرات مشبوهة داخل `package-lock.json`
- وجود مكتبة `plain-crypto-js`
- آثار محتملة لبرامج RAT (مثل `wt.exe` أو ملفات مؤقتة)
- اتصال نشط مع خادم تحكم (C2) (`142.11.206.73`)

---

## التحميل

### الخيار 1 — تحميل المشروع كملف ZIP (الموصى به)
1. اضغط **Code**
2. اضغط **Download ZIP**
3. فك ضغط الملف
4. افتح المجلد

### الخيار 2 — تحميل السكربت فقط
1. افتح ملف `axios-hack-check-arabic.ps1`
2. اضغط **Raw**
3. احفظ الملف باسم `axios-hack-check-arabic.ps1`

### الخيار 3 — نسخ المشروع (للمطورين)

```bash
git clone https://github.com/FLoWCoDe0/axios-hack-check.git
cd axios-hack-check
```

---

## طريقة التشغيل

```powershell
Unblock-File .\axios-hack-check-arabic.ps1
.\axios-hack-check-arabic.ps1
```

---

## في حال تم الحظر

```powershell
powershell -ExecutionPolicy Bypass -File .\axios-hack-check-arabic.ps1
```

---

## ملاحظات

- هذا السكربت للفحص فقط ولا يقوم بأي معالجة تلقائية
- راجع محتوى السكربت قبل تشغيله
- تم عكس النص العربي عمدًا لتوافق أفضل مع بعض بيئات PowerShell

---

## إخلاء مسؤولية

هذا السكربت يفحص مؤشرات معروفة فقط.  
ولا يضمن سلامة النظام بشكل كامل أو عدم وجود اختراق.

---

## الترخيص

MIT