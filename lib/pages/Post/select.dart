import 'package:flutter_schooldev/pages/Post/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_schooldev/pages/Post/generate.dart';


class select extends StatefulWidget {
  @override
  select({
    Key key,
    @required this.title,
}):super(key : key);
  _selectState createState() => _selectState();
  final String title;

}

class _selectState extends State<select> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body:ListPage(pagetitle: widget.title),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => generate(posttitle : widget.title))); // write post here
        },
        label: Text('new'),
        icon: Icon(Icons.add_circle),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}

class ListPage extends StatefulWidget{
  ListPage({
    Key key,
    @required this.pagetitle,
  }):super(key : key);

  final String pagetitle;
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>{

  Future _data;


  Future getPost() async {
    var firestore = Firestore.instance;

    QuerySnapshot qn = await firestore.collection(widget.pagetitle).getDocuments();

    return qn.documents;
  }
  
  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(post: post,)));
  }

  @override
  void initState(){
    super.initState();

    _data = getPost();

  }

  @override
  Widget build(BuildContext context){
    return Container(
      child: FutureBuilder(
        future: _data,
        builder: (_, snapshot){

          if(snapshot.connectionState == ConnectionState.waiting){
            return _buildWaitingScreen();
          } else{

            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index){

                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data[index].data['title']),
                      onTap: () => navigateToDetail(snapshot.data[index]),
                    ),
                  );

                });
          }
        }),
    );
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }


}

class DetailPage extends StatefulWidget{

  final DocumentSnapshot post;

  DetailPage({this.post});

  @override
  _DatailPageState createState() => _DatailPageState();
}

class _DatailPageState extends State<DetailPage>{
  var comments_data;
  void initState(){
    comments_data = widget.post.data['comments'];
    print(comments_data);
    if(comments_data == null){
      comments_data = [""];
    }
  }


  @override
  Widget build(BuildContext context){
    Widget welcome_widget(){
      return Container(
        padding: EdgeInsets.all(15.0),
        child: Text(
          widget.post.data['title'],
          style: TextStyle(fontSize: 28.0, color: Colors.black),
        ),
      );
    }
    final welcome = Container(
      padding: EdgeInsets.all(15.0),
      
      child: Text(
        widget.post.data['title'],
        style: TextStyle(fontSize: 28.0, color: Colors.black),
      ),
    );
    Widget lorem_widget(){
      return Container(
        padding: EdgeInsets.fromLTRB(4,14,4,14),
        decoration: BoxDecoration(
            color: Color.fromRGBO(241, 241, 241, 0.8),
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
                bottomRight: const Radius.circular(10.0),
                bottomLeft:const Radius.circular(10.0)
            )),
        child: Align(
            alignment: Alignment.topLeft,
//      padding: EdgeInsets.all(20.0),
            child: Text(
              widget.post.data['content'],
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.black,
              ),
            )),
      );
    }
    final lorem = Container(
      padding: EdgeInsets.fromLTRB(4,14,4,14),
      decoration: BoxDecoration(
          color: Color.fromRGBO(241, 241, 241, 0.8),
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0),
              bottomLeft:const Radius.circular(10.0)
          )),
      child: Align(
        alignment: Alignment.topLeft,
//      padding: EdgeInsets.all(20.0),
      child: Text(
        widget.post.data['content'],
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 17.0,
          color: Colors.black,
        ),
      )),
    );

    //Future _data;
    Widget comments_widget(){
      return Container(

          height: 1000,
          child: ListView.builder(
            itemCount: comments_data.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(comments_data[index]),
              );
            },
          )
      );
    }
    final comments = Container(
        height: 1000,
        child: ListView.builder(
          itemCount: comments_data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(comments_data[index]),
            );
          },
        )
    );


//    Flexible(
//      child:ListView.builder(
//          itemCount: commentsdata.length,
//          itemBuilder: (_, index){
//
//            return Container(
//              padding: EdgeInsets.all(10.0),
//              margin: EdgeInsets.symmetric(vertical: 10.0),
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.circular(10.0), color: Colors.grey),
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  Text(
//                    '노건호',
//                    style: TextStyle(fontWeight: FontWeight.bold),
//                  ),
//                  UIHelper.verticalSpaceSmall(),
//                  Text('Test'),
//                ],
//              ),
//            );
//          }) ,
//    );
   // ),
//    final comments = Container(
//      padding: EdgeInsets.all(10.0),
//      margin: EdgeInsets.symmetric(vertical: 10.0),
//      decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(10.0), color: Colors.green),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Text(
//            '노건호',
//            style: TextStyle(fontWeight: FontWeight.bold),
//          ),
//          UIHelper.verticalSpaceSmall(),
//          Text('Test'),
//        ],
//      ),
//    );

    final space = Container(
      child:
      UIHelper.verticalSpace(50.0)
    );

    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
          child: Container(
//            height: ,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(30.0),
//            decoration: BoxDecoration(
//              gradient: LinearGradient(colors: [
//                Colors.white,
//                Colors.lightGreenAccent,
//              ]),
//            ),
            child: Column(
              children: <Widget>[ welcome_widget(), lorem_widget(), space ,comments_widget()],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
        },
        label: Text('comment'),
        icon: Icon(Icons.comment),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }

}