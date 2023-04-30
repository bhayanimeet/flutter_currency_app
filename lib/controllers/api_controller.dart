import 'dart:convert';
import '../models/currency_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiHelper extends GetxController {
  ApiHelper._();

  static final ApiHelper apiHelper = ApiHelper._();

  Future<Currency?> fetchData({String from = "USD",dynamic amount = 1,String to = "INR"})async{

    String api = "https://api.exchangerate.host/convert?from=$from&to=$to&amount=$amount";

    http.Response result = await http.get(Uri.parse(api));

    if(result.statusCode == 200){
      Map decodedData = jsonDecode(result.body);

      Currency currency  = Currency.fromMap(data: decodedData);

      update();
      return currency;
    }
    return null;
  }


}