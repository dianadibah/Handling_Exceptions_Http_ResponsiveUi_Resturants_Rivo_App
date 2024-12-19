import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rivo_app/core/constant/colors.dart';
import 'package:rivo_app/core/constant/images.dart';
import 'package:rivo_app/core/constant/info_widget.dart';
import 'package:rivo_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:rivo_app/features/home/presentation/widget/home_search.dart';
import 'package:rivo_app/features/home/presentation/widget/suggested_for_you.dart';
import 'package:rivo_app/features/home/presentation/widget/your_subscriptions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColorGreenAcssent,
          title: Text(
            'Rivo',
            style: TextStyle(
                color: AppColors.greyShadeTwo,
                fontFamily: "ArbFONTS-Almarai-ExtraBold",
                fontWeight: FontWeight.bold,
                fontSize: deviceInfo.localHeight! / 30),
          ),
          leading: Container(
              margin: const EdgeInsets.only(left: 6),
              child: SvgPicture.asset(AppImages.logoWhite)),
          leadingWidth: 50,
          actions: const [
            Icon(
              Icons.view_headline,
              color: AppColors.greyShadeTwo,
              size: 50,
            )
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: deviceInfo.localWidth! / 9,
                vertical: deviceInfo.localHeight! / 28,
              ),
              child: Column(
                children: [
                  HomeSearch(
                    serachFun: () {},
                    searchController: searchController,
                    deviceInfo: deviceInfo,
                  ),
                 SingleChildScrollView(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  
                  children: [YourSubscriptions(
                              deviceInfo: deviceInfo),
                  SizedBox(
                    height: deviceInfo.localHeight! / 80,
                  ),
                  SuggestedForYou(
                      deviceInfo: deviceInfo,
                     ),],),)
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}
