##一、一切皆Widget

### Widget与Element

####【前言】

1. 在Flutter中，`Widget`的功能是“描述一个UI元素的配置数据”，它就是说，`Widget`其实并不是表示最终绘制在设备屏幕上的显示元素，而只是显示元素的一个配置数据。
2. Flutter中真正代表屏幕上显示元素的类是`Element`，也就是说Widget只是描述`Element`的一个配置。一个Widget对象可以对应多个Element对象，因为同一个Widget对象可以被添加到UI树的不同部分，而真正渲染时，UI树的每一个Widget节点都会对应一个`Element`对象。
3. Flutter中几乎所有的对象都是一个Widget，与原生开发中”控件”不同的是，Flutter中的widget的概念更广泛，它不仅可以表示UI元素，也可以表示一些功能性的组件如：用于手势检测的 `GestureDetector` widget、用于应用主题数据传递的`Theme`等等。而原生开发中的控件通常只是指UI元素。在后面的内容中，我们在描述UI元素时，我们可能会用到“控件”、“组件”这样的概念，读者心里需要知道他们就是widget，只是在不同场景的不同表述而已。由于Flutter主要就是用于构建用户界面的，所以，在大多数时候，读者可以认为widget就是一个控件，不要纠结于概念。

#### 【Widget】

继承：Widget->DiagnosticableTree->Diagnosticable

```dart
@immutable
abstract class Widget extends DiagnosticableTree {
  const Widget({ this.key });
  final Key key;

  @protected
  Element createElement();

  @override
  String toStringShort() {
    return key == null ? '$runtimeType' : '$runtimeType-$key';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.dense;
  }

  static bool canUpdate(Widget oldWidget, Widget newWidget) {
    return oldWidget.runtimeType == newWidget.runtimeType
        && oldWidget.key == newWidget.key;
  }
}
```



### StatelessWidget

用于不需要维护状态的场景，继承自Widget。



### StatefullWidget

用于需要维护状态的场景，继承自Widget。

```dart
abstract class StatefulWidget extends Widget {
  const StatefulWidget({ Key key }) : super(key: key);

  @override
  StatefulElement createElement() => new StatefulElement(this);

  @protected
  State createState();
}
```

####createState方法

返回一个State（或者其子类）实例。

用于创建和Stateful widget相关的状态，它在Stateful widget的生命周期中可能会被多次调用。例如，当一个Stateful widget同时插入到widget树的多个位置时，Flutter framework就会调用该方法为每一个位置生成一个独立的State实例，其实，本质上就是一个`StatefulElement`对应一个State实例。

#### state

State表示与其对应的StatefulWidget要维护的状态。

维护的状态信息用于：

​	1.在widget build时可以被同步读取 

​	2.当State被改变时，可以手动调用其`setState()`方法通知Flutter framework状态发生改变，Flutter framework在收到消息后，会重新调用其`build`方法重新构建widget树，从而达到更新UI的目的。

常用属性：

​	1.`widget`，它表示与该State实例关联的widget实例，由Flutter framework动态设置。

​	2.`context`，它是`BuildContext`类的一个实例，表示构建widget的上下文，它是操作widget在树中位置的一个句柄，它包含了一些查找、遍历当前Widget树的一些方法。每一个widget都有一个自己的context对象。

生命周期：

```dart
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  final int initValue;

  CounterWidget({ Key key, this.initValue:0 });

  _CounterState createState() => _CounterState();
}

class _CounterState extends State<CounterWidget> {
  int _counter; // 状态信息

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _counter = widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print("build");
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: ()=>setState(() => ++_counter),
          child: Text("$_counter"),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }
}
```

- `initState`：当Widget第一次插入到Widget树时会被调用，对于每一个State对象，Flutter只会调用一次该回调，所以，通常在该回调中做一些一次性的操作，如状态初始化、订阅子树的事件通知等。
- `didChangeDependencies()`：当State对象的依赖发生变化时会被调用。典型的场景是当系统语言Locale或应用主题改变时，Flutter framework会通知widget调用此回调。
- `build()`：此回调读者现在应该已经相当熟悉了，它主要是用于构建Widget子树的，会在如下场景被调用：
  1. 在调用`initState()`之后。
  2. 在调用`didUpdateWidget()`之后。
  3. 在调用`setState()`之后。
  4. 在调用`didChangeDependencies()`之后。
  5. 在State对象从树中一个位置移除后（会调用deactivate）又重新插入到树的其它位置之后。
- `reassemble()`：此回调是专门为了开发调试而提供的，在热重载(hot reload)时会被调用，此回调在Release模式下永远不会被调用。
- `didUpdateWidget()`：在widget重新构建时，Flutter会调用`Widget.canUpdate`来检测Widget树中同一位置的新旧节点，然后决定是否需要更新，如果`Widget.canUpdate`返回`true`则会调用此回调（新旧widget的key和runtimeType同时相等时会返回true）。
- `deactivate()`：当State对象从树中被移除时，会调用此回调。在一些场景下，Flutter会将State对象重新插到树中，如包含此State对象的子树在树的一个位置移动到另一个位置时。如果移除后没有重新插入到树中则紧接着会调用`dispose()`方法。
- `dispose()`：当State对象从树中被永久移除时调用。通常在此回调中释放资源。

状态管理：

​	Widget管理自己的状态

​	父Widget管理子Widget的状态（子状态回调）

​	混合管理

​	全局状态管理

### 基础Widget

#### Text

```dart
/*
style,
strutStyle,
textAlign,
textDirection,
locale,
softWrap,
overflow,
textScaleFactor,
maxLines,
semanticsLabel,
*/
var tt = Text("Hello World!", textAlign: TextAlign.center,);

/*
color,
fontSize,
fontWeight,
fontStyle,
letterSpacing,
wordSpacing,
textBaseline,
height,
locale,
foreground,
background,
shadows,
decoration,
decorationColor,
decorationStyle,
debugLabel,
*/
var ts = TextStyle(
    			color: Colors.blue,
    			fontSize: 18.0,
    			height: 1.2,  
    			fontFamily: "Courier",
    			background: new Paint()..color=Colors.yellow,
    			decoration:TextDecoration.underline,
    			decorationStyle: TextDecorationStyle.dashed
  			);

// 富文本
Text.rich(TextSpan(
  	// 通过TextSpan对象的集合，形成富文本
    children: [
     TextSpan(
       text: "Home: "
     ),
     TextSpan(
       text: "https://flutterchina.club",
       style: TextStyle(
         color: Colors.blue
       ),  
       recognizer: _tapRecognizer
     ),
    ]
));
```

#### 按钮

```dart
// IconButton图标按钮
IconButton(
  icon: Icon(Icons.thumb_up),
  onPressed: () => {},
);
// FlatButton扁平按钮
FlatButton(
  child: Text("normal"),
  onPressed: () => {},
);
// OutlineButton边框按钮
OutlineButton(
  child: Text("normal"),
  onPressed: () => {},
);
// RaisedButton浮起按钮
RaisedButton(
  child: Text("normal"),
  onPressed: () => {},
);
// 自定义按钮
FlatButton(
  textColor: Colors.white,	// 按钮文本颜色
  color: Colors.blue,	// 按钮背景颜色
  highlightColor: Colors.blue[700],	// 按钮按下时的背景颜色
  disabledTextColor: Colors.blue[700], // 按钮禁用时的背景颜色
  colorBrightness: Brightness.dark,	// 按钮主题，默认是浅色主题 
  splashColor: Colors.grey,	// 点击时，水波动画中水波的颜色
  child: Text("Submit"),	// 按钮的内容
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), // 外形
  onPressed: () => {}, // 按钮点击回调
);
```

#### 图片

`Image`用来加载并显示图片，`Image`的数据源可以是asset、文件、内存以及网络。

`ImageProvider` 是一个抽象类，主要定义了图片数据获取的接口`load()`，从不同的数据源获取图片需要实现不同的`ImageProvider`。

```dart
// 从asset中加载图片
// 1.在pubspec.yml中的flutter部分添加如下内容：
//   assets:
//   - images/avatar.png
// 2.使用avatar.png
Image(
  image: AssetImage("images/avatar.png"),
);
Image.asset(
  "images/avatar.png",
);

// 从网络加载图片
Image(
  image: NetworkImage(
      "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"),
);
Image.network(
  "https://avatars2.githubusercontent.com/u/20411648?s=460&v=4",
);

// 其他参数
width, 					//图片的宽
height, 				//图片高度
color, 					//图片的混合色值
colorBlendMode, //混合模式
fit,						//缩放模式，Boxfit，fill（拉伸、填满），cover（居中、不拉伸、填满），contain（缺省值）（不拉伸、适应当前空间、不须填满）
alignment = Alignment.center, 	//对齐方式
repeat = ImageRepeat.noRepeat, 	//重复方式
```

#### 图标

```dart
// Flutter默认包含了一套Material Design的字体图标，在pubspec.yaml文件中的配置如下：
// flutter:
//  uses-material-design: true

// 使用图标：
Icons.thumb_up;
Icon(
  Icons.thumb_up,
);

// 其他参数
size,						// 大小
color,					// 颜色
textDirection,	// 朝向
```

#### 单选框、复选框

它们都是继承自StatelessWidget，所以它们本身不会保存当前选择状态，所以一般都是在父widget中管理选中状态。

```dart
class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  _SwitchAndCheckBoxTestRouteState createState() => new _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected=true; 	//维护单选开关状态
  bool _checkboxSelected=true;//维护复选框状态
  
  // Switch可以定义宽度，高度是固定的
  // Checkbox的宽高都是固定的
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelected,
          onChanged: (value) {
            setState(() {
              _switchSelected = value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          onChanged: (value) {
            setState(() {
              _checkboxSelected = value;
            });
          },
        ),
      ],
    );
  }
}
```

#### 输入框和表单

```dart
// 基本使用
class FocusTestRoute extends StatefulWidget {
  @override
  _FocusTestRouteState createState() => new _FocusTestRouteState();
}

class _FocusTestRouteState extends State<FocusTestRoute> {
  FocusNode focusNode1 = new FocusNode();   // 用户名文本框焦点记录
  FocusNode focusNode2 = new FocusNode();		// 密码文本框焦点记录

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TextField(
            autofocus: true,	// 自动获取焦点
            focusNode: focusNode1,	// 绑定焦点记录
            decoration: InputDecoration(labelText: "用户名"),  // 装饰
          ),
          TextField(
            focusNode: focusNode2,
            decoration: InputDecoration(labelText: "密码"),
            obscureText: true,	// 密文输入
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("移动焦点"),
                  onPressed: () {
                    // 判断用户名文本框焦点记录是否已经获取焦点
                    if (focusNode1.hasFocus) {
                      // 切换焦点
                      FocusScope.of(context).requestFocus(focusNode2);
                    } else {
                      FocusScope.of(context).requestFocus(focusNode1);
                    }
                  },
                ),
                RaisedButton(
                  child: Text("隐藏键盘"),
                  onPressed: () {
                    // 释放焦点
                    focusNode1.unfocus();
                    focusNode2.unfocus();
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
```

```dart
// 其他属性
const TextField({
  TextEditingController controller, 
  FocusNode focusNode,
  InputDecoration decoration = const InputDecoration(),
  TextInputType keyboardType,
  TextInputAction textInputAction,
  TextStyle style,
  TextAlign textAlign = TextAlign.start,
  bool autofocus = false,
  bool obscureText = false,
  int maxLines = 1,
  int maxLength,
  bool maxLengthEnforced = true,
  ValueChanged<String> onChanged,
  VoidCallback onEditingComplete,
  ValueChanged<String> onSubmitted,
  List<TextInputFormatter> inputFormatters,
  bool enabled,
  this.cursorWidth = 2.0,
  this.cursorRadius,
  this.cursorColor,
});
```

- controller：编辑框的控制器，通过它可以设置/获取编辑框的内容、选择编辑内容、监听编辑文本改变事件。大多数情况下我们都需要显式提供一个controller来与文本框交互。如果没有提供controller，则TextField内部会自动创建一个。
- focusNode：用于控制TextField是否占有当前键盘的输入焦点。它是我们和键盘交互的一个handle。
- InputDecoration：用于控制TextField的外观显示，如提示文本、背景颜色、边框等。
- keyboardType：用于设置该输入框默认的键盘输入类型，取值如下：
  - text，文本输入键盘；multiline，多行文本，需和maxLines配合使用(设为null或大于1) ；
  - number，数字，会弹出数字键盘；
  - phone，优化后的电话号码输入键盘，会弹出数字键盘并显示"* #"；
  - datetime，优化后的日期输入键盘；
  - emailAddress，优化后的电子邮件地址；
  - url，优化后的url输入键盘。
- textInputAction：键盘动作按钮图标（即回车键位图标）
- style：正在编辑的文本样式。
- textAlign: 输入框内编辑文本在水平方向的对齐方式。
- autofocus: 是否自动获取焦点。
- obscureText：是否隐藏正在编辑的文本，如用于输入密码的场景等，文本内容会用“•”替换。
- maxLines：输入框的最大行数，默认为1；如果为`null`，则无行数限制。
- maxLength和maxLengthEnforced ：maxLength代表输入框文本的最大长度，设置后输入框右下角会显示输入的文本计数。maxLengthEnforced决定当输入文本长度超过maxLength时是否阻止输入，为true时会阻止输入，为false时不会阻止输入但输入框会变红。
- onChange：输入框内容改变时的回调函数；注：内容改变事件也可以通过controller来监听。
- onEditingComplete和onSubmitted：这两个回调都是在输入框输入完成时触发。不同的是两个回调签名不同，onSubmitted回调是`ValueChanged<String>`类型，它接收当前输入内容做为参数，而onEditingComplete不接收参数。
- inputFormatters：用于指定输入格式；当用户输入内容改变时，会根据指定的格式来校验。
- enable：如果为`false`，则输入框会被禁用，禁用状态不接收输入和事件，同时显示禁用态样式（在其decoration中定义）。
- cursorWidth、cursorRadius和cursorColor：这三个属性是用于自定义输入框光标宽度、圆角和颜色的。

#### 表单

```dart
class FormTestRoute extends StatefulWidget {
  @override
  _FormTestRouteState createState() => _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey= new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,  // 设置globalKey，用于后面获取FormState
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                controller: _unameController,
                decoration: InputDecoration(
                    labelText: "用户名"
                ),
                validator: (v) {
                  return v.trim().length > 0 ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                controller: _pwdController,
                decoration: InputDecoration(
                    labelText: "密码"
                ),
                obscureText: true,
                validator: (v) {
                  return v.trim().length > 5 ? null : "密码不能少于6位";
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 28),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15),
                        child: Text("登录"),
                        onPressed: () {
                          // 获取State
                          if ((_formKey.currentState as FormState).validate()) {
                            print("Validate Pass!");
                          } else {
                            print("Validate Failed!");
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
```



### 布局类Widget

#### 分类

|            Widget             |         对应的Element          |                             用途                             |
| :---------------------------: | :----------------------------: | :----------------------------------------------------------: |
|    LeafRenderObjectWidget     |    LeafRenderObjectElement     | Widget树的叶子节点，用于没有子节点的widget，如Text、Image。  |
| SingleChildRenderObjectWidget | SingleChildRenderObjectElement |     包含一个子Widget，如：ConstrainedBox、DecoratedBox等     |
| MultiChildRenderObjectWidget  | MultiChildRenderObjectElement  | 包含多个子Widget，一般都有一个children参数，接受一个Widget数组。如Row、Column、Stack等 |

【注】Flutter中的很多Widget是直接继承自StatelessWidget或StatefulWidget，然后在`build()`方法中构建真正的RenderObjectWidget，如Text，它其实是继承自StatelessWidget，然后在`build()`方法中通过RichText来构建其子树，而RichText才是继承自LeafRenderObjectWidget。所以为了方便叙述，我们也可以直接说Text属于LeafRenderObjectWidget（其它widget也可以这么描述），这才是本质。读到这里我们也会发现，其实**StatelessWidget和StatefulWidget就是两个用于组合Widget的基类，它们本身并不关联最终的渲染对象（RenderObjectWidget）**。

#### 弹性布局（Flex、Expand）

Flex：可以沿着水平或垂直方向排列子widget。

Expand：可以按比例分割Flex widget所占用的空间。

```dart
class ExpandTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flex(
          direction: Axis.horizontal,	// 横向布局子视图
          children: <Widget>[
            Expanded(
              child: Container(
                height: 30,
                color: Colors.red,
              ),
              flex: 1,
            ),
            Expanded(
              child: Container(
                height: 30,
                color: Colors.blue,
              ),
              flex: 2,
            ),
          ],
        ),
        // 1.Container，盒子Widget，可设置Padding、Margin、背景色
        Container(
          height: 10,
        ),
        // 2.SizedBox，可设置宽高的Widget，不设置则不限制
        SizedBox(
          height: 200,
          child: Flex(
            direction: Axis.vertical,	// 纵向布局子视图
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 30,
                  color: Colors.red,
                ),
                flex: 1,
              ),
              // 3.弹性占位符，本质就是个Expanded实例
              Spacer(
                flex: 1,
              ),
              Expanded(
                child: Container(
                  height: 30,
                  color: Colors.blue,
                ),
                flex: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
```

#### 线性布局（Row、Column）

Row：横向的Flex

Column：纵向的Flex

#### 流式布局（Wrap、Flow）

超出屏幕显示范围会自动折行的布局称为流式布局。

Wrap

```dart
class WrapTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Wrap，children布局超出范围自动折行
    return Wrap(
      spacing: 8.0, // 主轴(水平)方向间距
      runSpacing: 4.0, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.center, //沿主轴方向居中
      children: <Widget>[
        // Chip
        new Chip(
          // CircleAvatar
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('A')),
          label: Text('Hamilton'),
        ),
        new Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
          label: Text('Lafayette'),
        ),
        new Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('H')),
          label: Text('Mulligan'),
        ),
        new Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('J')),
          label: Text('Laurens'),
        ),
      ],
    );
  }
}
```

Flow

需要自己实现子widget的位置、大小。

缺点：复杂；不能自适应子widget大小，必须通过指定父容器大小或实现TestFlowDelegate的getSize返回固定大小。

优点：性能好；灵活。

####层叠布局（Stack、Positioned）

使用Stack和Positioned可以实现绝对定位，Stack允许子widget堆叠，而Positioned可以给子widget定位。



### 容器类Widget



### 可滚动Widget



### 功能型Widget

