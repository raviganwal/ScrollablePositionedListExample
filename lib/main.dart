import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ItemPositionsListener itemPositionListener =
      ItemPositionsListener.create();
  ItemScrollController _itemScrollController = ItemScrollController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentVisibleIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      backgroundColor: Colors.blue,
                      expandedHeight: 112,
                      snap: true,
                      pinned: false,
                      floating: true,
                      forceElevated: true,
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.event),
                        )
                      ],
                      flexibleSpace: SafeArea(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: kToolbarHeight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Title',
                                    style: Theme.of(context)
                                        .textTheme
                                        .title
                                        .copyWith(
                                            fontSize: 16, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Date',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                            fontSize: 10, color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Another Text',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .copyWith(
                                            fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: kToolbarHeight,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      'Prev',
                                    ),
                                    Text(
                                      'Next',
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
              body: ScrollablePositionedList.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemPositionsListener: itemPositionListener,
                  itemScrollController: _itemScrollController,
                  initialScrollIndex: 0,
                  itemCount: 500,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text('$index'));
                  })),
        ],
      ),
    );
  }

  currentVisibleIndex() {
    itemPositionListener.itemPositions.addListener(() {
      int min;
      int max;
      if (itemPositionListener.itemPositions.value.isNotEmpty) {
        // Determine the first visible item by finding the item with the
        // smallest trailing edge that is greater than 0.  i.e. the first
        // item whose trailing edge in visible in the viewport.
        min = itemPositionListener.itemPositions.value
            .where((ItemPosition position) => position.itemTrailingEdge > 0)
            .reduce((ItemPosition min, ItemPosition position) =>
                position.itemTrailingEdge < min.itemTrailingEdge
                    ? position
                    : min)
            .index;
        print('Min Index $min');
        currentIndex = min;
      }
    });
  }
}
