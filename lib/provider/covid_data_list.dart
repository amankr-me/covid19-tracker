import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CovidDataList with ChangeNotifier{
  List data;
  Future<void> fetchAndSetData(String country) async {
    DateTime now = DateTime.now();
    final year = now.year;
    final month = now.month;
    final day = now.day;

    final currentDate = DateTime(now.year,now.month,now.day,);
    print(currentDate);

    final url =
    'https://covid-19-data.p.rapidapi.com/country?name=$country';
        // 'https://covid-19-data.p.rapidapi.com/report/country/name?date=$year-$month-$day&name=usa';
    try {
      final response = await http.get(url,headers: {
        'x-rapidapi-key': '49ee683dcdmshfc756a4acfa03f8p121c1djsn8d7565c2801a',
        'x-rapidapi-host': 'covid-19-data.p.rapidapi.com',
      });
      final responseData = response;
      final extractedData = json.decode(response.body);
      final data = extractedData[0] as Map<String,dynamic>;
      // as Map<String, dynamic>;
      print(extractedData[0]);
      print(data);
      // if (extractedData == null) {
      //   return;
      // }
      // final List<Product> loadedProducts = [];
      // extractedData.forEach((prodId, prodData) {
      //   loadedProducts.add(Product(
      //     id: prodId,
      //     title: prodData['title'],
      //     description: prodData['description'],
      //     price: prodData['price'],
      //     // isfavourite: prodData['isFavorite'],
      //     imageUrl: prodData['imageUrl'],
      //   ));
      // });
      // _items = loadedProducts;
      // notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

//
//
// [1 item
// 0:{5 items
// "country":"Italy"
// "provinces":[1 item
// 0:{5 items
// "province":"Italy"
// "confirmed":110574
// "recovered":16847
// "deaths":13155
// "active":80572
// }
// ]
// "latitude":41.87194
// "longitude":12.56738
// "date":"2020-04-01"
// }
// ]