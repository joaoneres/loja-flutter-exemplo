import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  DrawerTile(this.icon, this.text, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child: Container(
          height: 50.0,
          child: Row(
            children: <Widget>[
              Icon(
                icon,
                size: 32.0,
                color: pageController.page.round() == page ? Colors.black : Colors.white,
              ),
              SizedBox(width: 15.0),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18.0,
                  color: pageController.page == page ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w500,
                ), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}