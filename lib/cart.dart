import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;

  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _removeItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }

  void _updateQuantity(int index, int quantity) {
    setState(() {
      if (quantity > 0) {
        widget.cartItems[index].quantity = quantity;
      } else {
        widget.cartItems.removeAt(index);
      }
    });
  }

  void _handlePayment() {
    // Show payment confirmation dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          content: const Text('Your payment has been processed.'),
          actions: [
            TextButton(
              onPressed: () {
                // Clear the cart and navigate back
                setState(() {
                  widget.cartItems.clear(); // Clear all items
                });
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Navigate back to dashboard
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: widget.cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartItemWidget(
                        cartItem: widget.cartItems[index],
                        onRemove: () => _removeItem(index),
                        onUpdateQuantity: (quantity) =>
                            _updateQuantity(index, quantity),
                      );
                    },
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Price',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                          '\$${widget.cartItems.fold(0.0, (sum, item) => sum + item.price * item.quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50)),
                    onPressed: _handlePayment,
                    child: const Text('Payment',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
    );
  }
}

class CartItem {
  final String name;
  final double price;
  final String size;
  final Color color;
  final String image;
  int quantity; // Add quantity to track how many of this item

  CartItem({
    required this.name,
    required this.price,
    required this.size,
    required this.color,
    required this.image,
    this.quantity = 1, // Default quantity is 1
  });
}

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;
  final Function(int) onUpdateQuantity;

  CartItemWidget({
    required this.cartItem,
    required this.onRemove,
    required this.onUpdateQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        children: [
          Image.asset(cartItem.image, width: 70, height: 70),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartItem.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text('\$${cartItem.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (cartItem.quantity > 1) {
                          onUpdateQuantity(cartItem.quantity - 1);
                        } else {
                          onRemove();
                        }
                      },
                    ),
                    Text('${cartItem.quantity}',
                        style: const TextStyle(fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        onUpdateQuantity(cartItem.quantity + 1);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
