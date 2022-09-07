import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql_app/query.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

//Dart uses a notation with three quotes to make the queries.

class View extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {





    return  Scaffold(
      appBar: AppBar(
        centerTitle:true ,
        title: const Text("My GitHub Using Flutter + GraphQl"),
        backgroundColor: Colors.black,),
      body:   Query(
        options: QueryOptions(
          document: gql( readRepo ),
          fetchPolicy:FetchPolicy.noCache ,

          pollInterval: const Duration(seconds: 10),
        ),

          builder: (QueryResult result, { VoidCallback? refetch, FetchMore? fetchMore })




      {


          if (result.hasException) {
            return Center(
                child: Text(
                  result.exception.toString(),
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ));
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
      if (kDebugMode) {
        print(result) ;
      }
          // it can be either Map or List
          final userDetails = result.data!['user'];
          List starredRepositories =
          result.data!['viewer']['repositories']['nodes'] ;

          return Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 2,
                        ),
                        ClipOval(
                          child: Image.network(
                            userDetails["avatarUrl"],
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                            height: 100.0,
                            width: 100.0,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          userDetails['name'],
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          userDetails['login'],
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              userDetails['location'],
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.link,
                              color: Colors.grey,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              userDetails['url'],
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Icon(
                              Icons.email,
                              color: Colors.grey,
                              size: 16,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              userDetails['email'],
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    userDetails["repositories"]['totalCount']
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "Repositories",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    userDetails["followers"]['totalCount']
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "Followers",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    userDetails["following"]['totalCount']
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "Following",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                    EdgeInsets.only(top: 10.0, bottom: 2, left: 10),
                    child: Text(
                      "Starred Repositories",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 330.0),
                child: ListView.builder(
                  itemCount: starredRepositories.length,
                  itemBuilder: (context, index) {
                    final repository = starredRepositories[index];
                    return Padding(
                      padding:
                      const EdgeInsets.only(left: 10.0, top: 8, bottom: 8),
                      child: Card(
                        elevation: 0,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.collections_bookmark),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              repository['nameWithOwner'],
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );





  }
}






