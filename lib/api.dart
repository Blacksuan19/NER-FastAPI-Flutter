import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:dio/dio.dart';

// API provider
final aPIProvider = ChangeNotifierProvider<API>((ref) => API());

// API response provider
final responseProvider = FutureProvider.autoDispose((ref) async {
  return ref.watch(aPIProvider).response.data;
});

class API extends ChangeNotifier {
  var response;
  void classifyText({text: String}) async {
    String url = "https://frozen-coast-03690.herokuapp.com/classify/$text";
    try {
      response = await Dio().get(url); // DIO!!
    } on DioError catch (e) {
      // 400 is word not recognized in the API
      if (e.response.statusCode == 400)
        response = e.response;
      else
        print(e.response.statusMessage);
    }
    notifyListeners();
  }
}
