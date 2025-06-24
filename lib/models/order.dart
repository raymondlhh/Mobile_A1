import 'package:flutter/foundation.dart';

class OrderDetail {
  final String name;
  final String price;
  final int quantity;
  final String imagePath;

  OrderDetail({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'imagePath': imagePath,
    };
  }

  factory OrderDetail.fromMap(Map<String, dynamic> map) {
    return OrderDetail(
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      quantity: map['quantity'] ?? 0,
      imagePath: map['imagePath'] ?? '',
    );
  }
}

class Order {
  final String userName;
  final String userEmail;
  final String userPhone;
  final String userAddress;
  final double total;
  final DateTime timestamp;
  final List<OrderDetail> details;

  Order({
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.userAddress,
    required this.total,
    required this.timestamp,
    required this.details,
  });

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'userAddress': userAddress,
      'total': total,
      'timestamp': timestamp.toIso8601String(),
      'details': details.map((d) => d.toMap()).toList(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      userName: map['userName'] ?? '',
      userEmail: map['userEmail'] ?? '',
      userPhone: map['userPhone'] ?? '',
      userAddress: map['userAddress'] ?? '',
      total: (map['total'] ?? 0).toDouble(),
      timestamp: DateTime.parse(map['timestamp']),
      details:
          (map['details'] as List<dynamic>?)
              ?.map((d) => OrderDetail.fromMap(d))
              .toList() ??
          [],
    );
  }
}
