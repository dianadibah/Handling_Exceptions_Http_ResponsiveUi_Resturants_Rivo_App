import 'package:get_it/get_it.dart';
import 'package:rivo_app/features/splash_screen/bloc/splash_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async => _appDependencies();

Future<void> _appDependencies() async {
  sl.registerLazySingleton<SplashBloc>(() => SplashBloc());
}
