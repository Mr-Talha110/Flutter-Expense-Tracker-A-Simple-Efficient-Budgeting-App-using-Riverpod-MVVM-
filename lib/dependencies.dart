import 'package:expense_tracker_app/data/datasources/local_datasource.dart';
import 'package:expense_tracker_app/data/repositories/transaction_repository_imp.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton<LocalDatasource>(() => LocalDatasource());
  getIt.registerLazySingleton<TransactionRepositoryImp>(
    () => TransactionRepositoryImp(),
  );
}
