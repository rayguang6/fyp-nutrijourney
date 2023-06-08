import 'package:flutter/material.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Planner Screen'),);
  }
}