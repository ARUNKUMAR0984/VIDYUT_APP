import 'package:flutter/foundation.dart';

class Address {
  final String id;
  final String label; // e.g., Home, Office
  final String line1;
  final String line2;
  final String city;
  final String state;
  final String pincode;
  final String contactName;
  final String contactPhone;

  const Address({
    required this.id,
    required this.label,
    required this.line1,
    required this.line2,
    required this.city,
    required this.state,
    required this.pincode,
    required this.contactName,
    required this.contactPhone,
  });
}

class CartItem {
  final String productId;
  final String name;
  final int quantity;
  final double price; // numeric for calculations

  const CartItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  double get total => quantity * price;
}

enum OrderStatus { placed, accepted, shipped, completed }

class Order {
  final String id;
  final List<CartItem> items;
  final DateTime createdAt;
  final String seller;
  final OrderStatus status;
  final Address shippingAddress;

  const Order({
    required this.id,
    required this.items,
    required this.createdAt,
    required this.seller,
    required this.status,
    required this.shippingAddress,
  });

  double get totalAmount => items.fold(0.0, (sum, item) => sum + item.total);
}

class AppNotification {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final bool read;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.read = false,
  });
}








