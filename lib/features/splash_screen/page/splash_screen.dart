import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rivo_app/core/constant/colors.dart';
import 'package:rivo_app/core/constant/info_widget.dart';
import 'package:rivo_app/core/constant/routes.dart';
import 'package:rivo_app/features/splash_screen/bloc/splash_bloc.dart';
import 'package:rivo_app/injection.dart';

import '../../../core/widgets/background_splash.dart';
import '../widgets/body_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashBloc splashBloc;
  @override
  void initState() {
    splashBloc = sl<SplashBloc>()..add(CheckAuthEvent());
    super.initState();
  }
  

  @override
  void didChangeDependencies() async {
  
    super.didChangeDependencies();
  }
   @override
  void dispose() async{
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: splashBloc,
      child: Scaffold(
        backgroundColor: AppColors.primaryColorGreenAcssent,
        body: BlocConsumer<SplashBloc, SplashState>(builder: (context, state) {
          return InfoWidget(builder: (context, deviceType) {
            return SizedBox(
              height: deviceType.screenHeight,
              width: deviceType.screenWidth,
              child: const Stack(
                alignment: Alignment.center,
                children: [
                  CustomBackGroundSplash(),
                  CustomBodySplashScreen(),
                ],
              ),
            );
          });
        }, listener: (context, state) async {
          if (state.authStatus == AuthStatus.auth) {
     await Future.delayed(const Duration(seconds: 3));
            context.goNamed(AppRouter.home);
          } else if (state.authStatus == AuthStatus.unAuth) {
     await Future.delayed(const Duration(seconds: 3));

            context.pushReplacementNamed(AppRouter.login);
          }
        }),
      ),
    );
  }
}
