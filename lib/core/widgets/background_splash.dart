import 'package:flutter/material.dart';

import '../constant/images.dart';
import '../constant/info_widget.dart';

class CustomBackGroundSplash extends StatelessWidget {
  const CustomBackGroundSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceType) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppImages.bgBlueTop,
                height: deviceType.localHeight! / 3,
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                AppImages.bgBlueDown,
                height: deviceType.localHeight! / 3,
              )
            ],
          ),
         
        ],
      );
    });
  }
}
