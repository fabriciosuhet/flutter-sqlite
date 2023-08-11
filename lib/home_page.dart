import 'package:flutter/material.dart';
import 'package:flutter_sqlite_example/database/database_sqlite.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    _database();
  }

  Future<void> _database() async {
    final database = await DatabaseSqlite().openConnection();

    // database.insert('teste', {'nome': 'Fabrício Suhet'});
    // database.delete('teste', where: 'nome = ?', whereArgs: ['Fabrício Suhet']);
    // database.update('teste', {'nome': 'fafazin 22 rato loko'}, where: 'nome = ?', whereArgs: ['Fabrício Suhet']);

    // var result = await database.query('teste');
    // print(result);

    // database.rawInsert('insert into teste values(null, ?)', ['Fabricio']);
    // database.rawUpdate('update teste set nome = ? where id = ?', ['Fabricio Silva Suhet', 3]);
    // database.rawDelete('delete from teste where id = ?', [4]);
    var result = await database.rawQuery('select  * from teste');
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Container(),
    );
  }
}
