import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'translations.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

import 'fancy_tab_bar.dart';
import 'tab_item.dart';
import 'screen/article.dart';
import 'screen/journey.dart';
import 'screen/tour.dart';
import 'screen/cart.dart';
import 'screen/me.dart';
import 'screen/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  SpecificLocalizationDelegate _localeOverrideDelegate;
 @override
  void initState(){
    super.initState();
    _localeOverrideDelegate = new SpecificLocalizationDelegate(null);
    ///
    /// Let's save a pointer to this method, should the user wants to change its language
    /// We would then call: applic.onLocaleChanged(new Locale('en',''));
    /// 
    applic.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale){
    setState((){
      _localeOverrideDelegate = new SpecificLocalizationDelegate(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //0xffbe4d51
        primarySwatch: MaterialColor(0xffbe4d51,const <int, Color>{
    50: const Color(0xffbe4d51),
    100: const Color(0xffbe4d51),
    200: const Color(0xffbe4d51),
    300: const Color(0xffbe4d51),
    400: const Color(0xffbe4d51),
    500: const Color(0xffbe4d51),
    600: const Color(0xffbe4d51),
    700: const Color(0xffbe4d51),
    800: const Color(0xffbe4d51),
    900: const Color(0xffbe4d51),
  }),
      ),
      home: MyHomePage(),
      localizationsDelegates: [
        _localeOverrideDelegate,
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: applic.supportedLocales(),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => new LoginPage(),
        /* '/screen2' : (BuildContext context) => new Screen2(),
        '/screen3' : (BuildContext context) => new Screen3(),
        '/screen4' : (BuildContext context) => new Screen4() */
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();

  static _MyHomePageState of(BuildContext context) {
    final _MyHomePageState navigator =
        context.ancestorStateOfType(const TypeMatcher<_MyHomePageState>());

    assert(() {
      if (navigator == null) {
        throw new FlutterError(
            'MyHomePageState operation requested with a context that does '
            'not include a MyStatefulWidget.');
      }
      return true;
    }());

    return navigator;
  }
}
class  EmptyAppBar  extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
  @override
  Size get preferredSize => Size(0.0,0.0);
}
class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int currentSelected = 2;
  
  set tab(int value) => setState(() {
    print("tab "+value.toString());
    currentSelected = value;
  });
  final List<Widget> _children = [new ArticleTab(), new JourneyTab(), new TourTab(), new CartTab(), new MeTab()];
  @override
  Widget build(BuildContext context) {
        //ocale myLocale = Localizations.localeOf(context);
    //print("hi"+myLocale.toString());
    return Scaffold(
      primary: false,
      appBar:  PreferredSize(
        preferredSize: Size(0.0,0.0), // here the desired height
        child: Container()
      ),
      //backgroundColor: Colors.grey.shade200,
      /* appBar: AppBar(
        backgroundColor: PURPLE,
        title: Text("Tab Bar Animation"),
      ), */
      body: _children[currentSelected],
      bottomNavigationBar: FancyBottomNavigation(
          //activeIconColor: Color(0xff2980b9),
          tabs: [
              TabData(iconData: Icons.assignment, title: Translations.of(context).text('article_tab')),
              TabData(iconData: Icons.calendar_today, title: Translations.of(context).text('journey_tab')),
              TabData(iconData: Icons.home, title: Translations.of(context).text('tour_tab')),
              TabData(iconData: Icons.shopping_cart, title: Translations.of(context).text('cart_tab')),
              TabData(iconData: Icons.person, title: Translations.of(context).text('me_tab')),
          ],
          initialSelection: currentSelected,
          onTabChangedListener: (position) {
            setState(() {
              print(position);
              currentSelected = position;
            });
          },
      ),
    );
  }
}
