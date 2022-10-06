import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ecommendPage extends StatefulWidget {
  const ecommendPage(this.painPart, {super.key});

  final String painPart;

  @override
  State<ecommendPage> createState() => _ecommendPageState();
}

class _ecommendPageState extends State<ecommendPage> {
  var status;

  Future response() async{

    var dio = Dio();
    final response = await dio.post('https://17q704uif3.execute-api.ap-northeast-1.amazonaws.com/recommend_course/recommend_courese', data: {'painPart': "肩", 'tiredPoint': 3}, options: Options(headers: {'x-api-key': '2FVBf65ZKe8SlAVuMsYQT7FI2CE8KYiN4ldJ6OA4'}));
    print(response.data.toString());
    status = response.data['statusCode'];
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('オススメのコース'),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Spacer(flex: 2),
            Text(
              '疲労撃退コース30分',
              style: const TextStyle(
                fontSize: 30,
                color: Colors.green,
              ),
            ),
            const Spacer(),
            Text('肩甲骨を中心に全身をほぐしていくコースです'),
            const Spacer(),
            const SizedBox(height: 20),
            Center(
              child: Image.network(
                  'https://reraku.jp/wp-content/themes/reraku/src/images/shared/courses/hiro.jpg'),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async{
                  //await response();
                  print(status);
                  if(status == 200){

                  } else {
                    final status500 = SnackBar(
                      content: const Text("エラーが発生しました。もう一度お試しください。"),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(status500);
                    Navigator.pop(context);
                  }
                },
                child: const Text('予約する', style: TextStyle(fontSize: 15)),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
