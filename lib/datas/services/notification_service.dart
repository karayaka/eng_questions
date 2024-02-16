import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  //static final onTabNotification= BehaviorSubject<String?>();//rxdart paketi yüklenip notificationun click eveti dinleniyor

  static final FlutterLocalNotificationsPlugin _notification =
      FlutterLocalNotificationsPlugin();
  static init() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'chanelid', // id
      'chanel name', // title// description
      importance: Importance.max,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    await _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid);
    _notification.initialize(initializationSettings);
        //onSelectNotification: (String? payload) {});
  }

  static Future showNotification(
      {String title = "", String body = "", String payload = ""}) async {
    try {
      var random =
          Random(); // keep this somewhere in a static variable. Just make sure to initialize only once.
      final notificationid = random.nextInt(1000);
      await _notification.show(
          notificationid, title, body, _notificationDetail(),
          payload: payload);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future showShceduledNotification({
    String title = "",
    String body = "",
    String payload = "",
    required DateTime date,
  }) async {
    try {
      var random =
          Random(); // keep this somewhere in a static variable. Just make sure to initialize only once.
      final notificationid = random.nextInt(1000);
      await _notification.zonedSchedule(
        notificationid,
        title,
        body,
        tz.TZDateTime.from(date, tz.local),
        _notificationDetail(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: payload,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  static Future showPeriodicallyNotification({
    String title = "",
    String body = "",
    String payload = "",
  }) async {
    try {
      var random =
          Random(); // keep this somewhere in a static variable. Just make sure to initialize only once.
      final notificationid = random.nextInt(1000);
      await _notification.periodicallyShow(notificationid, title, body,
          RepeatInterval.daily, _notificationDetail());
    } catch (e) {
      print(e.toString());
    }
  }

  /*static Future<void> display(RemoteMessage message) async {
    try{
      await showNotification(
        title: message.notification!.title??"",
        body: message.notification!.body??"",
        payload: message.data["route"]??"",
      );
    }catch(e){
      print(e.toString());
    }

  }*/

  static _notificationDetail() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "chanelid",
        "chanel name",
        importance: Importance.max,
        playSound: true,
      ),
      //iOS: IOSNotificationDetails(),
    );
  }
}
