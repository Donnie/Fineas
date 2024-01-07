import 'package:finease/core/common.dart';
import 'package:finease/db/entries.dart';
import 'package:finease/pages/add_entry/entry_body.dart';
import 'package:finease/parts/export.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});

  @override
  AddEntryScreenState createState() => AddEntryScreenState();
}

class AddEntryScreenState extends State<AddEntryScreen> {
  final EntryService _entryService = EntryService();

  final _formState = GlobalKey<FormState>();
  final _entryNotes = TextEditingController();
  final _entryAmount = TextEditingController();
  bool entryLiquid = true;

  @override
  Widget build(BuildContext context) {
    return AppAnnotatedRegionWidget(
      color: context.background,
      child: Scaffold(
        appBar: AppBar(title: const Text('Add Entry')),
        body: AddEntryForm(
          formState: _formState,
          entryNotes: _entryNotes,
          entryAmount: _entryAmount,
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AppBigButton(
          onPressed: () {
            _submitForm();
            context.pop();
          },
          title: "Add",
        ),
      ),
    );
  }

  void _submitForm() async {
    // String entryNotes = _entryNotes.text;
    // String entryCurrency = _entryCurrency.text;
    // double balance = double.tryParse(_entryAmount.text) ?? 0;
    // if (_formState.currentState?.validate() ?? false) {
    //   _formState.currentState?.save();
    //   Entry entry = Entry(
    //     name: entryNotes,
    //     currency: entryCurrency,
    //     balance: balance,
    //     liquid: entryLiquid,
    //     type: entryType,
    //   );
    //   await _entryService.createEntry(entry);
    // }
  }
}

class AddEntryForm extends StatelessWidget {
  final GlobalKey<FormState> formState;
  final TextEditingController entryNotes;
  final TextEditingController entryAmount;

  const AddEntryForm({
    super.key,
    required this.formState,
    required this.entryNotes,
    required this.entryAmount,
  });

  @override
  Widget build(BuildContext context) {
    return AddEntryBody(
      formState: formState,
      entryNotes: entryNotes,
      entryAmount: entryAmount,
    );
  }
}