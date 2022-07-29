import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../model/NotificationSummary.dart';

class NotificationDetailPage extends StatelessWidget {
  const NotificationDetailPage(this._notificationSummary, {Key? key})
      : super(key: key);

  final NotificationSummary _notificationSummary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(_notificationSummary.title,
            style: const TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        // child: Text(_notificationSummary.description),
        child: Html(
            data:
            "<p><b>親愛的會員們，您好～</b><br><br>2022/<b>05/29 凌晨AM1:00至AM04:00</b>因應銀行端金流系統升級作業，<br><br><b>此時段暫停信用卡服務，</b>"
                "還請見諒，請避開此時段新增訂單刷卡，感謝您的支持，謝謝。<br><br><b>Cutaway 卡個位 謝謝您</b><p>"),
      ),
    );
  }
}
