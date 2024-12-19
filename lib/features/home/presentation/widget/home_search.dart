import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rivo_app/core/constant/colors.dart';
import 'package:rivo_app/core/constant/images.dart';
import 'package:rivo_app/core/models/device_info.dart';

import 'package:rivo_app/core/widgets/text_form_faild.dart';

class HomeSearch extends StatelessWidget {
  final void Function()? serachFun;
  final TextEditingController searchController;
  final DeviceInfo deviceInfo;

  const HomeSearch(
      {super.key,
      required this.serachFun,
      required this.searchController,
      required this.deviceInfo});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'الرئيسية',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'ArbFONTS-Almarai-Regular',
            fontSize: deviceInfo.localHeight! / 35,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: deviceInfo.localHeight! / 60,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: deviceInfo.localHeight! / 12,
                width: deviceInfo.localWidth! / 1.8,
                child: CustomTextFormFaild(
                  hintText: "البحث",
                  textEditingController: searchController,
                  validator: (String) {
                    return null;
                  },
                ),
              ),
              SizedBox(width: 5,),
              MaterialButton(
                color: AppColors.primaryColorGreen,
                minWidth: deviceInfo.localWidth! / 25,
                height: deviceInfo.localHeight! / 16,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: serachFun,
                child: SvgPicture.asset(AppImages.search,color: AppColors.textColorWhite,)
              ),
            ]),
      ],
    );
  }
}
