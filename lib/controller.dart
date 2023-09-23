import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'data_model.dart';

final getDoctorData = FutureProvider.family((ref, String url) {
  return DataController().getData(url);
});

class ApiRequests {
  Future<String?> getRequest(String url) async {
    final uri = Uri.parse(url);
    final res = await http.get(uri);

    if (res.statusCode >= 200 && res.statusCode <= 208) {
      final json = res.body;
      return json;
    }

    return null;
  }
}

class DataController {
  Future<List<DataModel>?> getData(String url) async {
    final data = await ApiRequests().getRequest(url);

    if (data != null) return dataModelFromJson(data);
    return null;
  }
}
