// استدعاء مكتبات الفايربيس اللازمة
importScripts("https://www.gstatic.com/firebasejs/10.7.1/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.7.1/firebase-messaging-compat.js");

// بيانات مشروعك (هتجيبها من Firebase Console -> Project Settings -> General -> Web App)
const firebaseConfig = {
  apiKey: "AIzaSy...", 
  authDomain: "your-app.firebaseapp.com",
  projectId: "your-project-id",
  storageBucket: "your-app.appspot.com",
  messagingSenderId: "123456789",
  appId: "1:123456789:web:abcdefgh"
};

// بدء تشغيل الفايربيس
firebase.initializeApp(firebaseConfig);

// تعريف خدمة الـ Messaging
const messaging = firebase.messaging();

// (اختياري) التعامل مع الرسائل في الخلفية
messaging.onBackgroundMessage((payload) => {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/icons/Icon-192.png' // تأكد من وجود مسار الأيقونة صح
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});