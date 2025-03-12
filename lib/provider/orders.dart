import 'dart:convert';

import 'package:flutter/foundation.dart';
import './cart_provider.dart';
import 'package:http/http.dart' as http;

class OrderItems {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItems({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItems> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this._orders, this.userId);

  List<OrderItems> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async {
    final url = Uri.parse(
        'https://e-commerce-app-d3be8-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    try {
      final response = await http.get(url);
      if (response.statusCode >= 400) {
        throw Exception('Failed to fetch orders.');
      }
      final extractedData = json.decode(response.body);
      if (extractedData == null) {
        return;
      }
      final List<OrderItems> loadedOrders = [];
      final dataMap = extractedData as Map<String, dynamic>;
      dataMap.forEach((orderId, orderData) {
        loadedOrders.add(
          OrderItems(
            id: orderId,
            amount: orderData['amount'],
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                      id: item['id'],
                      title: item['title'],
                      price: item['price'],
                      quantity: item['quantity'],
                    ))
                .toList(),
            dateTime: DateTime.parse(orderData['dateTime']),
          ),
        );
      });
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw Exception('Failed to fetch orders: $error');
    }
  }

  Future<void> addOder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://e-commerce-app-d3be8-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final timeStamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price,
                  })
              .toList(),
        }));
    _orders.insert(
      0,
      OrderItems(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timeStamp,
      ),
    );
    notifyListeners();
  }
}
