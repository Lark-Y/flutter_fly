
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 48,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: BackButton(),
            ),
            const SizedBox(
              height: 48,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/header.png',
                  height: 80,
                  width: 80,
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Center(
              child: Text(
                'Flutter Fly',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text(
                'Version 1.0.0',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Center(
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '《软件许可及服务协议》',
                      recognizer: TapGestureRecognizer()..onTap = (){},
                      style: const TextStyle(color: Color(0xFF5E6386)),
                    ),
                    const TextSpan(text: '和'),
                    TextSpan(
                      text: '《隐私保护指引》',
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: const TextStyle(color: Color(0xFF5E6386)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}