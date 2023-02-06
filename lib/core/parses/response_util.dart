import 'dart:convert';

///TODO: Cần xin format của response để tạo common response

// class ParseResponse<T extends Serializer> {
//   final dynamic response;
//
//   ParseResponse({this.response});
//
//   Map<String, dynamic> getJson() {
//     if (response is String) {
//       return jsonDecode(response);
//     }
//     return {};
//   }
//
//   T getData() {
//     final dataJson = getJson()['data'];
//   }
//
//   List<T>? getListData() {
//     final dataJson = getJson()['data'];
//     if (dataJson is List) {
//       return dataJson.map((e) => T.fromJson(e)).toList();
//     }
//     return null;
//   }
// }