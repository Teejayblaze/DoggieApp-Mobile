import 'package:http/http.dart' as http;
import 'package:doggie_app/constant/doggie_ipconfig_constant.dart';

class DoggieNetwork {

  final String baseUrl = IP;

  Future getNetworkRequest({String url}) async {
    http.Client client = new http.Client();
    try{
      return await client.get(baseUrl + url);
    } catch(e) {
//      throw Exception("Network Problem");
      print("unable to connect anyway :) $e");
    }
  }
}