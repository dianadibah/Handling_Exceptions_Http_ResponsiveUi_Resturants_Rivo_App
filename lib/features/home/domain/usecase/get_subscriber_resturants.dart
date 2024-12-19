import 'package:rivo_app/core/constant/tybe_def.dart';
import 'package:rivo_app/core/constant/usecases.dart';
import 'package:rivo_app/features/home/data/model/resturant_model.dart';

import '../repository/home_repository.dart';

class GetSubscribedResturantsUseCase
    extends UseCase<ResturantsResponse, SubscribedResturantsParams> {
  final HomeRepository homeRepository;

  GetSubscribedResturantsUseCase(this.homeRepository);
  @override
  DataResponse<ResturantsResponse> call(SubscribedResturantsParams params) async {
    return await homeRepository.getSubscribedResturants(params.getParams());
  }
}

class SubscribedResturantsParams with Params {
  final int? perPage;
  final int? page;

  SubscribedResturantsParams({this.perPage,this.page});
  @override
  QueryParams getParams() {
    return {"perPage": perPage.toString(),"page":page.toString()};
  }
}
