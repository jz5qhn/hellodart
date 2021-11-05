import 'dart:ffi';
import 'dart:ui';
//import 'dart:html';
//import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hellodart/model/question.dart';


class QuizeApp extends StatefulWidget {

  @override
  _QuizeAppState createState() => _QuizeAppState();
}

class _QuizeAppState extends State<QuizeApp> {

  int _currentQuestionIndex = 0;

  List questionBank = [
    Question.name("電柱は、お金を払えば誰でも購入することができる", true),
    Question.name("1円玉の直径は1センチメートルである。", false),
    Question.name("日本で販売されている、スターバックスのドリンクのサイズは3種類である。", false),
    Question.name("ドラゴンボール」に登場する主人公、孫悟空の子どもは、悟飯のみである。", false),
    Question.name("相撲の土俵は、発祥当時から、丸形であった。", false),
    Question.name("カブトムシは犬のように、足を上げておしっこすることがよくある。", true),
    Question.name("大人気映画「ゴジラ」の名前は、ある東映社員の容姿から発想を得て出来ている。", true),
    Question.name("チキンナゲットの「ナゲット」は、鳥のある部位を表した言葉である。", false),
    Question.name("卓球のラケットには、サイズの規定はなく、超巨大なラケットもルール上容認されている。", true),
    Question.name("キリンの睡眠時間は1時間である。", false),
    Question.name("交通事故の発生件数が一番多い都道府県は、東京都である。", false),



  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("True Citizen"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade800,
      ),
      backgroundColor: Colors.blueGrey.shade500 ,

      body: Builder(
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset("images/flag.png",
                    width: 250,
                    height: 180,),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(14.4),
                      border: Border.all(
                        color: Colors.blueGrey.shade400,
                        style:BorderStyle.solid
                      ),
                    ),
                    height: 120.0,
                    width: 350.0,
                    child: Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(questionBank[_currentQuestionIndex].questionText,style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.white,
                      ),),
                    )),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(onPressed: ()=> _backQuestion(),
                        color: Colors.blueGrey.shade800,
                        child: Icon(Icons.arrow_back,color: Colors.white,)),
                    RaisedButton(onPressed: ()=> _checkedAnswer(true,context),
                    color: Colors.blueGrey.shade800,
                    child: Text("True",style: TextStyle(
                      color: Colors.white
                    ),),),
                    RaisedButton(onPressed: ()=> _checkedAnswer(false,context),
                      color: Colors.blueGrey.shade800,
                      child: Text("False",style: TextStyle(
                          color: Colors.white),),),
                    RaisedButton(onPressed: ()=> _nextQuestion(),
                      color: Colors.blueGrey.shade800,
                      child: Icon(Icons.arrow_forward,color: Colors.white,)),
                  ],
                ),
                Spacer()
              ],
            ),

          );
        }
      ),
    );
  }

  _checkedAnswer(bool userChoice, BuildContext context) async {
    if(userChoice == questionBank[_currentQuestionIndex].isCorrect){
      final snackbar = SnackBar(
          backgroundColor: Colors.green,
          duration: Duration(milliseconds: 500),
          content: Text("Correct!"));
      _updateQuestion();

      Scaffold.of(context).showSnackBar(snackbar);

      debugPrint("Yes Correct");
    }else{
      final snackbar = SnackBar(
          backgroundColor: Colors.redAccent,
          duration: Duration(milliseconds: 500),
          content: Text("Incorrect!"));
      Scaffold.of(context).showSnackBar(snackbar);
      debugPrint("InCorrect");
      _updateQuestion();
    }

  }
  _updateQuestion() async {
    await Future.delayed(Duration(milliseconds: 850));
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex+1) % questionBank.length;
    });

  }


  _nextQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex+1) % questionBank.length;
    });
  }
  _backQuestion(){
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex-1) % questionBank.length;
    });

  }
}











class BillSplitter extends StatefulWidget {

  @override
  _BillSplitterState createState() => _BillSplitterState();
}
class _BillSplitterState extends State<BillSplitter> {

  int _tipPercentage = 0;
  int _personCounter = 1;
  double _billAmount = 0.0;
  //Color _purple = HexColor("#6908D6")

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin:EdgeInsets.only(top:MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  color: HexColor("#6495ed").withOpacity(0.2),//olors.lightBlue.shade100,
                  borderRadius: BorderRadius.circular(12.0)
              ),

              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total Per Person",style: TextStyle(
                      color: HexColor("#6495ed"),
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("\$ ${coluculateTotalPerPerson(_billAmount, _personCounter, _tipPercentage)}"
                        ,style: TextStyle(
                        color: HexColor("#6495ed"),
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.blueGrey.shade100,
                  style: BorderStyle.solid
                ),
                borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: HexColor("#6495ed")),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount    ",
                      prefixIcon: Icon(Icons.attach_money)
                    ),
                    onChanged: (String value){
                      try{
                        _billAmount = double.parse(value);

                      }catch(exception) {
                        _billAmount = 0.0;

                      }
                    },

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split",style: TextStyle(
                        color: Colors.grey.shade700
                      ),),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                if (_personCounter > 1){
                                  _personCounter --;
                                }
                                else{

                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: HexColor("#6495ed").withOpacity(0.2),
                              ),
                              child: Center(
                                child: Text("-",style: TextStyle(
                                  color: HexColor("#6495ed"),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.0
                                ),),
                              ),
                            ),
                          ),
                          Text("$_personCounter",style: TextStyle(
                              color: HexColor("#6495ed"),
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0
                          ),),

                          InkWell(
                            onTap: (){
                              setState(() {
                                _personCounter ++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: HexColor("#6495ed").withOpacity(0.2),
                              ),
                              child: Center(
                                child: Text("+",style: TextStyle(
                                    color: HexColor("#6495ed"),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0
                                ),),
                              ),
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tip",style: TextStyle(
                          color: Colors.grey.shade700
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Text("\$ ${(caluculateTotalTip(_billAmount,
                            _personCounter, _tipPercentage)).toStringAsFixed(2)}",style: TextStyle(
                          color: HexColor("#6495ed"),
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0

                        ),),
                      )
                    ],
                  ),
                  //Slider
                  Column(
                    children: [
                      Text("$_tipPercentage%",style: TextStyle(
                        color: HexColor("#6495ed"),
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold
                      ),),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: HexColor("6495ed"),
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _tipPercentage.toDouble()
                        , onChanged: (double newValue){
                        setState(() {
                          _tipPercentage = newValue.round();
                        });

                        })



                    ],
                  )


                ],

              )

            ),
          ],
        ),

      ),

    );

  }
  coluculateTotalPerPerson (double billAmount, int splitBy, int tipPercentage){
    var totalPerPerson = (caluculateTotalTip(billAmount, splitBy, tipPercentage)
        + billAmount) / splitBy;

    return totalPerPerson.toStringAsFixed(2) ;

  }

  caluculateTotalTip(double billAmount, int splitBy, tipPercentage) {
    double totalTip = 0.0;

    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount == null) {

    }else{
      totalTip = tipPercentage/100 * billAmount;
    }

    return totalTip;

  }
}

class Wisdom extends StatefulWidget {
  @override
  _WisdomState createState() => _WisdomState();
}
class _WisdomState extends State<Wisdom> {
  int _index = 0;

  List quotes = [
    "オレが後ろにいるかぎり 誰も負けねぇんだよ",
    "オマエを許す",
    "下げる頭もってなくてもいい 人を想う“心”は持て",
    "今ぁ 準備運動が終わったトコだ",
    "オレらの全てを オマエに預ける 時代を創れマイキー",
    "初めてカッケェって思った人も 初めて付いて行こうと思った人も 全部 場地圭介だった"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Container(
                    width: 350,
                    height: 200,
                    margin: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(14.5)
                    ),
                    child: Center(child: Text(quotes[_index % quotes.length],
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.8,
                    ),))
                ),
              ),
            ),


            Divider(thickness: 1.3,),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: FlatButton.icon(
                  onPressed: _ShowQuote,
                  color: Colors.greenAccent.shade700,

                  icon: Icon(Icons.wb_sunny,color: Colors.redAccent,),

                  label: Text("Next!", style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.8,
                  ),)
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  void _ShowQuote() {
    setState(() {
      _index +=1;
      /*var rand = new math.Random();
      _index = rand.nextInt(quotes.length);*/
    });

  }

}

class Bizcard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bizcard"),
      ),
      backgroundColor: Colors.grey,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [_getCard(), _getAvatar()],
        ),
      ),
    );
  }

  Container _getCard() {
    return Container(
      width: 350,
      height: 200,
      margin: EdgeInsets.all(50.0),
      decoration: BoxDecoration(
          color: Colors.blueGrey, borderRadius: BorderRadius.circular(4.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Takumi Matsue",
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          Text("bb52121128@ms.nagasaki-u.ac.jp"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(Icons.person), Text("Twitter:m.takumi")],
          )
        ],
      ),
    );
  }

  Container _getAvatar() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(color: Colors.blueGrey, width: 1.2),
          image: DecorationImage(
              image: NetworkImage("https://picsum.photos/300/300"))),
    );
  }
}

class ScaffoldExample extends StatelessWidget {
  _tappedButton() {
    debugPrint("tapped Button");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scaffold'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade700,
        actions: [
          IconButton(
              onPressed: () => debugPrint("Email Tapped"),
              icon: Icon(Icons.email)),
          IconButton(onPressed: _tappedButton, icon: Icon(Icons.camera_alt))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          child: Icon(Icons.call_missed),
          onPressed: () => debugPrint("back")),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text("First")),
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit), title: Text("Second")),
          BottomNavigationBarItem(icon: Icon(Icons.timer), title: Text("Third"))
        ],
        onTap: (int index) => debugPrint("Tapped item: $index"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton()
            // InkWell(
            //   child: Text("Tap Me",
            //     style:TextStyle(fontSize:23.4),),
            //   onTap: () => debugPrint("Tapped..."),
            // )
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(
          content: Text("Hello Again"),
          backgroundColor: Colors.blueGrey.shade400,
        );
        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.blueAccent, borderRadius: BorderRadius.circular(8.0)),
        child: Text("Button"),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blueGrey,
      child: Center(
          child: Text(
        "Hello Flutter",
        textDirection: TextDirection.rtl,
        style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 25,
            fontStyle: FontStyle.italic),
      )),
    );
  }
}

//色をカラーコードで指定
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}