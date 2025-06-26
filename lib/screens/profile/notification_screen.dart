import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';
import '../../services/notification_service.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> notifications = [];
  final NotificationService _notificationService = NotificationService();

  Future<void> loadNotifications() async {
    final loaded = await _notificationService.getNotifications();
    setState(() {
      notifications = loaded;
    });
  }

  void markAllAsRead() async {
    await _notificationService.markAllAsRead();
    await loadNotifications();
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    onTickPressed = markAllAsRead;
    loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        'NOTIFICATIONS',
        actionType: AppBarActionType.readButton,
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, index) {
          final item = notifications[index];
          final isUnread = !item.isRead;

          return GestureDetector(
            onTap: () async {
              item.isRead = true;
              await _notificationService.saveNotifications(notifications);
              setState(() {});
            },
            child: Container(
              color: isUnread ? const Color(0xFF8AB98F) : Colors.transparent,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w900,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.description,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.date,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item.time,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
