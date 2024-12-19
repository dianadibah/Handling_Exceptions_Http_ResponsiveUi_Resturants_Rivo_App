import 'package:rivo_app/core/api.dart/api_variables.dart';
import 'package:rivo_app/core/api.dart/get_api.dart';
import 'package:rivo_app/core/constant/tybe_def.dart';
import 'package:rivo_app/features/home/data/model/resturant_model.dart';


class RemoteHomeDataSource {
  Future<ResturantsResponse> getResturants(QueryParams params) async {
    GetApi getApi = GetApi(
        uri: ApiVariables.indexResturant(queryParam: params),
        body: {},
        fromJson: resturantsResponseFromJson);
    var result = await getApi.callRequest();
    return result;
  }

  Future<ResturantsResponse> getSubscribedResturants(QueryParams params) async {
    GetApi getApi = GetApi(
        uri: ApiVariables.indexSubscribedResturants(queryParam: params),
        body: {},
        fromJson: resturantsResponseFromJson);
    var result = await getApi.callRequest();
    return result;
  }


}
