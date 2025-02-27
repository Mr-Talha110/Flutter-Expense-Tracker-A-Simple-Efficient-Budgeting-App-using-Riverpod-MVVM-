import 'package:expense_tracker_app/core/enums/shopping_type_enum.dart';
import 'package:expense_tracker_app/data/models/expense_track_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class LocalDatasource {
  String transactionsBox = 'transactions-box';
  String transactionsKey = 'transactions-key';

  //****************GENERIC MODEL METHODS********************//
  Future<void> storeModel<T>(T model, String boxName, String key) async {
    final box = await Hive.openBox<T>(boxName);
    await box.put(key, model);
    await box.close();
  }

  Future<T?> getModel<T>(String boxName, String key) async {
    final box = await Hive.openBox<T>(boxName);
    T? model = box.get(key);
    await box.close();
    return model;
  }

  Future<void> clearBox(String boxName) async {
    final box = await Hive.openBox(boxName);
    await box.clear();
    await box.close();
  }

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
    Hive.registerAdapter(ExpenseTrackModelAdapter());
    Hive.registerAdapter(ShoppingTypeEnumAdapter());
  }
}
