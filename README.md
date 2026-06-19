.# 📡 Router Control App - تطبيق تحكم الراوتر

[![Build APK](https://github.com/YOUR_USERNAME/router-control-app/actions/workflows/build_apk.yml/badge.svg)](https://github.com/YOUR_USERNAME/router-control-app/actions/workflows/build_apk.yml)

تطبيق متكامل للتحكم في راوترات **WE** (ZTE H188N / Huawei HG531)

## 🎯 Features
- ✅ تسجيل الدخول للراوتر
- ✅ إدارة إعدادات WiFi
- ✅ عرض الأجهزة المتصلة
- ✅ حظر وإلغاء حظر الأجهزة

## 📱 Screenshots
- شاشة تسجيل الدخول
- إعدادات WiFi
- الأجهزة المتصلة
- قائمة الحظر

## 🚀 Quick Start

### For Users (End Users)

#### 1. Download APK
- Go to [Releases](../../releases)
- Download latest APK
- Install on Android device

#### 2. Run Backend
```bash
cd backend
pip install -r requirements.txt
python main.py
```

#### 3. Open App
- Enter router IP (default: 192.168.1.1)
- Enter username and password
- Start controlling your router!

### For Developers

#### Clone Repository
```bash
git clone https://github.com/YOUR_USERNAME/router-control-app.git
cd router-control-app
```

#### Run Backend
```bash
cd backend
pip install -r requirements.txt
python main.py
```

#### Run Flutter App
```bash
cd flutter_app
flutter pub get
flutter run
```

## 📁 Project Structure
```
router-control-app/
├── .github/workflows/     # GitHub Actions CI/CD
│   └── build_apk.yml      # Auto-build APK
├── backend/               # Python FastAPI Backend
│   ├── main.py           # Main server
│   ├── requirements.txt  # Dependencies
│   ├── start.bat         # Windows startup
│   └── start.sh          # Linux/Mac startup
├── flutter_app/          # Flutter Application
│   ├── lib/
│   │   └── main.dart    # Main app code
│   └── pubspec.yaml      # Flutter dependencies
└── README.md
```

## 🔧 Supported Routers
- ZTE H188N (WE)
- Huawei HG531

## ⚙️ Configuration

### Change Backend URL
In `flutter_app/lib/main.dart`:
```dart
static String backendUrl = 'http://localhost:8000';
```

For different network:
```dart
static String backendUrl = 'http://192.168.1.100:8000';
```

## 🛠️ Build APK Locally

```bash
cd flutter_app
flutter pub get
flutter build apk --release
```

APK location: `build/app/outputs/flutter-apk/app-release.apk`

## 🌐 Build Web App

```bash
cd flutter_app
flutter pub get
flutter build web
```

Web files: `build/web/`

## ⚠️ Important Notes

1. **Backend must be running** before using the app
2. **Web App** needs Backend on same device (CORS)
3. **Android App** can connect to Backend on same network
4. **Security**: Don't expose Backend to public internet

## 🆘 Troubleshooting

### "Connection refused"
- Check if Backend is running
- Verify router IP address

### "Login failed"
- Check username/password
- Try logging in via browser first

### Web App not working
- Ensure Backend is running
- Check `http://localhost:8000` in browser

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Commit changes
4. Push to branch
5. Open Pull Request

## 📄 License

MIT License - feel free to use and modify!

---

**Made with ❤️ for WE users in Egypt**
