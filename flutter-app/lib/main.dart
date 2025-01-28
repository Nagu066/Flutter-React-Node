import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter React App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  Future<void> login() async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.3:5000/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': usernameController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await storage.write(key: 'token', value: data['token']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderPage()),
        );
      } else {
        showMessage('Login failed');
      }
    } catch (e) {
      showMessage('An error occurred: $e');
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: usernameController, decoration: InputDecoration(labelText: 'Username')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
            SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: Text('Login')),
          ],
        ),
      ),
    );
  }
}

class OrderPage extends StatelessWidget {
  final productController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final storage = FlutterSecureStorage();

  Future<void> submitOrder() async {
    try {
      final token = await storage.read(key: 'token');
      final response = await http.post(
        Uri.parse('http://192.168.1.3:5000/order'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'token': token,
          'order': {
            'productName': productController.text,
            'quantity': int.parse(quantityController.text),
            'price': double.parse(priceController.text),
          },
        }),
      );

      if (response.statusCode == 200) {
        showMessage('Order submitted');
      } else {
        showMessage('Failed to submit order');
      }
    } catch (e) {
      showMessage('An error occurred: $e');
    }
  }

  void showMessage(String message) {
    print(message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: productController, decoration: InputDecoration(labelText: 'Product Name')),
            TextField(controller: quantityController, decoration: InputDecoration(labelText: 'Quantity'), keyboardType: TextInputType.number),
            TextField(controller: priceController, decoration: InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
            SizedBox(height: 20),
            ElevatedButton(onPressed: submitOrder, child: Text('Submit Order')),
          ],
        ),
      ),
    );
  }
}
