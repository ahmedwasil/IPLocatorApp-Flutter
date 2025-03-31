# 📍 IP Locator App (Flutter)

This is a small Flutter application built as part of a technical test. It allows users to:

- Enter an IP address or click a button to fetch their current IP
- Fetch the approximate geolocation for that IP
- Display the location visually using OpenStreetMap

The app focuses on clean architecture, state management with Riverpod, and a smooth user experience.

---

## 🛠 Tech Stack

- **Flutter** (3.19+)
- **Riverpod** for state management
- **flutter_map** for maps (OpenStreetMap)
- **Dio** for networking
- **Custom validation & error handling**

---

## 🎯 Features

- ✅ Enter or fetch your IP address
- ✅ Validate IP before lookup
- ✅ View approximate location on a map
- ✅ Graceful error handling (e.g. invalid IPs, network errors)
- ✅ Clear loading & disabled button states
- ✅ Stateless + Stateful separation for reusable widgets
- ✅ Tests for validation and state logic

---

## 🧪 Running Tests

```bash
flutter test
```

Unit tests are provided for:
- IP validation
- StateNotifier logic

---

## 🧼 Improvements (if I had more time)

- Add animation or transitions when map location changes
- Persist search history locally
- Use a more precise geolocation service (if needed)
- Dark mode support + minor UI polish

---

## 🚀 How to Run

1. Ensure Flutter is installed (3.19 or above recommended)
2. Clone the repo
3. Run:

```bash
flutter pub get
flutter run
```

---

## 📌 Notes

- No API key is required — the app uses `https://ipwho.is/` for geolocation and OpenStreetMap for rendering the map
- All packages used are open-source and maintained

---

## 🙋‍♂️ Author

Built with care by Wasil Ahmed for a technical assessment

> Happy to chat through the architecture, trade-offs, or reasoning behind implementation choices.
