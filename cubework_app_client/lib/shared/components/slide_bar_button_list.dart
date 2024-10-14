import 'package:cubework_app_client/constants/slide_bar_buttons.dart';
import 'package:flutter/material.dart';

class SlideBarButtonList extends StatelessWidget {
  const SlideBarButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5),
          )
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: slideBarButtons.length,
          itemBuilder: (context, index) {
            final btn = slideBarButtons[index];
            return IntrinsicWidth(
              stepWidth: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(btn['icon'], size: 24),
                  Container(height: 10),
                  Text(
                    btn['textField'],
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
