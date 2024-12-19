import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rivo_app/core/constant/colors.dart';
import 'package:rivo_app/core/models/device_info.dart';
import 'package:rivo_app/features/home/presentation/bloc/home_bloc.dart';

class YourSubscriptions extends StatefulWidget {
  final DeviceInfo deviceInfo;
  const YourSubscriptions({super.key, required this.deviceInfo});

  @override
  State<YourSubscriptions> createState() => _YourSubscriptionsState();
}

class _YourSubscriptionsState extends State<YourSubscriptions> {
  late HomeBloc homeBloc;
  @override
  void initState() {
    homeBloc = HomeBloc()..add(GetResturantEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if ((state.resturantStatus == ResturantStatus.loading ||
                state.resturantStatus == ResturantStatus.initial) &&
            state.resturantResponse.isEmpty) {
          return const CircularProgressIndicator();
        } else {
          if (state.resturantStatus == ResturantStatus.failure &&
              state.resturantResponse.isEmpty) {
            log("failure${state.resturantMessage}");
            return IconButton(
                onPressed: () {
                  BlocProvider.of<HomeBloc>(context)
                      .add(GetResturantEvent(isReload: true));
                },
                icon: const Icon(Icons.replay_outlined));
          } else {
            log("Success****${state.resturantResponse.toString()}");
            return SizedBox(
              height: widget.deviceInfo.localHeight! / 5,
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "اشتراكاتك",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    //height: 90,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const PageScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.resturantResponse.length,
                      separatorBuilder: (context, index) => SizedBox(
                        width: widget.deviceInfo.localWidth! / 45,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          width: 200,
                          height: widget.deviceInfo.localHeight! / 5,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColorGreenAcssent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child:
                                  state.resturantResponse[index].bannerImage ==
                                          null
                                      ? const Center(
                                          child: Text("No Image"),
                                        )
                                      : Image.network(
                                          state.resturantResponse[index]
                                              .bannerImage!.mediaUrl!,
                                          fit: BoxFit.fill,
                                        )),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        }
      }),
    );
  }
}
