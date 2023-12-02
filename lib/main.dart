import 'package:app1/config/theme.dart';
import 'package:app1/presentation/routes/route_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'business_logic/blocs/auth_bloc/auth_bloc.dart';
import 'business_logic/blocs/shop_bloc/shop_bloc.dart';
import 'data/repo.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "App1",
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
        child: ScreenUtilInit(
            minTextAdapt: true,
            designSize: const Size(390, 844),
            builder: (context, child) {
              return MaterialApp.router(
                theme: theme(),
                debugShowCheckedModeBanner: false,
                routerConfig: Routes().router,
              );
            }),
      ),
    );
  }
}
