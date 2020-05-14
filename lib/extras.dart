//drawer: Drawer(
//child: Container(
//color: Color(0xfffce4ec),
//child: ListView(
//padding: EdgeInsets.zero,
//children: <Widget>[
//UserAccountsDrawerHeader(
//decoration: BoxDecoration(
//color: Color(0xffC2185B),
//),
//accountName: Text(
//'John Doe',
//style: TextStyle(
//color: Colors.white,
//fontSize: 24,
//),
//),
//accountEmail: Text('johndoe@email.com'),
//currentAccountPicture: Icon(
//Icons.account_circle,
//size: 60,
//color: Colors.white,
//),
//arrowColor: Colors.black,
//),
//ListTile(
//leading: Icon(Icons.alarm),
//title: Text('Reminder Settings'),
//),
//FlatButton(
//padding: EdgeInsets.zero,
//child: ListTile(
//leading: Icon(Icons.account_circle),
//title: Text('Profile'),
//),
//onPressed: () {
//Navigator.pushNamed(context, '/profile');
//},
//),
//ListTile(
//leading: Icon(Icons.settings),
//title: Text('Settings'),
//),
//],
//),
//),
//),
//
//Column(
//crossAxisAlignment: CrossAxisAlignment.stretch,
//children: <Widget>[
//Icon(
//outOfHouse ? Icons.directions_walk : Icons.home,
//size: 60,
//),
//Text(
//'${outOfHouse ? 'Come back soon' : 'welcome Home'}',
//textAlign: TextAlign.center,
//style: TextStyle(
//fontSize: 20,
//),
//),
//],
//),
