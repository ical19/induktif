import 'package:flutter/material.dart';
import 'package:induktif/data/theme/induktif_theme.dart';

class PostLoading extends StatelessWidget {
  final String? idUrl;
  const PostLoading({Key? key, this.idUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: LinearProgressIndicator(
          backgroundColor: Colors.white,
          value: 3,
          valueColor: AlwaysStoppedAnimation(Colors.grey[350])),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: const Center(
          child: SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white)))),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // SizedBox(height: 10.0),
        Icon(
          Icons.directions_car,
          color: Colors.grey[400],
          size: 40.0,
        ),
        const SizedBox(
          width: 90.0,
          child: Divider(color: Colors.white),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
            height: 10,
            width: MediaQuery.of(context).size.width * 0.8,
            child: LinearProgressIndicator(
              backgroundColor: Colors.lightBlueAccent.withOpacity(0.9),
              valueColor: AlwaysStoppedAnimation(Colors.grey[350]),
            )),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
            height: 10,
            width: MediaQuery.of(context).size.width * 0.6,
            child: LinearProgressIndicator(
              backgroundColor: Colors.lightBlueAccent.withOpacity(0.9),
              valueColor: AlwaysStoppedAnimation(Colors.grey[350]),
            )),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
            height: 10,
            width: MediaQuery.of(context).size.width * 0.5,
            child: LinearProgressIndicator(
              backgroundColor: Colors.lightBlueAccent.withOpacity(0.9),
              valueColor: AlwaysStoppedAnimation(Colors.grey[350]),
            )),
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            const SizedBox(width: 15),
            const SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                )),
            Expanded(flex: 3, child: coursePrice)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: InduktifTheme.lightText,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Center(
            child: SingleChildScrollView(child: topContentText),
          ),
        ),
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                    icon: const Icon(Icons.info_outline), onPressed: () {})
              ],
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: const Text('Please wait..',
                      style: TextStyle(fontSize: 24, color: Colors.grey)),
                  background: topContent),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      // appBar: AppBar(
      //   title: SizedBox(
      //       width: MediaQuery.of(context).size.width * 0.4,
      //       height: 10,
      //       child: LinearProgressIndicator(
      //         backgroundColor: Colors.lightBlueAccent.withOpacity(0.9),
      //         valueColor: AlwaysStoppedAnimation(Colors.grey[350]),
      //       )),
      //   actions: [
      //     IconButton(icon: const Icon(Icons.info_outline), onPressed: () {})
      //   ],
      // ),
      // body: SingleChildScrollView(
      //         child: Column(
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: <Widget>[
      //       topContent,
      //       Container(
      //         height: MediaQuery.of(context).size.height * 0.6,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Center(
      //               child: CircularProgressIndicator(),
      //             ),
      //             SizedBox(height: 15),
      //             Text('loading..'),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
