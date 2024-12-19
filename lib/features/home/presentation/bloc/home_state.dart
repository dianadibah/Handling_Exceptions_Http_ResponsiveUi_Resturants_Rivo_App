// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

enum ResturantStatus { initial, success, loading, failure }

enum SubscribedResturantStatus { initial, success, loading, failure }

class HomeState {
  final List<Resturant> resturantResponse;
  final List<Resturant> subscribedResturantResponse;
  final ResturantStatus resturantStatus;
  final SubscribedResturantStatus subscribedResturantStatus;
  final String resturantMessage;
  final String subscribedResturantMessage;
  final bool isEndPage;

  const HomeState(
      {this.resturantResponse =const[] ,
      this.subscribedResturantResponse =const[],
      this.resturantStatus = ResturantStatus.initial,
      this.subscribedResturantStatus = SubscribedResturantStatus.initial,
      this.resturantMessage = "",
      this.subscribedResturantMessage = "",
      this.isEndPage=false, });

  HomeState copyWith({
    List<Resturant>? resturantResponse,
    List<Resturant>? subscribedResturantResponse,
    ResturantStatus? resturantStatus,
    SubscribedResturantStatus? subscribedResturantStatus,
    String? resturantMessage,
    String? subscribedResturantMessage,
    bool? isEndPage
  }) {
    return HomeState(
      resturantResponse: resturantResponse ?? this.resturantResponse,
      subscribedResturantResponse:
          subscribedResturantResponse ?? this.subscribedResturantResponse,
      resturantStatus: resturantStatus ?? this.resturantStatus,
      subscribedResturantStatus:
          subscribedResturantStatus ?? this.subscribedResturantStatus,
      resturantMessage: resturantMessage ?? this.resturantMessage,
      subscribedResturantMessage:
          subscribedResturantMessage ?? this.subscribedResturantMessage,
          isEndPage: isEndPage??this.isEndPage
    );
  }
}
