import 'package:flutter/material.dart';
import 'package:tugas_api/repository.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  Repository repository = Repository();
  final _namaController = TextEditingController();
  final _telponController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as
    List<String>;
    if (args[1].isNotEmpty) {
      _namaController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      _telponController.text = args[2];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
      ),
      body: Container(
        child: Column(children: [
          TextField(
            controller: _namaController,
            decoration: InputDecoration(
                hintText: 'Nama'
            ),
          ),
          TextField(
            controller: _telponController,
            decoration: InputDecoration(
                hintText: 'telpon'
            ),
          ),
          ElevatedButton(onPressed: () async{
            bool response = await repository.postData(_namaController.text, _telponController.text);

            if(response){
              Navigator.of(context).popAndPushNamed('/home');
            }else{
              print('Post Data Gagal!');
            }
          }, child: Text('Submit')),
          ElevatedButton(onPressed: () async{
            bool response = await repository.putData(int.parse(args[0]), _namaController.text, _telponController.text);
            if(response){
              Navigator.of(context).popAndPushNamed('/home');
            }else{
              print('Post Data Gagal!');
            }
          }, child: Text('Update'))
        ],),
      ),
    );
  }
}