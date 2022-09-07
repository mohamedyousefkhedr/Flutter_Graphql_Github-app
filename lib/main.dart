import 'package:flutter/material.dart';
import 'package:flutter_graphql_app/view.dart';
import 'package:graphql_flutter/graphql_flutter.dart';



void main() async {

  // We're using HiveStore for persistence,
  // so we need to initialize Hive.


  await initHiveForFlutter();



  runApp(
      const MaterialApp(
        title: 'Flutter With GraphQl',
        debugShowCheckedModeBanner: false,

        home: MyApp(title: 'Flutter Demo Home Page'),
      ));
}






class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.title});


  final String title;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {

    String personal_access_tokens = "Put Your Own Github personal_access_tokens  " ;


    final HttpLink httpLink = HttpLink(
      'https://api.github.com/graphql',
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer $personal_access_tokens',
      // OR
      // getToken: () => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    );

    final Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    return  GraphQLProvider(client: client, child: const MyHomePage(),);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const View();

  }
}



