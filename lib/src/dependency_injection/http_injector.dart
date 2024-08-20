import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

class HttpConnectionInjector {
  void call() {
    GetIt.I.registerFactory<Client>(() => Client());
  }
}
