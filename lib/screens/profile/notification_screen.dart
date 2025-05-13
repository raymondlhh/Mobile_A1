import 'package:flutter/material.dart';
import '../../widgets/title_appbar.dart';

class NotificationItem {
  final String name;
  final String description;
  final String date;
  final String time;
  bool isRead;

  NotificationItem({
    required this.name,
    required this.description,
    required this.date,
    required this.time,
    this.isRead = false,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<NotificationItem> notifications = [
    NotificationItem(
      name: 'Points Earned',
      description: '15 points has been successfully earned',
      date: '6 May 2025',
      time: '9:30 AM',
    ),
    NotificationItem(
      name: 'Payment Successful',
      description: 'RM 15.00 has been successfully paid',
      date: '6 May 2025',
      time: '9:26 AM',
      isRead: true,
    ),
    NotificationItem(
      name: 'Payment Failed',
      description: 'RM 15.00 payment has failed',
      date: '6 May 2025',
      time: '9:20 AM',
    ),
    NotificationItem(
      name: 'Top-Up Failed',
      description: 'RM 100.00 top-up has failed',
      date: '6 May 2025',
      time: '9:20 AM',
    ),
    NotificationItem(
      name: 'Top-Up Successful',
      description: 'RM 100.00 has been successfully topped-up',
      date: '6 May 2025',
      time: '9:20 AM',
    ),
  ];

  void markAllAsRead() {
    setState(() {
      for (var item in notifications) {
        item.isRead = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    onTickPressed = markAllAsRead;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context,
        'NOTIFICATION',
        actionType: AppBarActionType.readButton,
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (context, index) {
          final item = notifications[index];
          final isUnread = !item.isRead;

          return GestureDetector(
            onTap: () => setState(() => item.isRead = true),
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
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.black,
                            // color: item.name == 'Points Earned'
                            //     ? const Color(0xFFD03E27)
                            //     : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.description,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
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
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item.time,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
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
