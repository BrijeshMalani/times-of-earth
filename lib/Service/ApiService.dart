import 'dart:convert';
import 'package:http/http.dart' as http;

import '../common/constant.dart';

class PostService {
  static Future<dynamic> fetchUserResult({Map<String, dynamic>? reqBody}) async {
    String url = "gameresult.php";
    http.Response response =
        await http.post(Uri.parse(Constant.url+url), body: reqBody);

    print("reqBody fetchUserResult");
    print(reqBody);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var result = jsonDecode(response.body);
      return result;
    } else {
      return null;
    }
  }
  static Future<dynamic> loginUser({Map<String, dynamic>? reqBody}) async {
    String url = "getuserdata.php";
    http.Response response =
        await http.post(Uri.parse(Constant.url+url), body: reqBody);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var result = jsonDecode(response.body);
      return result;
    } else {
      return null;
    }
  }

  static Future<dynamic> updateData({Map<String, dynamic>? reqBody}) async {
    String url2 = "updateuserdata.php";
    http.Response response =
        await http.post(Uri.parse(Constant.url+url2), body: reqBody);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var result = jsonDecode(response.body);
      return result;
    } else {
      return null;
    }
  }

  static Future<dynamic> transactionData({Map<String, dynamic>? reqBody}) async {
    String url3 = "transaction.php";
    http.Response response =
        await http.post(Uri.parse(Constant.url+url3), body: reqBody);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var result = jsonDecode(response.body);
      return result;
    } else {
      return null;
    }
  }

  static Future<dynamic> withdrawalData({Map<String, dynamic>? reqBody}) async {
    String url = "withdrawal.php";
    http.Response response =
        await http.post(Uri.parse(Constant.url+url), body: reqBody);

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      var result = jsonDecode(response.body);
      return result;
    } else {
      return null;
    }
  }

}
