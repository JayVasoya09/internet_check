
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

final Connectivity _connectivity = Connectivity();
late StreamSubscription<ConnectivityResult> _connectivitySubscription;


Future<bool> checkinternet() async
{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) { return true; } else { return false; }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _connectivitySubscription = _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
    if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) { Get.back(); } else {nointernet(Get.context,'assets/lottie/exit.json', 'No Internet Connection', 'Please Check Your Internet Connection');}
  });
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Internetcheck(),
    );
  }
}

class Internetcheck extends StatefulWidget {
  const Internetcheck({super.key});

  @override
  State<Internetcheck> createState() => _InternetcheckState();
}

class _InternetcheckState extends State<Internetcheck> {

   @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Connection',style: TextStyle(color: Colors.white,fontSize: 18,),),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page 1',style: TextStyle(color: Colors.black,fontSize: 15),),
            const SizedBox(height: 15,),
            OutlinedButton(
              onPressed: () async
              {
                if(await checkinternet())
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Nextpage()));
                }
                else
                {
                  nointernet(context,'assets/lottie/exit.json', 'No Internet Connection', 'Please Check Your Internet Connection');
                }
              }, 
              child: const Text('Next Page',style: TextStyle(color: Colors.black,fontSize: 15),),
            )
          ],
        ),
      ),
    );
  }
}

class Nextpage extends StatefulWidget {
  const Nextpage({super.key});

  @override
  State<Nextpage> createState() => _NextpageState();
}

class _NextpageState extends State<Nextpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Connection',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page 2',style: TextStyle(color: Colors.black,fontSize: 15),),
            const SizedBox(height: 10,),
            OutlinedButton(
              onPressed: () async
              {
                if(await checkinternet())
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Secondpage()));
                }
                else
                {
                  nointernet(context,'assets/lottie/exit.json', 'No Internet Connection', 'Please Check Your Internet Connection');
                }
              },  
            child: const Text('Next Page',style: TextStyle(color: Colors.black,fontSize: 15),),
            )
          ],
        ),
      ),
    );
  }
}

class Secondpage extends StatefulWidget {
  const Secondpage({super.key});

  @override
  State<Secondpage> createState() => _SecondpageState();
}

class _SecondpageState extends State<Secondpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Connection',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Thank You',style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}



nointernet(context,String lottie,String title,String subtitle)async{
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black.withOpacity(0.2),
        body: Center(
          child: Container(
            height: 266,
            width: MediaQuery.of(context).size.width/1.3,
            padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white
            ),
            child: Column(
              children: [
                Lottie.asset(
                  lottie,
                  repeat: true,
                  animate: true,
                  width: 150,
                ),
                const SizedBox(height: 30,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 14,height: 1),),
                    const SizedBox(height: 15,),
                    Text(subtitle,style: const TextStyle(color: Colors.black,fontSize: 12,height: 1),),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            SystemNavigator.pop();
                          },
                          child: Container(
                            height: 33,
                            width: MediaQuery.of(context).size.width/3.2,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: 
                            const Text(
                              'Close',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              )
                            ),
                          )
                        ),
                        InkWell(
                          onTap: ()async
                            {
                              Navigator.pop(context);
                          },
                          child: Container(
                            height: 33,
                            width: MediaQuery.of(context).size.width/3.2,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: 
                            const Text(
                              'Retry',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              )
                            ),
                          )
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      );
    },
  );  
}