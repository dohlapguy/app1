import 'package:app1/locator.dart';

import 'config/theme.dart';
import 'presentation/routes/route_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'presentation/blocs/auth_bloc/auth_bloc.dart';
import 'presentation/blocs/shop_bloc/shop_bloc.dart';
import 'data/repo_impl.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "App1",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();

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
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => locator<ShopBloc>(),
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
