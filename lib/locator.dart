import 'package:app1/data/datasource/product_data_source.dart';
import 'package:app1/data/datasource/shop_data_source.dart';
import 'package:app1/data/repo_impl.dart';
import 'package:app1/domain/repository/product_repo.dart';
import 'package:app1/domain/repository/shop_repo.dart';
import 'package:app1/domain/usecases/product_usecases/get_product_by_id_usecase.dart';
import 'package:app1/domain/usecases/product_usecases/get_products_of_shop.dart';
import 'package:app1/domain/usecases/shop_usecases/get_shop_by_id.dart';
import 'package:app1/domain/usecases/shop_usecases/get_shops.dart';
import 'package:app1/presentation/blocs/product_detail_bloc/product_detail_bloc.dart';
import 'package:app1/presentation/blocs/product_list_bloc/product_list_bloc.dart';
import 'package:app1/presentation/blocs/shop_bloc/shop_bloc.dart';
import 'package:app1/presentation/blocs/shop_detail_bloc/shop_detail_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';

import 'core/network/network_info.dart';

final locator = GetIt.instance;

Future<void> init() async {
  //! BLoC
  locator.registerFactory(
      () => ProductDetailBloc(getProductByIdUsecase: locator()));

  locator.registerFactory(
      () => ProductListBloc(getProductsOfShopUsecase: locator()));

  locator.registerFactory(() => ShopBloc(getShopsUsecase: locator()));

  locator
      .registerFactory(() => ShopDetailBloc(getShopDetailsUsecase: locator()));

  //! UseCases
  locator.registerLazySingleton(
    () => GetProductByIdUsecase(productRepo: locator()),
  );
  locator.registerLazySingleton(
    () => GetProductsOfShopUsecase(productRepo: locator()),
  );

  locator.registerLazySingleton(
    () => GetShopDetailsUsecase(shopRepo: locator()),
  );

  locator.registerLazySingleton(
    () => GetShopsUsecase(shopRepo: locator()),
  );

  //! Repositories
  locator.registerLazySingleton<ProductRepo>(() =>
      ProductRepoImpl(networkInfo: locator(), productDataSource: locator()));

  locator.registerLazySingleton<ShopRepo>(
      () => ShopRepoImpl(networkInfo: locator(), shopDataSource: locator()));

  //! Data Source
  locator.registerLazySingleton<ProductDataSource>(
    () => ProductDataSourceImpl(),
  );

  locator.registerLazySingleton<ShopDataSource>(
    () => ShopDataSourceImpl(),
  );

  //! Core
  locator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: locator()),
  );

  //! External Libraries
  locator.registerLazySingleton(() => Connectivity());

  //! Storage
}
