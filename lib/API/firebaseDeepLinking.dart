import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:storycraft/model/MDModel.dart';
import 'package:storycraft/screens/afterAuth/previewScreen.dart';

import '../Providers/Md.dart';
import '../customWidget/Toast.dart';


class FirebaseDynamicLink {
  static Future<String> createLink (MDmodel MDmodel)async{
    String linkmessage ;
    final String DynamicLink = "https://www.storycraft.com/markdown?localid=${MDmodel.localid}";
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;


    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://story4craft.page.link/md',
      link: Uri.parse(DynamicLink),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.storycraft',
        minimumVersion: 19,
      ),
    );


    //TODO:- create short link
    Uri url=await dynamicLinks.buildLink(parameters);

    linkmessage= url.toString() ;
    return linkmessage ;
  }

  static Future<void> initdynamiclink (BuildContext context)async{
    MDProvider MDProvid = Provider.of<MDProvider>(context,listen: false);

    final instancaLink = await FirebaseDynamicLinks.instance.getInitialLink() ;

    if(instancaLink!= null){

      final Uri refLink = instancaLink.link ;

      String localid = "${refLink.queryParameters["localid"]}" ;

      MDmodel temp = MDmodel(
        localid: localid
      ) ;

      await Provider.of<MDProvider>(context).FindMD(temp) ;
      Share.share("DD") ;

      showToast(context, "correct") ;

      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>PreviewScreen(MDString: MDProvid.DynamicLinkMD.details, head: MDProvid.DynamicLinkMD.heading
          , dat: "not_saved_yet")),(Route<dynamic> route) => false);

    }












    // FirebaseDynamicLinks.instance.onLink.listen(
    //       (PendingDynamicLinkData dynamiclink) async {
    //         final Uri deepLink = dynamiclink.link;
    //
    //         var data = deepLink.pathSegments.contains("MDmodel");
    //
    //
    //         if (data) {
    //
    //           String localid = "${deepLink.queryParameters['localid']}";
    //
    //           if (deepLink != null) {
    //
    //             MDmodel temp = MDmodel(
    //                 localid: localid
    //             );
    //             print("funrun");
    //             print(localid);
    //
    //             // MDProvider MDProvid = Provider.of<MDProvider>(
    //             //     context, listen: false);
    //             // await MDProvid.FindMD(temp);
    //             //
    //             // Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //             //     PreviewScreen(MDString: MDProvid.DynamicLinkMD.details,
    //             //         head: MDProvid.DynamicLinkMD.heading,
    //             //         dat: MDProvid.DynamicLinkMD.date)
    //             // ));
    //           }
    //
    //         }
    //       }
    //         );
          }
}