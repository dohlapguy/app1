import 'package:app1/presentation/routes/route_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/blocs/auth_bloc/auth_bloc.dart';
import 'business_logic/blocs/product_bloc/product_bloc.dart';
import 'business_logic/blocs/shop_bloc/shop_bloc.dart';
import 'data/repo.dart';
import 'data/repository/phone_auth_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProductRepo(),
        ),
        RepositoryProvider(
          create: (context) => ShopRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) =>
                ShopBloc(shopRepo: RepositoryProvider.of<ShopRepo>(context)),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: Routes().router,
        ),
      ),
    );
  }
}
