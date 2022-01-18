// ignore_for_file: non_constant_identifier_names
import 'package:chat_app/models/database.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainBody extends StatefulWidget {
  const MainBody({Key? key}) : super(key: key);

  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  bool isLoading = false;
  Databasemethods databasemethods = Databasemethods();
  TextEditingController searchTextEditingController = TextEditingController();
  int cupertinoTabBarIIValueGetter() => cupertinoTabBarIIValue;
  int cupertinoTabBarIIValue = 2;
  QuerySnapshot? searchsnapshot;
  initiateSearch() {
    databasemethods.getUser(searchTextEditingController.text).then((val) {
      searchsnapshot = val;
      setState(() {
        isLoading = false;
      });
    });
  }

  QuerySnapshot? allDatasnapshot;
  Future UserData() async{
     databasemethods.getUsers().then((val) {
      allDatasnapshot = val;
    });
  }
@override
  void initState() {
    setState(() {
      isLoading=true;
    });
     UserData().then((value) {
       setState(() {
         isLoading=false;
       });
     });
    super.initState();
   
 
  }
  Widget Search() {
    return searchsnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Card(context,
                userName: searchsnapshot!.docs[index]["fullname"],
                url: searchsnapshot!.docs[index]["imageUrl"]),
            itemCount: searchsnapshot?.docs.length,
          )
        : allDatasnapshot != null ?    // Container();
        ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => NCard(context,
                userNameA: allDatasnapshot?.docs[index]["fullname"],
                urlA: allDatasnapshot?.docs[index]["imageUrl"]),
            itemCount: allDatasnapshot?.docs.length,
          ):const Center(child: CircularProgressIndicator(),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: searchTextEditingController,
                    decoration: const InputDecoration(
                        hintText: "Search name....",
                        helperStyle: TextStyle(color: Colors.white)),
                  )),
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        initiateSearch();
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.orange, Colors.red],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft)),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     CupertinoTabBar.CupertinoTabBar(
              //       const Color(0xFF1DE9B6),
              //       const Color(0xFFE040FB),
              //       const [
              //         Text(
              //           "Camera",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 18.75,
              //             fontWeight: FontWeight.w400,
              //             fontFamily: "SFProRounded",
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //         Text(
              //           "Chats",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 18.75,
              //             fontWeight: FontWeight.w400,
              //             fontFamily: "SFProRounded",
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //         Text(
              //           "Calls",
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 18.75,
              //             fontWeight: FontWeight.w400,
              //             fontFamily: "SFProRounded",
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //       ],
              //       cupertinoTabBarIIValueGetter,
              //       (int index) {
              //         setState(() {
              //           cupertinoTabBarIIValue = index;
              //         });
              //       },
              //       useSeparators: true,
              //     ),
              //   ],
              // ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.765,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Search()),
          ],
        ),
      ),
    );
  }
}

Widget NCard(
  context, {
  required String userNameA,
  required String urlA,
}) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20 * 0.6),
      child: Row(children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: NetworkImage(urlA),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userNameA,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                // const SizedBox(
                //   height: 2,
                // ),
                // const Opacity(
                //   opacity: 0.6,
                //   child: Text(
                //     "This is demo!!!!!!!!!!",
                //     maxLines: 1,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // )
              ],
            ),
          ),
        ))
      ]));
}

Widget Card(context, {required String userName, required String url}) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("Chats/CG0swcWYwjN13Vh4UM7q/messages")
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> streamsnapshot) {
        if (streamsnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20 * 0.6),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(url),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChatScreen()));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      // const SizedBox(
                      //   height: 2,
                      // ),
                      // const Opacity(
                      //   opacity: 0.6,
                      //   child: Text(
                      //     "This is demo!!!!!!!!!!",
                      //     maxLines: 1,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ))
            ],
          ),
        );
      });
}
