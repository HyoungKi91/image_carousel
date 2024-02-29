import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  Timer? timer;
  PageController controller = PageController(
    initialPage: 0, //몇번째 페이지부터 실행할거인지.
  );
  @override
  void initState() {  //homeScreenState가 실행될때 실행
    super.initState();
    
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int currentPage = controller.page!.toInt();

      int nextPage = currentPage +1;
      if(nextPage > 4){
        nextPage = 0;
      }

      controller.animateToPage(nextPage,
          duration: Duration(microseconds: 400), // 이동되는 시간
          curve: Curves.linear);                 // 이동 속도
    });
  }

  @override
  void dispose() {  //homeScreenState가 죽을때 실행
    controller.dispose();
    if(timer != null){
      timer!.cancel();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: PageView(
        controller: controller,
        children: ['1', '2', '3', '4', '5'].map(
                (e) => Image.asset(
                  'asset/img/image_$e.jpeg',
                  fit: BoxFit.cover,
          ),
        ).toList(),
      ),
    );
  }
}
