import 'package:retail_app/data/API/models/product.dart';
import 'package:retail_app/data/Repositories/product_repository.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc {
  final ProductRepository _repository;
  final _productFetcher = PublishSubject<List<Product>>();

  Stream<List<Product>> get allProducts => _productFetcher.stream;

  ProductBloc({ProductRepository? repository})
      : _repository = repository ?? ProductRepository();

  Future<void> fetchAllProducts() async {
    try {
      List<Product> productModel = await _repository.fetchProducts();
      _productFetcher.sink.add(productModel);
    } catch (e) {
      _productFetcher.addError(e); // Add error to the stream in case of failure
    }
  }

  dispose() {
    _productFetcher.close();
  }
}

final bloc = ProductBloc();
