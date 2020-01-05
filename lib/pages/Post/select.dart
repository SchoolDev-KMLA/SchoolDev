import 'package:dynamic_list_view/DynamicListView.dart';
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

    QuerySnapshot qn = await firestore.collection(widget.pagetitle).orderBy('timestamp').getDocuments();

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

                  return ListTile(
                    title: Text(snapshot.data[index].data['title']),
                    onTap: () => navigateToDetail(snapshot.data[index]),
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
  @override
  Widget build(BuildContext context){

    final welcome = Container(
      padding: EdgeInsets.all(15.0),
      
      child: Text(
        widget.post.data['title'],
        style: TextStyle(fontSize: 28.0, color: Colors.black),
      ),
    );

    final lorem = Container(
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(241, 241, 241, 0.8),
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0),
              bottomLeft:const Radius.circular(10.0)
          )),
      child: Text(
        widget.post.data['content'],
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
    );

    return Scaffold(
      appBar: AppBar(

      ),
      body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(30.0),
            decoration: BoxDecoration(
//              gradient: LinearGradient(colors: [
//                Colors.white,
//                Colors.lightGreenAccent,
//              ]),
            ),
            child: Column(
              children: <Widget>[ welcome, lorem],
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