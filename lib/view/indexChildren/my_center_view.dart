import 'package:flutter/material.dart';

class MyCenterView extends StatelessWidget {
  const MyCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    height: 70,
                    width: 70,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                            image: AssetImage('assets/images/logo.png')))),
                Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        '名字',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(
                      'Id:1',
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 120, 120, 120)),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              color: Color.fromARGB(255, 120, 120, 120),
              height: 20,
              child: SizedBox(
                height: 20,
                width: double.infinity,
              ),
            )
          ],
        ),
      ),
    );
  }
}