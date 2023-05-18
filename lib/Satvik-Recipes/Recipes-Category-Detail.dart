import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harekrishnagoldentemple/Home/service/check_internet_services.dart';
import 'package:harekrishnagoldentemple/Satvik-Recipes/Recipes-Detail.dart';
import 'package:shimmer/shimmer.dart';

class RCDetail extends StatefulWidget {
  final String category;

  const RCDetail({super.key, required this.category});

  @override
  State<RCDetail> createState() => _RCDetailState();
}

class _RCDetailState extends State<RCDetail> {
  Connectivity connectivity=Connectivity();
  @override
  Widget build(BuildContext context) {
       return  StreamBuilder<ConnectivityResult>(
        stream: connectivity.onConnectivityChanged,
        builder: (_,snapshot){
          return  CheckInterConnection(snapshot: snapshot,widget: dataBody(),);
        },
      );
   }
   dataBody(){
      return Scaffold(
      appBar: AppBar(title: Text(widget.category), backgroundColor: Colors.white,),
      body: SingleChildScrollView(child: Column(children: [
        SizedBox(height: 40,),
                      StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("RCDetail")
                  .where("Category", isEqualTo: widget.category)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Text('No data found');
                }
                return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: (1 / 1.5), mainAxisSpacing: 16, crossAxisSpacing: 16),
        physics:  NeverScrollableScrollPhysics(),
        itemCount: snapshot.data!.size,
        padding: EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
                                final DocumentSnapshot document =
                          snapshot.data!.docs[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => RDetail(document: document)));
            },
            child: Stack(
              children: [
                CachedNetworkImage(
                                
                                imageUrl: document['Image'],
  imageBuilder: (context, imageProvider) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      
      image: DecorationImage(
        
        image: imageProvider, fit: BoxFit.cover, ),
    ),
  ),
                                
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ),

              
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.black.withOpacity(0.4), shape: StadiumBorder()),
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.schedule_outlined, color: Colors.white, size: 15),
                            Text(" " + document['Views'].toString(), style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w300)),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      document['Title'],
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ],
                  ),
                ),
              ],
            ),
          );
        },
          );
              },
            ),

      ],)),
    );
 
   }
}