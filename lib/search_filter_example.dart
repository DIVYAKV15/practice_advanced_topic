import 'package:flutter/material.dart';

void main() {
  runApp(const SearchFilter());
}

class SearchFilter extends StatelessWidget {
  const SearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Search filter"),
        ),
        body: SearchTextDemo(),
      ),
    );
  }
}

class SearchTextDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SeachTextDemoState();
}

class SeachTextDemoState extends State<SearchTextDemo> {
  List<String> allItems = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Fig',
    'Grapes',
    'Kiwi',
    'Lemon',
    'Mango',
    'Orange',
    'Peach',
    'Pear',
    'Plum',
    'Raspberry',
    'Strawberry',
  ];
  String searchText = ''; //initially we are making it as empty
  String searchResult = '';
  void filterItems(String query) {
    setState(() {
      searchText =
          query; //as every time we pass value it has to change and show
      searchResult =
          ''; // Reset the search result when typing in the search field
    });
  }

  void setSearchResult(String result) {
    setState(() {
      searchResult =
          result; //below in searchresult we have to show the result so setting in setState
    });
  }

  @override
  Widget build(BuildContext context) {
    ///converting the above all items into lowercase and storing it inside the filtereditems
    List<String> filteredItems = allItems
        .where(
            (items) => items.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            //passing the value which we typing in search bar
            onChanged: (value) {
              filterItems(value);
            },
            decoration: const InputDecoration(
              labelText: 'Search',
              hintText: 'Enter a fruit name',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16),
          //to show down all the items in the screen
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredItems[index]), //searched text
                  onTap: () {
                    setSearchResult(
                        filteredItems[index]); //same searched text passing here
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Search Result: $searchResult', //searched text shown here
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
