import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_app/app/core/utils/keys.dart';


class StorageServices extends GetxService {
  late GetStorage _storage;
  

  // Function To initialize get storage
  Future<StorageServices> init() async {
    _storage = GetStorage();
    await _storage.writeIfNull(taskKey, []);
    return this;
  }

  // Function to read data from local storage
  T readData<T>(String key){
    return _storage.read(key);
  }

  // Function to write data into local storage
  void writeData(String key, dynamic value) async {
    await _storage.write(key, value);
  }

  
}