import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Modelo de Producto
class Product {
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}

class ProductsPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para obtener los productos desde Firestore
  Stream<List<Product>> getProducts() {
    return _firestore.collection('products').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return Product(
            name: doc['name'],
            description: doc['description'],
            price: doc['price'].toDouble(),
            quantity: doc['cantidad'],
            imageUrl: doc['image'],
          );
        }).toList();
      },
    );
  }

  // Función para cerrar sesión
  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      // Si la sesión se cierra, volvemos a la pantalla de login
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      print('Error al cerrar sesión: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos'),
      ),
      body: Column(
        children: [
          // StreamBuilder para mostrar los productos
          Expanded(
            child: StreamBuilder<List<Product>>(
              stream: getProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error al cargar productos'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No hay productos disponibles'));
                } else {
                  final products = snapshot.data!;

                  return ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];

                      return Card(
                        child: ListTile(
                          leading: Image.network(
                            product.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(product.name),
                          subtitle: Text(product.description),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('\$${product.price.toStringAsFixed(2)}'),
                              Text('Stock: ${product.quantity}'),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          // Botón de cerrar sesión centrado
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: ElevatedButton(
                onPressed: () => signOut(context),
                child: Text(
                  'Cerrar sesión',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Color rojo para resaltar el botón
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

