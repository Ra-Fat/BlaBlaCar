import 'package:flutter/material.dart';
import 'ui/screens/ride_pref/ride_prefs_screen.dart';
import 'ui/theme/theme.dart';

void main() {
   runApp(const BlaBlaApp());
}

class BlaBlaApp extends StatelessWidget {
  const BlaBlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: Scaffold(body: RidePrefsScreen()),
    );
  }
}

// import 'package:flutter/material.dart';

// class CounterNotifyer extends ChangeNotifier {
//   int _count = 0;

//   int get count => _count;

//   void increment() {
//     _count++;
//     notifyListeners();
//   }
// }

// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(body: MyCounterApp()),
//     ),
//   );
// }

// CounterNotifyer counterNofifyer = CounterNotifyer();

// class MyCounterApp extends StatelessWidget {
//   const MyCounterApp({super.key});

//   void onPlus() {
//     counterNofifyer.increment();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: onPlus,
//         child: Text("+"),
//       ),
//       body: ListenableBuilder(
//         listenable: counterNofifyer, 
//         builder: (context, child){
//           // return Text('${co}');
//         }
//       ),
//     );
//   }
// }
