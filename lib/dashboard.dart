import 'package:flutter/material.dart';
import 'cart.dart'; // Ensure this path is correct
import 'detail.dart'; // Import the detail page

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> products = [
    {
      'name': 'ROG Strix G15',
      'price': 1098.00,
      'brand': 'Asus ROG',
      'image': 'images/rog-strix-g15.png',
    },
    {
      'name': 'ROG Strix G17',
      'price': 1999.00,
      'brand': 'Asus ROG',
      'image': 'images/rog-strix-g17.png',
    },
    {
      'name': 'ROG Strix Scar15',
      'price': 1299.00,
      'brand': 'Asus ROG',
      'image': 'images/rog-strix-scar15.png',
    },
    {
      'name': 'ROG Strix Scar17',
      'price': 3699.00,
      'brand': 'Asus ROG',
      'image': 'images/rog-strix-scar17.webp',
    },
    {
      'name': 'ROG Zephyrus Duo16',
      'price': 4399.00,
      'brand': 'Asus ROG',
      'image': 'images/rog-zephyrus-duo16.png',
    },
    {
      'name': 'ROG Zephyrus G14',
      'price': 1429.00,
      'brand': 'Asus ROG',
      'image': 'images/rog-zephyrus-g14.png',
    },
  ];

  List<CartItem> cartItems = []; // To hold cart items

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void addToCart(CartItem item) {
    setState(() {
      cartItems.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.menu),
            SizedBox(width: 16),
            Text("Shop"),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: "Asus ROG"),
            Tab(text: "Asus TUF"),
            Tab(text: "Acer"),
            Tab(text: "Accessories"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildProductGrid(),
          const Center(child: Text("Asus TUF Products")),
          const Center(child: Text("Acer Products")),
          const Center(child: Text("Accessories")),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.home, size: 30, color: Colors.black),
                SizedBox(width: 8),
                Text('Home', style: TextStyle(color: Colors.black)),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.favorite_outline, size: 30),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.shopping_bag_outlined, size: 30),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(cartItems: cartItems),
                  ),
                );
              },
            ),
            const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('images/sandey.jpg.png'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return buildProductCard(products[index]);
        },
      ),
    );
  }

  Widget buildProductCard(Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              product: product,
              cartItems: cartItems,
              addToCart: addToCart, // Pass the addToCart function
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.asset(product['image'], fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text('\$${product['price'].toString()}'),
                      const SizedBox(height: 4),
                      Text(product['brand']),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  // Handle favorite action
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
