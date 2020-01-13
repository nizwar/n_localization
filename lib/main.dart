import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; 
import 'package:provider/provider.dart';

import 'anotherScreen.dart';
import 'localization/appLanguage.dart';
import 'localization/localization.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AppLanguage _appLanguage = AppLanguage();

  @override
  void initState() {
    _appLanguage.fetchLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => _appLanguage,
        child: Consumer<AppLanguage>(
          builder: (context, model, child) {
            print(model.locale);
            return MaterialApp(
              locale: model.locale,
              supportedLocales: [
                Locale("en"),
                Locale("id"),
                Locale("ta"),
              ],
              localizationsDelegates: [
                MyLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: TheScreen(),
            );
          },
        ));
  }
}

class TheScreen extends StatelessWidget {
  const TheScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLanguage provider = Provider.of<AppLanguage>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(MyLocalization.of(context).translate("title") ?? ""),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                MyLocalization.of(context).translate("message"),
                textAlign: TextAlign.center,
              ),
              Divider(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FlatButton(
                    child: Text("English"),
                    onPressed: () {
                      provider.changeLanguage(Locale("en"));
                    },
                  ),
                  FlatButton(
                    child: Text("Indonesia"),
                    onPressed: () {
                      provider.changeLanguage(Locale("id"));
                    },
                  ),
                  FlatButton(
                    child: Text("Tamil"),
                    onPressed: () {
                      provider.changeLanguage(Locale("ta"));
                    },
                  ),
                ],
              ),
              FlatButton(
                child: Text(MyLocalization.of(context).translate("next_screen")),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AnotherScreen();
                  }));
                },
              ),
            ],
          ),
        ));
  }
}
