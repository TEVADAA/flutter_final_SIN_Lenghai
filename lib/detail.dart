import 'package:flutter/material.dart';
import 'cart.dart';

class DetailPage extends StatelessWidget {
  final Map<String, dynamic> product;
  final List<CartItem> cartItems;
  final Function(CartItem) addToCart; // Callback to add item to cart

  DetailPage({
    required this.product,
    required this.cartItems,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(product['image']),
            const SizedBox(height: 16),
            Text(
              product['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('\$${product['price'].toString()}',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Create a CartItem from the product and add it to the cart
                addToCart(CartItem(
                  name: product['name'],
                  price: product['price'],
                  size: 'M', // Placeholder size
                  color: Colors.black, // Placeholder color
                  image: product['image'],
                ));
                Navigator.pop(context); // Go back to the dashboard
              },
              child: const Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}
