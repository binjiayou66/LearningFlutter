#Flutter 页面间数据传递(共享)的几种常用方式

###1. 通过构造器(constructor)传递数据

```dart
// // Page A to Page B
final data = TransferDataEntity("001", "张三丰", 18);
MaterialPageRoute(builder: (context) => DataTransferByConstructorPage(data: data)));
```

###2. 当一个页面关闭时携带数据到上一个页面（Navigator.pop）

```dart
// Page A to Page B
final dataFromOtherPage = await Navigator.push(MaterialPageRoute(builder: (context) => TransferRouterPage(data: data))) as TransferDataEntity;
// Page B
var transferData = TransferDataEntity("嘻嘻哈哈","007",20);
Navigator.pop(context,transferData);
```

###3. InheritedWidget方式

（1）基本用法

```dart
// Provider
class IDataProvider extends InheritedWidget{
 
  final TransferDataEntity data;
 
  IDataProvider({Widget child,this.data}):super(child:child);
 
  @override
  bool updateShouldNotify(IDataProvider oldWidget) {
    return data!=oldWidget.data;
  }
 
  static IDataProvider of(BuildContext context){
    // inheritFromWidgetOfExactType find target widget.
    return context.inheritFromWidgetOfExactType(IDataProvider);
  }
}

// Page A to Page B, Wrap Page B with Provider.
Navigator.push(context, MaterialPageRoute(builder: (context) => IDataProvider(child: IDataWidget(), data: data)));

// Page B
class IDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = IDataProvider.of(context).data;
 
    return Scaffold(
      appBar: AppBar(
        title: Text("Inherited方式传递数据"),
      ),
      body: ...,
    );
  }
}
```

（2）引入泛型

```dart
// Generic Provider
class IGenericDataProvider<T> extends InheritedWidget {
  final T data;
 
  IGenericDataProvider({Key key, Widget child, this.data})
      : super(key: key, child: child);
 
  @override
  bool updateShouldNotify(IGenericDataProvider oldWidget) {
    return data != oldWidget.data;
  }
 
  static T of<T>(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(
            IGenericDataProvider<T>().runtimeType) as IGenericDataProvider<T>).data;
  }
}

// Page A to Page B, Wrap Page B with Provider.
Navigator.push(context, MaterialPageRoute(builder: (context) => IGenericDataProvider<TransferDataEntity>(child: IDataWidget(), data: data)));

// Page B
class IGenericDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = IGenericDataProvider.of<TransferDataEntity>(context);
 
    return Scaffold(
      appBar: AppBar(
        title: Text("Inherited泛型方式传递数据"),
      ),
      body: ...,
    );
  }
}
```

###4. 全局的InheritedWidget方式

```dart
// This widget is the root of your application.
class MyApp extends StatelessWidget {
  // shared data
  var params = InheritedParams();
 
  @override
  Widget build(BuildContext context) {
    return IGenericDataProvider(
      data: params,
      child: MaterialApp(
        title: 'Data Transfer Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Data Transfer Demo'),
      ),
    );
  }
}

// Child Page 
class InheritedParamsPage extends StatefulWidget {
  @override
  _InheritedParamsPageState createState() => _InheritedParamsPageState();
}
 
class _InheritedParamsPageState extends State<InheritedParamsPage> {
  @override
  Widget build(BuildContext context) {
    // Get shared data.
    final data = IGenericDataProvider.of<TransferDataEntity>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("通过全局数据方式"),
      ),
      body: ...,
    );
  }
}
```

###5. 全局单例模式

```dart
// Singleton Class Definition
class TransferDataSingleton {
  static final TransferDataSingleton _instanceTransfer =
      TransferDataSingleton.__internal();
 
  TransferDataEntity transData;
 
  factory TransferDataSingleton() {
    return _instanceTransfer;
  }
 
  TransferDataSingleton.__internal();
}

// Set Singleton Data
var transferData = TransferDataEntity("二汪", "002", 25);
transSingletonData.transData = transferData;
// Page A to Page B
Navigator.push(context, MaterialPageRoute(builder: (context) => TransferSingletonPage()));

// Page B
class TransferSingletonPage extends StatefulWidget {
  @override
  _TransferSingletonPageState createState() => _TransferSingletonPageState();
}

class _TransferSingletonPageState extends State<TransferSingletonPage> {
  @override
  Widget build(BuildContext context) {
    // Use Singleton Data
    var data = transSingletonData.transData;
    return Scaffold(
      appBar: AppBar(
        title: Text("全局单例传递数据"),
      ),
      body: ...,
    );
  }
}
```

###6. 全局单例结合Stream

```dart
// Singleton Class Definition
class TransferStreamSingleton {
  static final TransferStreamSingleton _instanceTransfer =
      TransferStreamSingleton.__internal();
  StreamController streamController;
 
  void setTransferData(TransferDataEntity transData) {
    streamController = StreamController<TransferDataEntity>();
    streamController.sink.add(transData);
  }
 
  factory TransferStreamSingleton() {
    return _instanceTransfer;
  }
 
  TransferStreamSingleton.__internal();
}

// Set Singleton Data
var transferData = TransferDataEntity("三喵", "005", 20);
streamSingletonData.setTransferData(transferData);
// Page A to Page B
Navigator.push(context, MaterialPageRoute(builder: (context) => TransferStreamPage()));

// Page B
class TransferStreamPage extends StatefulWidget {
  @override
  _TransferStreamPageState createState() => _TransferStreamPageState();
}

class _TransferStreamPageState extends State<TransferStreamPage> {
 
  StreamController _streamController = streamSingletonData.streamController;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("全局单例结合Stream"),
        ),
        body: StreamBuilder(
                stream: _streamController.stream,
                initialData: TransferDataEntity("", "", 0),
                builder: (context, snapshot) {
                  return Center(child: Text(snapshot.data.name));
    }));
  }
 
  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }
}
```

