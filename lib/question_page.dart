import 'package:flutter/material.dart';
import "reccomend_page.dart";
import "my_page.dart";
import 'package:dio/dio.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  //ToDo: ここに使用する変数を定義しよう！
  double _currentSliderValue = 0;
  String isSelectedItem = "選択してください";
  static var numbers = <int>[1, 2, 3, 4];
  var mapNumbers = numbers.map((number) => number * 2).toList();


  static var painPoints = <String>["選択してください", "肩", "首", "肩甲骨", "腰", "足"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re.Ra.Ku'),
        centerTitle: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 2),
            Container(
              color: Colors.green,
              padding: const EdgeInsets.all(5.0),
              child: const Center(
                child: Text(
                  '以下の質問に回答で\nあなたにオススメのコースを算出します！'
                  ,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            const Text('■ 本日のお疲れはどれくらいですか？', style: TextStyle(fontSize: 15)),
            const SizedBox(height: 20),
            Center(
              child: Text(
                _currentSliderValue.round().toString(),
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            Slider(
                activeColor: Colors.green,
                inactiveColor: Colors.black38,
                min: 0,
                max: 10,
                value: _currentSliderValue,
                divisions: 10,
                onChanged: (value) {
                  setState((){
                    _currentSliderValue = value;
                  });
                }),
            const Spacer(),
            const Text('■ 一番辛い箇所はどちらですか？', style: TextStyle(fontSize: 15)),
            const SizedBox(height: 10),
            DropdownButton(

                items: painPoints.map((painPoint) => DropdownMenuItem(child: Text(painPoint), value: painPoint)).toList(),

                value: isSelectedItem,
                underline: Container(
                  height: 1,
                  color: Colors.lightGreen,
                ),
                isExpanded: true,
                onChanged: (value) {
                  setState((){
                    isSelectedItem = value.toString();
                  });
                }),
            const Spacer(),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      if(_currentSliderValue == 0){
                        final sliderSnackBar = SnackBar(
                          content: const Text('本日のお疲れを入力してください'),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(sliderSnackBar);
                      } else if (isSelectedItem == "選択してください") {
                        final dropDownButtonSnackBar = SnackBar(
                          content: const Text("一番辛い箇所を選択してください"),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(dropDownButtonSnackBar);
                      } else {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => RecommendPage(isSelectedItem, _currentSliderValue)
                        ));
                      }
                    },
                    child: const Text(
                      '決定',
                      style: TextStyle(fontSize: 15),
                    ))),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}


