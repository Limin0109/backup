import 'dart:ui';

import 'package:biofuture/page/app_styles.dart';
import 'package:biofuture/page/home_screen.dart';
import 'package:biofuture/page/size_configs.dart';
import 'package:biofuture/page/tutorial_data.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int currentPage = 0;

  PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer dotIndicator(index) {
    return AnimatedContainer(
      margin: EdgeInsets.only(right: 5),
      duration: Duration(milliseconds: 400),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : kSecondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // initialize size config
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Tutorial"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                  'https://i.pinimg.com/originals/77/7b/07/777b07a784b619eb9840734261133cbd.jpg',
                ),
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.dstATop)),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: tutorialContents.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      SizedBox(
                        height: sizeV * 4,
                      ),
                      Text(tutorialContents[index].title,
                          style: kTitle, textAlign: TextAlign.center),
                      SizedBox(
                        height: sizeV * 3,
                      ),
                      Container(
                        height: sizeV * 53,
                        child: Image.asset(
                          tutorialContents[index].image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      /*
                    CachedNetworkImage(
                      height: sizeV * 50,
                      imageUrl: tutorialContents[index].image,
                      //fit: BoxFit.contain,
                      placeholder: (context, url) => CircularProgressIndicator()
                    ), */
                      SizedBox(
                        height: sizeV * 3,
                      ),
                      Text(
                        tutorialContents[index].subtitle,
                        style: kBodyText1,
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(
                        height: sizeV * 3,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      currentPage == tutorialContents.length - 1
                          ? MyTextButton(
                              buttonName: 'Exit Tutorial',
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreen() // Please change here and direct it to home screen page
                                        ));
                              },
                              bgColor: kPrimaryColor,
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OnBoardNavBtn(
                                  name: 'Skip',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen() // Please change here and direct it to home screen page
                                            ));
                                  },
                                ),
                                Row(
                                  children: List.generate(
                                    tutorialContents.length,
                                    (index) => dotIndicator(index),
                                  ),
                                ),
                                OnBoardNavBtn(
                                  name: 'Next',
                                  onPressed: () {
                                    _pageController.nextPage(
                                      duration: Duration(milliseconds: 400),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                ),
                              ],
                            ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key,
    required this.buttonName,
    required this.onPressed,
    required this.bgColor,
  }) : super(key: key);
  final String buttonName;
  final VoidCallback onPressed;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: SizeConfig.blockSizeH! * 15.5,
        width: SizeConfig.blockSizeH! * 100,
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttonName,
            style: kBodyText1,
          ),
          style: TextButton.styleFrom(
            backgroundColor: bgColor,
          ),
        ),
      ),
    );
  }
}

class OnBoardNavBtn extends StatelessWidget {
  const OnBoardNavBtn({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);
  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      splashColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          name,
          style: kBodyText1,
        ),
      ),
    );
  }
}
