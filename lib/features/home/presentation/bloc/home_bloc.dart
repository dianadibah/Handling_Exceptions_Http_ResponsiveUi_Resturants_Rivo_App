import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:rivo_app/features/home/data/model/resturant_model.dart';
import 'package:rivo_app/features/home/data/repository/home_repository_imp.dart';
import 'package:rivo_app/features/home/domain/usecase/get_resturants.dart';
import 'package:rivo_app/features/home/domain/usecase/get_subscriber_resturants.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _perPage = 10;
  final getResturantsUseCase = GetResturantsUseCase(HomeRepositoryImp());
  final getSubscriberResturantUseCase =
      GetSubscribedResturantsUseCase(HomeRepositoryImp());
  HomeBloc() : super(const HomeState()) {
    on<GetResturantEvent>(_mapGetResturants);
    on<GetSubscribedResturantEvent>(_mapGetSuscribedResturants);
  }
  FutureOr<void> _mapGetResturants(
      GetResturantEvent event, Emitter<HomeState> emit) async {
    if (state.resturantStatus == ResturantStatus.initial ||
        event.isReload == true) {
      emit(state.copyWith(
        resturantStatus: ResturantStatus.loading,
      ));
      var result = await getResturantsUseCase(
          ResturantsParams(perPage: _perPage, page: 1));
      result.fold(
          (failure) => emit(state.copyWith(
              resturantStatus: ResturantStatus.failure,
              resturantMessage: failure.message)), (resturantList) {
        log("============${resturantList.data!.resturants!.length}");
        emit(state.copyWith(
            resturantResponse: resturantList.data!.resturants!,
            resturantStatus: ResturantStatus.success,
            isEndPage: resturantList.data!.resturants!.length < _perPage));
        log((resturantList.data!.resturants!.length < _perPage).toString());
      });
    } else if (!state.isEndPage) {
      emit(state.copyWith(resturantStatus: ResturantStatus.loading));
      var result = await getResturantsUseCase(ResturantsParams(
          perPage: _perPage,
          page: state.resturantResponse.length ~/ _perPage + 1));
      result.fold(
          (failure) => emit(state.copyWith(
              resturantStatus: ResturantStatus.failure,
              resturantMessage: failure.message)), (resturantList) {
        log(state.resturantResponse.length.toString());
    
        emit(state.copyWith(
            resturantResponse: List.of(state.resturantResponse)
              ..addAll(resturantList.data!.resturants!),
            resturantStatus: ResturantStatus.success,
            isEndPage: resturantList.data!.resturants!.length < _perPage));
      });
    }
  }

  FutureOr<void> _mapGetSuscribedResturants(
      GetSubscribedResturantEvent event, Emitter<HomeState> emit) async {
    if (state.subscribedResturantStatus == SubscribedResturantStatus.initial ||
        event.isReload == true) {
      emit(state.copyWith(
        subscribedResturantStatus: SubscribedResturantStatus.loading,
      ));
      var result = await getSubscriberResturantUseCase(
          SubscribedResturantsParams(perPage: _perPage, page: 1));
      result.fold(
          (failure) => emit(state.copyWith(
              subscribedResturantStatus: SubscribedResturantStatus.failure,
              subscribedResturantMessage: failure.message)), (resturantList) {
        log("============${resturantList.data!.resturants!.length}");
        emit(state.copyWith(
            subscribedResturantResponse: resturantList.data!.resturants!,
            subscribedResturantStatus: SubscribedResturantStatus.success,
            isEndPage: resturantList.data!.resturants!.length < _perPage));
        log("Suscribe =================${state.subscribedResturantResponse.toString()}");

      });
    } else if (!state.isEndPage) {
      emit(state.copyWith(
          subscribedResturantStatus: SubscribedResturantStatus.loading));
      var result = await getSubscriberResturantUseCase(SubscribedResturantsParams(
          perPage: _perPage,
          page: state.resturantResponse.length ~/ _perPage + 1));
      result.fold(
          (failure) => emit(state.copyWith(
              subscribedResturantStatus: SubscribedResturantStatus.failure,
              subscribedResturantMessage: failure.message)), (resturantList) {
        log(state.subscribedResturantResponse.length.toString());

        emit(state.copyWith(
            subscribedResturantResponse:
                List.of(state.subscribedResturantResponse)
                  ..addAll(resturantList.data!.resturants!),
            subscribedResturantStatus: SubscribedResturantStatus.success,
            isEndPage: resturantList.data!.resturants!.length < _perPage));
      });
    }
  }
}
