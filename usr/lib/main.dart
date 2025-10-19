import 'package:flutter/material.dart';
import 'models/product_model.dart';
import 'screens/home_screen.dart';
import 'screens/products_screen.dart';
import 'screens/add_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Holy Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFf0f2f5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1e3a5f),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Color(0xFFd4af37),
          unselectedItemColor: Colors.grey,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFd4af37),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFd4af37)),
          ),
        ),
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _initializeDefaultProducts();
  }

  void _initializeDefaultProducts() {
    if (_products.isEmpty) {
      setState(() {
        _products.addAll([
          Product(
            id: '1',
            name: 'תפילין בעור',
            price: 150,
            description: 'תפילין איכותיים בעור אמיתי, מעוטרים בנוצר קלאסי',
            image: 'https://via.placeholder.com/300x200?text=Tefillin',
            category: 'תפילה',
          ),
          Product(
            id: '2',
            name: 'מגילת אסתר',
            price: 200,
            description: 'מגילה עתיקה בכתב יד, משומרת בתיבה עתיקה',
            image: 'https://via.placeholder.com/300x200?text=Megillah',
            category: 'מגילות',
          ),
          Product(
            id: '3',
            name: 'נרות שבת',
            price: 45,
            description: 'סט של 2 נרות שבת מעוטרים, בעלי ריח מנחם',
            image: 'https://via.placeholder.com/300x200?text=Candles',
            category: 'נרות',
          ),
          Product(
            id: '4',
            name: 'ספל קידוש',
            price: 80,
            description: 'ספל מכסף טהור עם חרוטים יהודיים מסורתיים',
            image: 'https://via.placeholder.com/300x200?text=Kiddush',
            category: 'כלים',
          ),
        ]);
      });
    }
  }

  void _addProduct(Product product) {
    setState(() {
      _products.add(product);
    });
    _onItemTapped(1); // Switch to products screen after adding
  }

  void _deleteProduct(String id) {
    setState(() {
      _products.removeWhere((product) => product.id == id);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return ProductsScreen(products: _products, deleteProduct: _deleteProduct);
      case 2:
        return AddProductScreen(onAddProduct: _addProduct);
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Holy Shop'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: _buildBody(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'בית',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'מוצרים',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'הוסף מוצר',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
