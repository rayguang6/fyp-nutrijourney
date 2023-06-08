import 'package:flutter/material.dart';
import 'package:nutrijourney/utils/constants.dart';
import 'package:nutrijourney/widgets/drawer.dart';
import 'package:provider/provider.dart';

import '../utils/global_variables.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {


  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Dashboard Screen'),);
  }
}
