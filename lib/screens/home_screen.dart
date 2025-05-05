import 'package:flutter/material.dart';
import 'package:interview_practice/model/product.dart';
import 'package:interview_practice/screens/cart_screen.dart';
import 'package:interview_practice/widget/add_to_cart_button.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Product> products = [
    Product(
      name: 'product 1',
      price: 100.99,
      imageUrl:
          'https://i.pinimg.com/564x/7a/0b/8e/7a0b8e716ff86321c989fa5c3802dec5.jpg',
    ),
    Product(
      name: 'product 2',
      price: 150.50,
      imageUrl:
          'https://media.istockphoto.com/id/1354031012/photo/red-t-shirt-mockup-men-as-design-template-tee-shirt-blank-isolated-on-white-front-view.jpg?s=612x612&w=0&k=20&c=_5QLLkUa0-ZzSK1rp6Ie-ZRBPOEku4as4ZMrZg-y2GI=',
    ),
    Product(
      name: 'product 3',
      price: 120.00,
      imageUrl:
          'https://i.pinimg.com/736x/bd/ef/cb/bdefcbc72735f64db17f3250b1e64245.jpg',
    ),
    Product(
      name: 'product 4',
      price: 180.50,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShxqfanJ0ztwBQz_j58ZxsMi0lvG3bNK7XMQ&s',
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Product List',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () async {
                final List<Product> cart =
                    products.where((product) => product.quantity != 0).toList();

                if (cart.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Center(
                        child: Text(
                          'Your cart is empty!',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      backgroundColor: Colors.red,
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartScreen(products: cart,),
                    ),
                  );

                  setState(() {});
                }
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            childAspectRatio: 0.62,
          ),
          itemBuilder: (context, index) {
            final product = products[index];

            return Card(
              elevation: 2,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    product.imageUrl,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(product.name),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      '₹ ${product.price.toStringAsFixed(2)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: AddToCartButton(
                      product: product,
                      mainAxisSize: MainAxisSize.max,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
