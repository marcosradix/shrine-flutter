import 'package:flutter/material.dart';
import 'model/data.dart';
import 'model/product.dart';
import 'package:intl/intl.dart';
import 'package:Shrine/drawerside/drawerSide.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  String get _currencySimble => "R\$";
  String get _localeCurrency => "pt_BR";
  SearchBar searchBar;

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      title: new Text('SHRINE'),
      actions: [
        searchBar.getSearchAction(context),
        IconButton(
          icon: Icon(Icons.tune),
          onPressed: () {
            print('Filter button');
          },
        ),
      ],
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          print('Menu button');
          this._scaffoldKey.currentState.openDrawer();
        },
      ),
    );
  }

  void onSubmitted(String value) {
    setState(() => _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('Você escreveu $value!'))));
  }

  @override
  void initState() {
    searchBar = new SearchBar(
        inBar: false,
        hintText: "Pesquisar",
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerSide(),
      appBar: this.searchBar.build(context),
      body: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          childAspectRatio: 8.0 / 9.0,
          children: _buildGridCards(context)),
    );
  }

  List<Card> _buildGridCards(BuildContext context) {
    List<Product> products = getProducts(Category.all);

    if (products == null || products.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter =
        NumberFormat.currency(symbol: _currencySimble, locale: _localeCurrency);

    return products.map((product) {
      return Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new InkWell(
              child: AspectRatio(
                aspectRatio: 18 / 11,
                child: Image.asset(
                  product.assetName,
                  //imagens
                  package: product.assetPackage,
                  fit: BoxFit.fitWidth,
                ),
              ),
              onTap: () {
                //exibir alert
                alertDialogFull(
                    product.name, product.price);
              },
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: theme.textTheme.title,
                      maxLines: 1,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      formatter.format(product.price),
                      style: theme.textTheme.body2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  alertDialogFull(String nomeProduto, int price) {
    final NumberFormat formatter =
        NumberFormat.currency(symbol: _currencySimble, locale: _localeCurrency);
    String nome = nomeProduto;
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            title: new Text(nome),
            content: new Text("${formatter.format(price)}"),
            actions: <Widget>[
              new FlatButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(_).pop();
                },
              ),
            ],
          ),
    );
  }
}
