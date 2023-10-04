import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:signupform/firebase_options.dart';
import 'package:signupform/screens/login.dart';
import 'package:signupform/screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';

// import 'code_page.dart';
// import 'sources/signup.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Flutter FormBuilder Demo',
//       debugShowCheckedModeBanner: false,
//       localizationsDelegates: [
//         FormBuilderLocalizations.delegate,
//         ...GlobalMaterialLocalizations.delegates,
//         GlobalWidgetsLocalizations.delegate,
//       ],
//       supportedLocales: FormBuilderLocalizations.supportedLocales,
//       home: _HomePage(),
//     );
//   }
// }

// class _HomePage extends StatelessWidget {
//   const _HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CodePage(
//       title: 'Flutter Form Builder',
//       child: ListView(
//         children: <Widget>[
//           ListTile(
//             title: const Text('Signup Form'),
//             trailing: const Icon(Icons.arrow_right_sharp),
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return const CodePage(
//                       title: 'Signup Form',
//                       child: SignupForm(),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//           const Divider(),
//         ],
//       ),
//     );
//   }
// }
