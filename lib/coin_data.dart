import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = '51EE4A87-6B9A-46BE-AF02-F7EA0C5353D5';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptPrices = {};
    for(String crypto in cryptoList){
      String requestURL =
          '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';

      http.Response response = await http.get(requestURL);
      if(response.statusCode == 200){
        var decodeData = jsonDecode(response.body);
        var price = decodeData['rate'];
        cryptPrices[crypto] = price.toStringAsFixed(0);
      }else{
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptPrices;
  }
}
