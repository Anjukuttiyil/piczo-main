import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set changeIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}
