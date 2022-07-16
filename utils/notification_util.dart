import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notetask/core/utils/file_operation_util.dart';
import 'package:notetask/core/utils/navigation_utils.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:rxdart/subjects.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../../main.dart';

class NotificationService {

  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {

    return _notificationService;
    
  }
 


  // Notification Instance Creating 
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


  // Sigleton Creating 
  NotificationService._internal();

  // Behaviour 
  // final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  



  // Initialization 
  Future<void> initNotification() async {

    // Android Initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings('@drawable/ic_flutternotification');
    
    // IOS Initialization
    const IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    // Combine Adnroid & IOS Settings into main InitializationSettings
    const InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS
    );
    
    tz.initializeTimeZones();

    // Final Initialization of settings 
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification:(payload){   
           RouterServices.pushName('/settingPage');
    });

    st('Flutter LocalNotification Plugin is initialized');
  }


  // Easy Abstraction Method
  Future<void> showNotification(int id, String title, String body, int seconds) async {
    debugConsole('showNotification Function Entry');

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'main_channel',
          'Main Channel',
          importance: Importance.max,
          priority: Priority.max,
          icon: '@drawable/ic_flutternotification'
        ),
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );

  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }



    }