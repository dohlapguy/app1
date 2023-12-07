import 'package:app1/locator.dart';

import 'config/theme.dart';
import 'presentation/cubit/auth_cubit.dart';
import 'presentation/routes/route_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:app1/presentation/blocs/phone_auth_bloc/phone_auth_bloc.dart';
import 'presentation/blocs/shop_bloc/shop_bloc.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<PhoneLoginAuthBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<AuthCubit>(),
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
    );
  }
}
