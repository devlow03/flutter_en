import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_en/models/english_today.dart';
import 'package:flutter_en/values/app_assets.dart';
import 'package:flutter_en/values/app_color.dart';
import 'package:flutter_en/values/app_style.dart';

import '../packages/quote/qoute_model.dart';
import '../packages/quote/quote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; //dùng để trả về vị trí hiện tại của PageView
  late PageController _pageController ;

  List<EnglishToday> words = [];
  String quote = Quotes().getRandom().content!;

  List<int> fixedListRamdom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday(){
    List<String> newList = [];
    List<int> rans = fixedListRamdom(len:5,max:nouns.length);
    rans.forEach((index) { 
      newList.add(nouns[index]);
    });

    words=newList.map((e) => getQuote(e)).toList();
  }
  EnglishToday getQuote(String noun){
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(
      noun:noun,
      quote: quote?.content,
      id:quote?.id
    );
  }


  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    getEnglishToday();

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //thuộc tính chia tỉ lệ
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.secondColor,
        appBar: AppBar(
          backgroundColor: AppColor.secondColor,
          elevation: 0, //đường line dưới appbar
          title: Text(
            'English today',
            style: AppStyles.h3.copyWith(color: AppColor.textColor, fontSize: 30),
          ),
    
          leading: InkWell(
            onTap: () {},
            child: Image.asset(AppAssets.menu),
          ), //widget cho phép nhận sự kiện ontap
        ),
        body: Container(
          width: double.infinity,
         
          child: Column(
            children: [
              Container(
                height: size.height * 1 / 10,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                alignment: Alignment.centerLeft,
                child: Text(
                    '"$quote',
                    style: AppStyles.h5
                        .copyWith(fontSize: 12, color: AppColor.textColor)),
              ),
              Container(
                height: size.height * 2 / 3,
                // color:Colors.red,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index){
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      String firstLetter = words[index].noun!=null?words[index].noun!: ''; 
                      firstLetter=firstLetter.substring(0,1);
                      String leftLetter = words[index].noun!=null?words[index].noun!:'';
                      leftLetter=leftLetter.substring(1,leftLetter.length);
                      String quoteDefault="Think of all the beauty still left around you and be happy";
                      String quote = words[index].quote!=null ? words[index].quote!:quoteDefault;
    
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                        
                          decoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(24)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  offset:  Offset(3,6),
                                  blurRadius: 6,
                                ),
                              ]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    alignment: Alignment.centerRight,
                                    child: Image.asset(AppAssets.heart)),
                                RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        text: firstLetter,
                                        style: TextStyle(
                                            fontFamily: FontFamily.sen,
                                            fontSize: 89,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  offset: Offset(3, 6),
                                                  blurRadius: 6),
                                            ]),
                                        children: [
                                          TextSpan(
                                            text: leftLetter,
                                            style: TextStyle(
                                                fontFamily: FontFamily.sen,
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  BoxShadow(
                                                      color: Colors.black38,
                                                      offset: Offset(3, 6),
                                                      blurRadius: 6),
                                                ]),
                                          ),
                                        ]),),
                                        Padding(
                                          padding: const EdgeInsets.only(top:24),
                                          child: Text ('"$quote"' ,
                                          style: AppStyles.h4.copyWith(
                                            fontSize: 20,
                                            letterSpacing: 1,
                                            color: AppColor.textColor //làm cho chữ giãn ra
                                          ),),
                                        ),
                              ]),
                        ),
                      );
                    }), //item builder trả về context và index
              ),
              //Indicator
             
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                
                child: SizedBox(
                   height: size.height * 1/11,
                  child: Container(
                  
                   
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context,index){
                        return buildIndicator(index==_currentIndex, size);
                      }),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom:2.0),
          child: FloatingActionButton(
            backgroundColor: AppColor.primaryColor,
            onPressed: () {
              setState(() {
                getEnglishToday();
              });
            },
            child: Image.asset(AppAssets.exchange),
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: AppColor.lighBlue,
          ),
        ),
      ),
    );
  }
  
  Widget buildIndicator(bool isActive, Size size){
    return Container(
      height: 10,
     margin: const EdgeInsets.symmetric(horizontal: 16),
      width: isActive ? size.width * 1/5 : 24,
      decoration: BoxDecoration(
        color:isActive?AppColor.lighBlue:AppColor.lightGrey,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(2,3)
          ),
        ]
      ),
    );
  }
}
