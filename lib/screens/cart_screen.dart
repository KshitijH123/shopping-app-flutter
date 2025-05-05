import 'package:flutter/material.dart';
import 'package:interview_practice/model/product.dart';
import 'package:interview_practice/screens/order_confirmation.dart';
import 'package:interview_practice/widget/add_to_cart_button.dart';

class CartScreen extends StatefulWidget {
  final List<Product> products;

  const CartScreen({super.key, required this.products});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _addressController = TextEditingController();

  double getTotal() {
    double total = 0;
    for (final product in widget.products) {
      total += product.price * product.quantity;
    }

    return total;
  }

  int getTotalQuantity() {
    int totalQty = 0;
    for (var product in widget.products) {
      totalQty += product.quantity;
    }
    return totalQty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.products.length,
              itemBuilder: (context, index) {
                final product = widget.products[index];

                return ListTile(
                  leading: Image.network(product.imageUrl),
                  title: Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: BorderSide.strokeAlignCenter,
                    ),
                    child: AddToCartButton(
                      product: product,
                      onQuantityChange: () {
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Total : ₹ ${getTotal().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  prefixIcon: Icon(Icons.home_outlined),
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: LinearBorder(),
                  backgroundColor: Colors.greenAccent,
                  minimumSize: Size(double.infinity, 50),
                ),
                onPressed: () {
                  if (_addressController.text.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => OrderConfirmation(
                              products: widget.products,
                              address: _addressController.text,
                              quantity: getTotalQuantity(),
                              total: getTotal(),
                            ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please Enter Your Address')),
                    );
                  }
                },
                child: Text('Payment', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
