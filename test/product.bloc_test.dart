import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:retail_app/data/API/models/product.dart';
import 'package:retail_app/data/Repositories/product_repository.dart';
import 'package:retail_app/blocs/product_bloc.dart';
import 'package:mockito/annotations.dart';

final List<Product> mockProducts = [
  Product(id: '1', code: 'Product 1'),
  Product(id: '2', code: 'Product 2'),
];

class MockProductRepository extends Mock implements ProductRepository {
  @override
  Future<List<Product>> fetchProducts() async {
    return mockProducts;
  }
}

class FailMockProductRepository extends Mock implements ProductRepository {
  @override
  Future<List<Product>> fetchProducts() async {
    throw Exception("error during fetching");
  }
}

@GenerateMocks([MockProductRepository])
void main() {
  group('ProductBloc', () {
    late ProductBloc bloc;
    ProductRepository mockRepository;

    setUp(() {});

    tearDown(() {
      bloc.dispose();
    });

    test('fetchAllProducts emits list of products', () async {
      //WHERE
      mockRepository = MockProductRepository();
      bloc = ProductBloc(repository: mockRepository);

      //WHEN
      bloc.fetchAllProducts();
      final emittedProducts = await bloc.allProducts.first;

      // Assert that the emitted value matches the expected value
      expect(emittedProducts, mockProducts);
    });

    test('fetchAllProducts handles errors', () async {
      //WHERE
      mockRepository = FailMockProductRepository();
      bloc = ProductBloc(repository: mockRepository);
      //WHEN
      bloc.fetchAllProducts();
      //Assert
      await expectLater(bloc.allProducts, emitsError(isInstanceOf<Exception>()));
    });
  });
}
