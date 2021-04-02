import 'package:flutter/material.dart';
import 'package:api_data_getter/provider/covid_data_list.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
    //   MultiProvider(
    //     providers: [
    //     ChangeNotifierProvider(
    //     create: (ctx) => CovidDataList(),
    // // value: Products(),
    // ),],
    //   child:
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Covid-19 Tracker'),
      );
    // );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List dataTable =[];
  String dropdownValue = 'India';

  Future<void> fetchAndSetData(String country) async {
    // DateTime now = DateTime.now();
    // final year = now.year;
    // final month = now.month;
    // final day = now.day;
    //
    // final currentDate = DateTime(now.year,now.month,now.day,);
    // print(currentDate);

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
       dataTable = extractedData ;
       print(dataTable[0]);
    } catch (error) {
      throw (error);
    }
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    fetchAndSetData(dropdownValue);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAndSetData(dropdownValue);
  }

  @override
  Widget build(BuildContext context) {
    // final data = Provider.of<CovidDataList>(context);


    return Scaffold(
      appBar: AppBar(title: Text(widget.title),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,children: [
        DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['India', 'Italy', 'Usa']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
        RaisedButton(
          child: Text('Get Results'),
            onPressed: ()async{
             await fetchAndSetData(dropdownValue);
             setState(() {
               dropdownValue = dropdownValue;
             });
        }),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Table(
              children: [
                TableRow(
                    children: [
                      Text("Country",textScaleFactor: 1.5),
                      Text(dataTable[0]['country'],textScaleFactor: 1.5),
                    ]
                ),
                TableRow(
                    children: [
                      Text("Confirmed",textScaleFactor: 1.5),
                      Text(dataTable[0]['confirmed'].toString(),textScaleFactor: 1.5),

                    ]
                ),
                TableRow(
                    children: [
                      Text("Recovered",textScaleFactor: 1.5),
                      Text(dataTable[0]['recovered'].toString(),textScaleFactor: 1.5),

                    ]
                ),
                TableRow(
                    children: [
                      Text("Critical",textScaleFactor: 1.5),
                      Text(dataTable[0]['critical'].toString(),textScaleFactor: 1.5),

                    ]
                ),
                TableRow(
                    children: [
                      Text("Death",textScaleFactor: 1.5),
                      Text(dataTable[0]['deaths'].toString(),textScaleFactor: 1.5),

                    ]
                ),
              ],
            ),
          ),
        )
      ],),),


    );
  }
}


// Center(child: TextButton(child:Text('hello'),onPressed: (){
// data.fetchAndSetData();
// },),),