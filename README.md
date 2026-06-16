# ms_duty | Multi-Framework Duty Toggle System

A lightweight, secure, and optimized standalone duty toggle script designed for FiveM. This script seamlessly bridges multiple frameworks and targeting systems, offering an all-in-one solution for job duty management.

Developed by **Maula-Store**.

---

## 🚀 Key Features

* **Multi-Framework Compatibility:** Out-of-the-box automated detection and support for **QBCore**, **Qbox**, and **ESX**.
* **Dual Target Integration:** Dynamically switches between `ox_target` and `qb-target` depending on which resource is active on your server.
* **Hybrid Activation:** Supports both interactive **Target Zones** and **Chat Commands** (`/aduty` by default) to toggle duty status.
* **Smart Notifications:** Built-in modular notification system utilizing `ox_lib` notifications, framework natives, or `qb-core` fallback notifications.
* **Advanced Multi-Job & Locations:** Easily configure multiple distinct 3D coordinates for each whitelisted job.

---

## 📁 File Structure

Ensure our resource directory inside `server-data/resources/[scripts]/ms_duty` matches the structure below:

```text
ms_duty/
├── fxmanifest.lua
├── shared.lua
├── README.md
├── client/
│   └── cl_duty.lua
└── server/
    └── sv_duty.lua
```

## 📁 Preview
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/d087ea9f-2004-4965-b5ab-552ce78b01b0" />

<img width="1920" height="1017" alt="image" src="https://github.com/user-attachments/assets/6abbac50-02fe-4219-b6d2-272ba8cafc21" />
