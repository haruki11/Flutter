import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage(this.painPoint, this.tiredPoint, {super.key});

  final String painPoint;
  final double tiredPoint;

  static const String _title = 'Flutter Code Sample';

  @override
  State<RecommendPage> createState() => _RecommendPageState(this.painPoint, this.tiredPoint);
}

class _RecommendPageState extends State<RecommendPage> {
  _RecommendPageState(this.painPar, this.tiredPoin);

  String painPar;
  double tiredPoin;

  var status;
  var img;
  var title;
  var content;

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
        () => 'Data Loaded',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("おすすめのコース"),
        centerTitle: false,
      ),
      body: Container(
      child: FutureBuilder<String>(
        future: _calculatio(painPar, tiredPoin), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              Text(
                title,
                style: const TextStyle(
                fontSize: 30,
                color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              Text(content),
              const SizedBox(height: 20),
              Center(
                child: Image.network(img),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  child: const Text('予約する', style: TextStyle(fontSize: 15)),
                  onPressed: () => _openUrl(),
                ),
              ),

            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,

              ),

            ];
          } else {
            children = const <Widget>[
              SizedBox(

                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: Text('少々お待ちください'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
      ),
    );
  }
  Future<String> _calculatio(painPoint, tiredPoint) async{
    await Future<void>.delayed(const Duration(seconds:3));

    var dio = Dio();
    int tiredPoin = tiredPoint.toInt();
    final response = await dio.post('https://17q704uif3.execute-api.ap-northeast-1.amazonaws.com/recommend_course/recommend_courese', data: {'painPart': painPoint, 'tiredPoint': tiredPoin}, options: Options(headers: {'x-api-key': '2FVBf65ZKe8SlAVuMsYQT7FI2CE8KYiN4ldJ6OA4'}));
    Map<String, dynamic> map = jsonDecode(response.data["body"]);

    status = response.data["statusCode"];



    if(status == 200){
      title = map["course"]?["name"];
      content = map["course"]?["courseExplanation"];
      img = map["course"]?["imageUrl"];

    } else {
      final status500 = SnackBar(
        content: const Text("エラーが発生しました。もう一度お試しください。"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(status500);
      Navigator.pop(context);
    }

    return response.data.toString();
  }

  Future<void> _openUrl() async{
    final Uri _url = Uri.parse('https://reraku.jp/course');
    if(!await launchUrl(_url)){
      throw "このURLは無効です";
    }

  }
}
