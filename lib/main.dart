import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:rivo_app/app_router.dart';
import 'package:rivo_app/core/constant/colors.dart';
import 'package:rivo_app/injection.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primaryColorGreen,
        datePickerTheme: DatePickerThemeData(
            rangeSelectionBackgroundColor: AppColors.primaryColorGreen,
            rangeSelectionOverlayColor:
                const MaterialStatePropertyAll(AppColors.primaryColorGreen),
            rangePickerHeaderBackgroundColor: AppColors.primaryColorGreen,
            dividerColor: AppColors.primaryColorGreen,
            rangePickerBackgroundColor: AppColors.primaryColorGreen,
            dayOverlayColor: MaterialStatePropertyAll(
                AppColors.primaryColorGreenAcssent.withOpacity(0.5)),
            elevation: 0.2,
            surfaceTintColor: AppColors.primaryColorGreen,
            todayForegroundColor: const MaterialStatePropertyAll(
                AppColors.primaryColorGreenAcssent)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      builder: BotToastInit(),
      routerDelegate: goRouter.routerDelegate,
      routeInformationParser: goRouter.routeInformationParser,
      routeInformationProvider: goRouter.routeInformationProvider,
    );
  }
}
