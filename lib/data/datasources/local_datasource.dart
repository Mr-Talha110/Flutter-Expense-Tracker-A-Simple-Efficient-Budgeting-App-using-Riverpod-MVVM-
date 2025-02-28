import 'package:expense_tracker_app/core/utils/enums/shopping_type_enum.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatasource {
  String transactionsBox = 'transactions-box';
  String transactionsKey = 'transactions-key';

  //****************GENERIC LIST METHODS********************//
  Future<void> storeList<T>(String boxName, String key, T model) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
    final box = Hive.box(boxName);
    List<T> currentList = await fetchList<T>(boxName, key);
    currentList.add(model);
    await box.put(key, currentList);
  }

  //FETCH
  Future<List<T>> fetchList<T>(String boxName, String key) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
    final box = Hive.box(boxName);
    final List<dynamic>? storedList = box.get(key);
    if (storedList == null) {
      return [];
    }
    return storedList.map((item) => item as T).toList();
  }

  //EDIT
  Future<void> editListItem<T>(
    String boxName,
    String key,
    T updatedModel,
    bool Function(T) condition,
  ) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
    final box = Hive.box(boxName);
    List<T> currentList = await fetchList<T>(boxName, key);
    int index = currentList.indexWhere(condition);
    if (index != -1) {
      currentList[index] = updatedModel;
      await box.put(key, currentList);
    }
  }

  //DELETE
  Future<void> deleteListItem<T>(
    String boxName,
    String key,
    bool Function(T) condition,
  ) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
    final box = Hive.box(boxName);
    List<T> currentList = await fetchList<T>(boxName, key);
    currentList.removeWhere(condition);
    await box.put(key, currentList);
  }

  //****************CLEAR DATA********************//
  Future<void> clearAllData() async {
    final transactionBoxInstance = await Hive.openBox(transactionsBox);
    await transactionBoxInstance.close();
  }

  //****************INIT********************//
  static init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(ExpenseTransactionModelAdapter());
    Hive.registerAdapter(ShoppingTypeEnumAdapter());
  }
}
