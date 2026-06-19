
# 📖 دليل رفع المشروع على GitHub و بناء APK

## 🎯 الخطوات بالتفصيل

### الخطوة 1: إنشاء حساب GitHub (لو مش عندك)
1. ادخل على: https://github.com
2. اضغط "Sign up"
3. اكتب email + password + username
4. أكد الـ email

### الخطوة 2: إنشاء Repository جديد
1. ادخل على GitHub
2. اضغط على الـ "+" فوق
3. اختار "New repository"
4. اكتب الاسم: `router-control-app`
5. اختار "Public"
6. اضغط "Create repository"

### الخطوة 3: رفع الملفات

#### الطريقة 1: رفع ZIP مباشرة (أسهل)
1. في صفحة الـ Repo الجديد
2. اضغط على "uploading an existing file"
3. فك الضغط عن ملف `router-control-app-github.zip`
4. اسحب الملفات وارفعها
5. اضغط "Commit changes"

#### الطريقة 2: باستخدام Git (للمتقدمين)
```bash
# 1. فك الضغط
cd router-control-app-github

# 2. init git
git init

# 3. add files
git add .

# 4. commit
git commit -m "Initial commit"

# 5. add remote (استبدل YOUR_USERNAME باسمك)
git remote add origin https://github.com/YOUR_USERNAME/router-control-app.git

# 6. push
git push -u origin main
```

### الخطوة 4: تشغيل GitHub Actions

#### أول مرة:
1. ادخل على الـ Repo
2. اضغط على "Actions" فوق
3. اضغط على "I understand my workflows, go ahead and enable them"

#### بناء APK:
1. اضغط على "Actions"
2. اختار "Build APK"
3. اضغط على "Run workflow"
4. اضغط على الزر الأخضر "Run workflow"

### الخطوة 5: تحميل APK

#### من Artifacts:
1. استنى 5-10 دقايق لحد ما الـ build يخلص
2. اضغط على الـ workflow اللي اشتغل
3. انزل لتحت
4. اضغط على "router-control-apk"
5. APK هينزل معاك

#### من Releases (لو عملت release):
1. اضغط على "Releases" على اليمين
2. اختار آخر release
3. اضغط على APK file
4. هينزل معاك

### الخطوة 6: تثبيت APK على Android

1. افتح ملف APK على الموبايل
2. لو ظهر "Install from unknown sources":
   - اضغط "Settings"
   - شغل "Allow from this source"
   - ارجع وثبت
3. اضغط "Install"
4. افتح التطبيق!

---

## 🎥 فيديو توضيحي (نصي)

### الشاشة 1: تسجيل الدخول
```
┌─────────────────────────┐
│     [Router Icon]       │
│     تحكم الراوتر        │
│                         │
│  نوع الراوتر: [ZTE ▼]  │
│  IP: [192.168.1.1  ]    │
│  Username: [admin    ]  │
│  Password: [••••••• ]  │
│                         │
│  [  تسجيل الدخول  ]    │
└─────────────────────────┘
```

### الشاشة 2: WiFi
```
┌─────────────────────────┐
│  إعدادات شبكة الواي فاي │
│                         │
│  SSID: [MyWiFi      ]   │
│  Password: [•••••••]   │
│  Channel: [6        ]   │
│  Encryption: [WPA2 ▼]  │
│                         │
│  [  حفظ الإعدادات  ]   │
└─────────────────────────┘
```

### الشاشة 3: الأجهزة
```
┌─────────────────────────┐
│  الأجهزة المتصلة (5)    │
│                         │
│ [📱] iPhone 12          │
│     IP: 192.168.1.5     │
│     MAC: AA:BB:CC...    │
│     [🚫 حظر]            │
│                         │
│ [💻] Laptop             │
│     IP: 192.168.1.6     │
│     MAC: DD:EE:FF...    │
│     [🚫 حظر]            │
└─────────────────────────┘
```

### الشاشة 4: الحظر
```
┌─────────────────────────┐
│  الأجهزة المحظورة (2)   │
│                         │
│ [🚫] Unknown Device     │
│     MAC: 11:22:33...    │
│     [✅ إلغاء الحظر]    │
│                         │
│ [🚫] Tablet             │
│     MAC: 44:55:66...    │
│     [✅ إلغاء الحظر]    │
└─────────────────────────┘
```

---

## 🆘 مشاكل شائعة وحلولها

### ❌ "Workflow not found"
**الحل:** تأكد إن ملف `.github/workflows/build_apk.yml` موجود

### ❌ "Build failed"
**الحل:** 
1. اضغط على الـ workflow
2. اضغط "Re-run jobs"
3. لو فشل تاني، افتح "Logs" وابعتلي الخطأ

### ❌ "APK not installing"
**الحل:**
1. شغل "Install from unknown sources"
2. أو استخدم `adb install app-release.apk`

### ❌ "Can't connect to router"
**الحل:**
1. تأكد إن الـ Backend شغال
2. تأكد من IP الراوتر
3. جرب تسجيل الدخول من المتصفح أولاً

---

## 📞 للمساعدة

لو واجهت أي مشكلة:
1. افتح "Issues" في الـ Repo
2. اكتب وصف المشكلة
3. أضف screenshots لو ممكن

---

**بالتوفيق! 🚀**
