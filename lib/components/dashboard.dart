// import 'package:flutter/material.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({Key? key}) : super(key: key);

//   @override
//   _DashboardState createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   EndpointsData _endpointsData;

//   @override
//   void initState() {
//     super.initState();
//     _updateData();
//   }

//   Future<void> _updateData() async {
//     final dataRespository = Provider.of<DataRepository>(context, listen: false);
//     final endpointsData = await dataRespository.getAllEndpointData();
//     setState(() {
//       _endpointsData = endpointsData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
