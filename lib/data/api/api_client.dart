import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService{
  late String token;
  final String appBaseUrl;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'HttpHeaders.contentTypeHeader': 'application/json'
    };
  }

  void updateHeader(String token){
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-8',
      'HttpHeaders.contentTypeHeader': 'application/json'
    };
  }

    // Request for getting data from api server
    Future<Response> getData(String uri, {Map<String, String>? headers}) async{
      try{
        Response response = await get(uri, headers: headers??_mainHeaders);
        // print(response.body.toString());
        return response;
      }catch(e){
        return Response(statusCode: 1, statusText: e.toString());
      }
    }
}