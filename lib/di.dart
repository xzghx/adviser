import 'package:advicer_app/application/pages/advice/cubit/advicer_cubit.dart';
import 'package:advicer_app/data/data_sources/advise_remote_data_source.dart';
import 'package:advicer_app/domain/repositories/advise_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/repositories/advise_repo_impl.dart';
import 'domain/usecases/advice_usecases.dart';

final sl = GetIt.I;

Future init() async {
  //  application Layer
  sl.registerFactory(() => AdvicerCubit(adviseUseCase: sl()));
  //  Domain Layer
  sl.registerFactory(() => AdviseUseCase(adviseRepo: sl()));

  //  Data Layer
  sl.registerFactory<AdviseRepo>(() => AdviseRepoImpl(remoteDataSource: sl()));
  sl.registerFactory<AdviseRemoteDataSource>(
      () => AdviseRemoteDataSourceImpl(client: sl()));

  //  extra
  sl.registerLazySingleton(() => http.Client());
}
