import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_firebase_app/utils/utils.dart';

class NotificationsServices {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  void requestNotificationPermission()async{
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true
    );

    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      return Utils().toastmessage('User Permssion Granted');
    }else if(settings.authorizationStatus == AuthorizationStatus.authorized){
      return Utils().toastmessage('User Provisional Permssion Granted');
    }else{
      return Utils().toastmessage('Permssion Denied');
    }
  }
}