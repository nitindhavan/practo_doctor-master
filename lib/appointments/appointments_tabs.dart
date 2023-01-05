import 'package:flutter/material.dart';
import 'package:practo_doctor/tab/past_appointment.dart';
import 'package:practo_doctor/tab/status_appointment.dart';
import 'package:practo_doctor/tab/upcomming_appointment.dart';

class AppointmentsTabssTabs extends StatefulWidget {
  AppointmentsTabssTabs({super.key});

  @override
  State<AppointmentsTabssTabs> createState() => _AppointmentsTabssTabsState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _AppointmentsTabssTabsState extends State<AppointmentsTabssTabs>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'My Appointments',
          style: TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
          indicatorColor: Colors.blue,
          labelColor: Colors.black,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Status',
            ),
            Tab(
              text: 'Upcomming',
            ),
            Tab(
              text: 'Past',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          StatusAppointment(
            
          ),
          UpComing(),
          Past()
        ],
      ),
    );
  }
}
