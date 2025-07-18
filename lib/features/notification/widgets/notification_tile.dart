import 'package:flutter/material.dart';
import 'package:takip/core/constant/localization_helper.dart';

class NotificationTile extends StatelessWidget {
  final String message;
  final String date;
  final VoidCallback refresh;

  const NotificationTile({
    super.key,
    required this.message,
    required this.date,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.error, color: Colors.red),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalizationHelper.l10n.hatalikayitislemi,
            style: TextStyle(color: Colors.redAccent, fontSize: 16),
          ),
          if (message.isNotEmpty) Text(message),
          SizedBox(height: 10),
          if (message.isNotEmpty) Text(date),
        ],
      ),
      trailing: IconButton(onPressed: refresh, icon: Icon(Icons.refresh)),
    );
  }
}
