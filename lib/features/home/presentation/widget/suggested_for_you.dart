import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rivo_app/core/constant/colors.dart';
import 'package:rivo_app/core/models/device_info.dart';
import 'package:rivo_app/features/home/presentation/bloc/home_bloc.dart';

class SuggestedForYou extends StatefulWidget {
  final DeviceInfo deviceInfo;
  const SuggestedForYou({super.key, required this.deviceInfo});

  @override
  State<SuggestedForYou> createState() => _SuggestedForYouState();
}

class _SuggestedForYouState extends State<SuggestedForYou> {
  late HomeBloc homeBloc;
  @override
  void initState() {
    homeBloc = HomeBloc()..add(GetSubscribedResturantEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => homeBloc,
      child: SizedBox(
        height: widget.deviceInfo.localHeight! / 2.3,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "مقترح لك",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            BlocBuilder<HomeBloc, HomeState>(builder: ((context, state) {
              if ((state.subscribedResturantStatus ==
                          SubscribedResturantStatus.loading ||
                      state.subscribedResturantStatus ==
                          SubscribedResturantStatus.initial) &&
                  state.subscribedResturantResponse.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.subscribedResturantStatus ==
                      SubscribedResturantStatus.failure &&
                  state.subscribedResturantResponse.isEmpty) {
                log("failure${state.subscribedResturantMessage}");
                return IconButton(
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context)
                          .add(GetSubscribedResturantEvent(isReload: true));
                    },
                    icon: const Icon(Icons.replay_outlined));
              } else {
                return Expanded(
                    child: state.subscribedResturantResponse.isEmpty
                        ? const Center(
                            child: Text(
                                "There are no suggested restaurants at the moment",textAlign: TextAlign.center,),
                          )
                        : GridView.builder(
                            itemCount: state.subscribedResturantResponse.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing:
                                  widget.deviceInfo.localHeight! / 100,
                              crossAxisSpacing:
                                  widget.deviceInfo.localWidth! / 50,
                              childAspectRatio: 4 / 2.5,
                            ),
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColorGreenAcssent,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(state
                                          .subscribedResturantResponse[index]
                                          .bannerImage!
                                          .mediaUrl!,fit: BoxFit.fill,),
                                ),
                              );
                            }));
              }
            }))
          ],
        ),
      ),
    );
  }
}
