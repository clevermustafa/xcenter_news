import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:xcenter_news/core/network/network_utils.dart';

import '../../core/resources/app_url.dart';

abstract class NotificationRemoteDataSource {
  Future<void> sendNotification();
}
@LazySingleton(as: NotificationRemoteDataSource)
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  NetworkUtil networkUtil;
  NotificationRemoteDataSourceImpl(this.networkUtil);
  @override
  Future<void> sendNotification() async {
    final data = {
      "notification": {"body": "Hi this is body", "title": "From Test"},
      "priority": "high",
      "data": {
        "id": "1",
        "status": "done",
        "message": "this is body",
      },
      "to": "/topics/notTest"
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAA_CMI2nE:APA91bERpCBUtd7ENbGH0GgwPbLwSTSciRsnhf7NxP20nifulmorKD68UmAU7buxYt5m5kpZid2SVPC10akBB714ApcUwX_9FuVhd6W9pNAgvAGfNR8vP8XR-tfINeQx7W7ziXeb2Cg0'
    };
    try {
      final response = await networkUtil.post(
        AppUrl.fcmUrl,
        headers: headers,
        data: data,
      );
      if (response.statusCode == 200) {
        debugPrint("Notification sent successfully");
      } else {
        debugPrint('notification sending failed');
        // on failure do sth
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
