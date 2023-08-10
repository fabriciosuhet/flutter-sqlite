// ignore_for_file: avoid_print

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqlite {
  // Future<Database> openConnection() async {
  Future<void> openConnection() async {
    var databasePath = await getDatabasesPath();
    final databaseFinalPath = join(databasePath, 'SQLITE_EXAMPLE');

    await openDatabase(databaseFinalPath,
        version: 2, onConfigure: (db) async {
          await db.execute('PRAGMA foreing_keys = ON');
        },
        // Chamado somente no momento de criação do banco de dados
        // primeira vez que carrega o aplicativo
        onCreate: (Database db, int version) {
      final batch = db.batch();

      batch.execute('''
            create table teste(
              id Integer primary key autoincrement,
              nome varchar(200)
            )
        ''');
      batch.commit();
    },

        // Será chamando sempre que ouver uma alteração no version incrimental ( 1 -> 2)
        onUpgrade: (Database db, int oldVersion, int version) {
      final batch = db.batch();

      if (oldVersion == 1) {
        batch.execute('''
            create table produto(
              id Integer primary key autoincrement,
              nome varchar(200)
            )
        ''');
      }
      batch.commit();
    },

        // Será chamando sempre que ouver uma alteração no version decremental ( 2 -> 1)
        onDowngrade: (Database db, int oldVersion, int version) {
      final batch = db.batch();

      if (oldVersion == 3) {
        batch.execute('''
            drop table produto
        ''');
      }
      batch.commit();
    });
  }
}
