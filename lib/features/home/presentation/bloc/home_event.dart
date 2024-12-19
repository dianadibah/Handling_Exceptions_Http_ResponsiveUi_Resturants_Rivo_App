part of 'home_bloc.dart';

sealed class HomeEvent {
  const HomeEvent();
}

class GetResturantEvent extends HomeEvent {
  final bool isReload;

  GetResturantEvent({this.isReload = false});
}

class GetSubscribedResturantEvent extends HomeEvent {
  final bool isReload;

  GetSubscribedResturantEvent({this.isReload = false});
}
