import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tugas_api/add-user.dart';
import 'package:tugas_api/model.dart';
import 'package:tugas_api/repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => MyHomePage(title: 'Flutter API'),
        '/add-user': (context) => AddUser(),
      },
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Tes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> listUser = [];
  Repository repository = Repository();

  getData() async{
    listUser = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: ()=> Navigator.of(context).popAndPushNamed('/add-user'),)
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).popAndPushNamed('/add-user', arguments: [listUser[index].id, listUser[index].nama, listUser[index].telpon]),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          listUser[index].nama,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(listUser[index].telpon),
                      ],
                    ),
                  ),
                ),
                IconButton(onPressed: () async {
                  bool response = await repository.deleteData(listUser[index].id);
                  if(response) {
                    print('Delete Data Success');
                  }else{
                    print('Delete Data Failed');
                  }
                  getData();
                }, icon: Icon(Icons.delete))
              ],
            );
          },
          separatorBuilder: (context, index){
            return Divider();
          },
          itemCount: listUser.length),
    );
  }
}