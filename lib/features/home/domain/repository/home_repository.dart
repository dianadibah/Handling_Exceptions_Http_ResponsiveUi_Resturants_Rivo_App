import 'package:rivo_app/core/constant/tybe_def.dart';
import 'package:rivo_app/features/home/data/model/resturant_model.dart';

abstract class HomeRepository {
  DataResponse<ResturantsResponse> getResturants(QueryParams params);
  DataResponse<ResturantsResponse> getSubscribedResturants(QueryParams params);
}
