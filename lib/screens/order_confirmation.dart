import 'dart:math';

import 'package:flutter/material.dart';
import 'package:interview_practice/model/product.dart';

class OrderConfirmation extends StatefulWidget {
  final List<Product> products;
  final String address;
  final int quantity;
  final double total;

  const OrderConfirmation({
    super.key,
    required this.products,
    required this.address,
    required this.quantity,
    required this.total,
  });

  @override
  State<OrderConfirmation> createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  int orderNumber = 0;

  @override
  void initState() {
    super.initState();
    orderNumber = 1000 + Random().nextInt(9000);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Order Confirmation',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Order Number :',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '$orderNumber',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Order Details:',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.products.length,
                itemBuilder: (context, index) {
                  final product = widget.products[index];
                  return ListTile(
                    leading: Image.network(product.imageUrl, height: 40),
                    title: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '₹${product.price} x ${product.quantity} = ₹${product.price * product.quantity}',
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Shipping Details :',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.location_pin),
                title: Text(widget.address, style: TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total : ₹ ${widget.total}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: LinearBorder(),
                    backgroundColor: Colors.greenAccent,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Payment Successfull'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  child: Text(
                    'Pay',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
