import 'package:flutter/material.dart';
import 'package:retail_app/blocs/product_bloc.dart';

import '../data/API/models/product.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Products'),
      ),
      body: StreamBuilder(
          stream: bloc.allProducts,
          builder: (context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              return buildList(snapshot);
            } else {
              return Text(snapshot.error.toString());
            }
          }),
    );
  }

  Widget buildList(AsyncSnapshot<List<Product>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (context, index) {
        final product = snapshot.data?[index] ?? Product();
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with bold formatting
                Text(
                  product.commonName ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                // Description with bullet points
                Text(
                  product.description ?? 'No description',
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 8.0),
                // Sale price with bold formatting
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Sale Price: ',
                        style: TextStyle(fontSize: 16.0, color: Colors.green),
                      ),
                      TextSpan(
                        text: '${product.salePrice?.toString()} Bs',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
