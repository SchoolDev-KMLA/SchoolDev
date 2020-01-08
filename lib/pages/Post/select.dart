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

    QuerySnapshot qn = await firestore.collection(widget.pagetitle).orderBy('timestamp').getDocuments();

    return qn.documents;
  }
  
  navigateToDetail(DocumentSnapshot post, String pagetitle, String docid){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(post: post, pagetitle: pagetitle, docid: docid)));
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
                      onTap: () {
                        navigateToDetail(snapshot.data[index], widget.pagetitle, snapshot.data[index].documentID);

                      }
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
  final String pagetitle;
  final String docid;

  DetailPage({this.post, this.pagetitle, this.docid});

  @override
  _DatailPageState createState() => _DatailPageState();
}

class _DatailPageState extends State<DetailPage>{
  var comments_data = new List();
  bool comment_state = false;
  String message = 'comment';

  String commenttmp = "";



  final _formKey = GlobalKey<FormState>();
  final databaseReference = Firestore.instance;


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


    Widget write_comments(){
      if(comment_state == false){
        return Container(
            child:
            UIHelper.verticalSpace(50.0)
        );
      }else{
        return  Container(
          child: Form(
            key: _formKey,
            child: TextFormField(

              decoration: InputDecoration(
                  hintText: 'comments',
                  filled: false,
                  suffixIcon: IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () {
                        _onSave();
                        debugPrint('222');
                        setState(() {
                          comment_state = false;
                        });
                      })),
              validator: (value) {
                commenttmp = value;
                if (value.isEmpty) {
                  return '내용을 입력해주세요.';
                }
              },
              onSaved: (val) =>
                  setState(() {
//              widget.review.title = val;
                  }),
            ),
          )
        );
      }
    }

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
              children: <Widget>[ welcome_widget(), lorem_widget(), write_comments() ,comments_widget()],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your onPressed code here!
          setState(() {
            if(comment_state == false){
              comment_state = true;
            }else{
              comment_state = false;
            }
          });

        },
        label: Text(message),
        icon: Icon(Icons.comment),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }

  refresh() async{
    DocumentReference getcomment = Firestore.instance.collection(widget.pagetitle).document(widget.docid);
    DocumentSnapshot doc = await getcomment.get();
    setState(() {
      print(comments_data);
      comments_data = doc.data['comments'];
      print(comments_data);
    });

    print(comments_data);
  }

  _onSave() async{
    final form = _formKey.currentState;

    if (!form.validate()) {
      return;
    }

    DocumentReference getcomment = Firestore.instance.collection(widget.pagetitle).document(widget.docid);
    DocumentSnapshot doc = await getcomment.get();
    List<String> cmt =  [commenttmp];
    print(widget.docid);
    print(widget.pagetitle);
    getcomment.updateData(
        {
          'comments' : FieldValue.arrayUnion(cmt)
        }
    );
    setState(() {
      refresh();
      comments_data;
    });




//    getcomment.updateData(<String, dynamic>{'comments': FieldValue.arrayUnion([commenttmp])});
//      await databaseReference.collection(widget.pagetitle).document(widget.post.data['title']).updateData(FieldValue.arrayUnion({'comments':commenttmp}));
  }

}