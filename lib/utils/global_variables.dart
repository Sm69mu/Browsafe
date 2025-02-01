
class GlobalVariables {
  static final GlobalVariables _singleton = GlobalVariables._internal();

  factory GlobalVariables() {
    return _singleton;
  }

  GlobalVariables._internal();
  bool isNewsEnabled = true;
}

// Create an instance of the singleton class
final globalVariables = GlobalVariables();
