import 'package:rivo_app/core/constant/tybe_def.dart';
import 'package:rivo_app/core/constant/usecases.dart';
import 'package:rivo_app/features/home/data/model/resturant_model.dart';

import '../repository/home_repository.dart';

class GetResturantsUseCase
    extends UseCase<ResturantsResponse, ResturantsParams> {
  final HomeRepository homeRepository;

  GetResturantsUseCase(this.homeRepository);
  @override
  DataResponse<ResturantsResponse> call(ResturantsParams params) async {
    return await homeRepository.getResturants(params.getParams());
  }
}

class ResturantsParams with Params {
  final int? perPage;
  final int? page;

  ResturantsParams({this.perPage,this.page});
  @override
  QueryParams getParams() {
    return {"perPage": perPage.toString(),"page":page.toString()};
  }
}
