import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final Dio _dio = Dio();

  // Note: In a real-world app, you should send notifications from a backend/Cloud Function
  // for security reasons (to avoid exposing your Server Key).
  // For demonstration, we'll outline the logic.
  
  Future<void> init() async {
    // Request permissions (already handled in main.dart but good to have here)
    await _fcm.requestPermission();

    // Get token for this device (useful for individual notifications)
    String? token = await _fcm.getToken();
    if (kDebugMode) {
      print("FCM Token: $token");
    }

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("Received foreground message: ${message.notification?.title}");
      }
    });
  }

  Future<void> subscribeToGroup(String groupName) async {
    // Standardize topic name: remove spaces and special chars
    String topic = groupName.replaceAll(' ', '_').toLowerCase();
    await _fcm.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromGroup(String groupName) async {
    String topic = groupName.replaceAll(' ', '_').toLowerCase();
    await _fcm.unsubscribeFromTopic(topic);
  }

  Future<void> sendNotification({
    required String title,
    required String body,
    required String targetGroup,
  }) async {
    // Standardize topic name
    String topic = targetGroup == 'All' ? 'all_students' : targetGroup.replaceAll(' ', '_').toLowerCase();

    // Since we don't have a backend set up in this snippet, we'll log it.
    // To actually send from the app, you'd need the FCM V1 API with a Service Account Token.
    if (kDebugMode) {
      print("Simulating sending push notification to topic: $topic");
      print("Title: $title");
      print("Body: $body");
    }

    // Example of what the V1 API call would look like (requires OAuth2 token)
    /*
    try {
      await _dio.post(
        'https://fcm.googleapis.com/v1/projects/YOUR_PROJECT_ID/messages:send',
        data: {
          "message": {
            "topic": topic,
            "notification": {
              "title": title,
              "body": body
            },
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              "type": "announcement"
            }
          }
        },
        options: Options(headers: {
          "Authorization": "Bearer YOUR_ACCESS_TOKEN",
          "Content-Type": "application/json",
        }),
      );
    } catch (e) {
      print("Error sending notification: $e");
    }
    */
  }
}

final notificationServiceProvider = NotificationService();
