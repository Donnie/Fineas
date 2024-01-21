import 'package:finease/db/months.dart';
import 'package:finease/pages/export.dart';
import 'package:finease/parts/export.dart';
import 'package:finease/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MonthsPage extends StatefulWidget {
  const MonthsPage({
    super.key,
  });

  @override
  MonthsPageState createState() => MonthsPageState();
}

class MonthsPageState extends State<MonthsPage> {
  final MonthService _monthService = MonthService();
  List<Month> months = [];

  @override
  void initState() {
    super.initState();
    loadMonths();
  }

  Future<void> loadMonths() async {
    List<Month> monthsList = await _monthService.getAllMonthsInsights();
    monthsList.sort((a, b) => b.date!.compareTo(a.date!));

    setState(() {
      months = monthsList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldStateKey =
        GlobalKey<ScaffoldState>();
    int destIndex = 0;

    void updateBody(int index) {
      setState(() {
        destIndex = index;
      });
      context.goNamed(
        destinations[destIndex].routeName.name,
        extra: () => {},
      );
    }

    return Scaffold(
      key: scaffoldStateKey,
      appBar: appBar(context, "months"),
      body: MonthCards(
        months: months,
      ),
      drawer: AppDrawer(
        onRefresh: loadMonths,
        scaffoldKey: scaffoldStateKey,
        selectedIndex: 1,
        destinations: destinations,
        onDestinationSelected: updateBody,
      ),
    );
  }
}