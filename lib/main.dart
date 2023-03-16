import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/app/screens/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        fontFamily: 'Raleway',
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_blurhash/flutter_blurhash.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: BlurHashDemo(),
//     );
//   }
// }

// class BlurHashDemo extends StatelessWidget {
//   const BlurHashDemo({super.key});

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         appBar: AppBar(backgroundColor: Colors.teal, automaticallyImplyLeading: false, title: const Text("Flutter BlurHash Demo")),
//         body: Center(
//           child: BlurHash(
//             imageFit: BoxFit.fitWidth,
//             duration: const Duration(seconds: 4),
//             curve: Curves.bounceInOut,
//             hash: 'LHA-Vc_4s9ad4oMwt8t7RhXTNGRj',
//             image:
//                 'https://images.unsplash.com/photo-1486072889922-9aea1fc0a34d?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bW91dGFpbnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
//           ),
//         ),
//       );
// }
