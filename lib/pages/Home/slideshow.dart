import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_schooldev/pages/Post/select.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Slideshow extends StatefulWidget {
  @override

  final String tagusername;
  final bool selected;

  Slideshow({this.selected, this.tagusername});
  _SlideshowState createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  // This will give them 80% width which will allow other slides to appear on the side
  final PageController controller = PageController(viewportFraction: 0.8);

  final Firestore datbase = Firestore.instance;
  Stream slides;
  String activeTag = 'school';
  String CustomTag;

  int currentPage = 0;

  @override
  void initState() {
    _queryDatabase();
    CustomTag = widget.tagusername;
    controller.addListener(() {
      int next = controller.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  void _queryDatabase({String tag = 'school'}) {

    if(tag == 'me'){
      Query query =
      datbase.collection('stories').where('tags', arrayContains: CustomTag);
      // Map the slides to the data payload
      print(widget.tagusername);
      slides =
          query.snapshots().map((list) => list.documents.map((doc) => doc.data));
      // Update the active tag
      setState(() {
        activeTag = tag;
      });
    }
    else{
      Query query =
      datbase.collection('stories').where('tags', arrayContains: tag);
      // Map the slides to the data payload
      print(tag);
      slides =
          query.snapshots().map((list) => list.documents.map((doc) => doc.data));
      // Update the active tag
      setState(() {
        activeTag = tag;
      });
    }

  }

  Container _buildTagPage() {
    return Container(
//      decoration: new BoxDecoration(
//        image: new DecorationImage(
//          image: ExactAssetImage('assets/image-1.png'),
//          fit: BoxFit.fill
//        ),
//      ),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My School',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text('FILTER', style: TextStyle(color: Colors.black26)),
          _buildButton('school'),
          _buildButton('group'),
          _buildButton('me')
        ],
      ),
    );
  }

  FlatButton _buildButton(tag) {
    Color color = tag == activeTag ? Colors.blue : Colors.white;
    return FlatButton(
      color: color,
      child: Text(
        '#$tag',
        textAlign: TextAlign.left,
      ),
      onPressed: () => _queryDatabase(tag: tag),
    );
  }

  AnimatedContainer  _buildStoryPage(Map data, bool active) {
    // Animated properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

    return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: ExactAssetImage('assets/slideimage-2.png'), // NetworkImage(data['image']) 를 사용하면 custom slide를 만들수 있음
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black87,
              blurRadius: blur,
              offset: Offset(offset, offset),
            ),
          ],
        ),
        child: Center(
          child: Text(
            data['title'],
            style: TextStyle(fontSize: 40, color: Colors.black),
          ),
        ),
      );
  }

  void testfunction() {
    print("this is for test");
  }
  static String gettitle ="";
  bool selected = false;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        selected = true;
        if(currentPage > 0){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => select(title : gettitle)));
        }

        setState(() {
          selected = true;
        });
      },
      child: StreamBuilder(
        stream: slides,
        initialData: [],
        builder: (context, AsyncSnapshot snap) {
          List slideList = snap.data.toList();
          return PageView.builder(
            controller: controller,
            itemCount: slideList.length + 1,
            itemBuilder: (context, int currentIndex) {
              if (currentIndex == 0) {
                return _buildTagPage();
              } else if (slideList.length >= currentIndex) {
                bool active = currentIndex == currentPage;
                if(currentPage > 0){
                  Map data = slideList[currentPage - 1];
                  gettitle = data['title'];
                  print(selected);
                  if(selected == true){
                    print(data['title']);
                    selected = false;
                  }
                }
                return _buildStoryPage(slideList[currentIndex - 1], active);
              }
            },
          );
        },
      ),
    );
  }
}
