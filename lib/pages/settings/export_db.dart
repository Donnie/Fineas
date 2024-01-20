import 'dart:io';
import 'package:finease/core/export.dart';
import 'package:finease/db/db.dart';
import 'package:finease/db/settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;

class ExportDatabaseWidget extends StatefulWidget {
  const ExportDatabaseWidget({super.key});

  @override
  ExportDatabaseWidgetState createState() => ExportDatabaseWidgetState();
}

class ExportDatabaseWidgetState extends State<ExportDatabaseWidget> {
  Future<void> _exportDatabase() async {
    String newPath = '';
    try {
      String useEncryption =
          await SettingService().getSetting(Setting.useEncryption);
      bool encrypt = useEncryption == 'true';

      final databasePath = await DatabaseHelper().getDatabasePath();
      final time = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final dir = path.dirname(databasePath);
      String newPath = '';

      if (encrypt) {
        String dbPassword =
            await SettingService().getSetting(Setting.dbPassword);
        newPath = path.join(dir, "database_$time.db.enc");
        await encryptFile(databasePath, newPath, dbPassword);
      } else {
        newPath = path.join(dir, "database_$time.db");
        await File(databasePath).copy(newPath);
      }

      final xFile = XFile(newPath);

      await Share.shareXFiles([xFile], text: 'Here is my database file.');
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Error sharing database: $e');
      }
    } finally {
      if (newPath.isNotEmpty) {
        final fileToDelete = File(newPath);
        if (await fileToDelete.exists()) {
          await fileToDelete.delete();
        }
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Export DB"),
      leading: Icon(MdiIcons.export),
      onTap: _exportDatabase,
    );
  }
}
