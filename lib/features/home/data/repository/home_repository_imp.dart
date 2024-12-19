import 'package:rivo_app/core/constant/tybe_def.dart';
import 'package:rivo_app/core/functions/handling_exception_manager.dart';
import 'package:rivo_app/features/home/data/data_source/remot_home_data_source.dart';
import 'package:rivo_app/features/home/data/model/resturant_model.dart';
import 'package:rivo_app/features/home/domain/repository/home_repository.dart';

class HomeRepositoryImp
    with HandlingExceptionManager
    implements HomeRepository {
  final homeDataSource = RemoteHomeDataSource();
  @override
  DataResponse<ResturantsResponse> getResturants(QueryParams params) async {
    return wrapHandling(tryCall: () async {
      var resulte = await homeDataSource.getResturants(params);
      return resulte;
    });
  }

  @override
  DataResponse<ResturantsResponse> getSubscribedResturants(QueryParams params) {
    return wrapHandling(tryCall: () async {
      var resulte = await homeDataSource.getSubscribedResturants(params);
      return resulte;
    });
  }

}
