##前置说明

1. 阅读本文须要读者掌握至少一两种其他编程语言，Dart与其他常用编程语言相似度很高的语法，在本文中都不会详细说明
2. 本文参考链接
   1. [Dart官方文档](https://www.dartlang.org/guides/language)
   2. [Dart中文网站](<http://dart.goodev.org/guides/get-started>)
3. 在Dart中一切皆对象，包括基本数据类型，变量缺省值均为null

##一、基础语法

###1.变量声明

```dart
// dynamic Object
dynamic lufei = "路飞";
Object suolong = "索隆";
String namei = "娜美";
/*
lufei = 3;        // 可以
suolong = true;   // 可以
namei = 4;        // 不可以
*/

// final
final wusuopu = "乌索普";
// final wusuopu;       // 不可以，声明必须初始化
// wusuopu = "长鼻子";   // 不可以，赋值后不可以修改

// const
// const修饰的变量是编译期常量，声明必须初始化，赋值后不可修改，是隐士的final变量
// 如果声明一个const变量，它的作用域仅在类层次中使用，可以声明为static cosnt
const buluke = "布鲁克";
```

###2.内置类型

内置类型包括numbers、strings、booleans、lists、sets、maps、runes、symbols

```dart
// 内置类型可以用字面量初始化，也可以用类构造方法返回值初始化，如：
String qiaoba = "乔巴";
List names1  = List();  // String类没有默认的构造方法，不能通过String()创建String类型的实例

// numbers: int double num
int age1 = 10;
double height1 = 170;
num weight = 66;
String age1Str = age1.toString();
String tenStr = 10.toString();
double height2 = double.parse("180");

// stings
var hello1 = "My name is $lufei. I'm ${10+6} years old.";
var hello2 = hello1 + "我是要成为海贼王的男人。";
print(hello2);

// booleans、lists、sets、maps
// 与其他语言类似，略

// runes是字符串的utf-32代码的集合
Runes runes = new Runes('\u2665 \u{1f605} \u{1f60e} \u{1f47b} \u{1f596} \u{1f44d}');
print(new String.fromCharCodes(runes));

// symbols
// 前期应该用不到，略
```

### 3.操作符

```dart
// /
var result1 = 5 / 2; // 结果为2.5
var result2 = 5 / 2; // 结果为2

class Person extends Object {
  String firstName;
  String lastName;
}
// is is! as
dynamic person1 = Person();
if (person1 is Person) {
  person1.firstName = "Liu";
}
(person1 as Person).lastName = "Dehua";
print(person1.firstName + ' ' + person1.lastName);

// ??=
int num1 = 10;
int num2;
num1 ??= 100;
num2 ??= 100;
print("num1 == $num1, num2 == $num2");  // num1 == 10, num2 == 100

// .. 
// 叠式调用，对同一对象进行一系列的操作
person1
  ..firstName = "Zhou"
  ..lastName = "Xingchi";
print(person1.firstName + ' ' + person1.lastName);

// ?. 
// 如果person1不是null，设置它的属性
person1?.firstName = "Zhang";
person1?.lastName = "Zhenyue";
print(person1.firstName + ' ' + person1.lastName);
```

### 6.流程控制语句

####6.1 基本流程控制语句

if-else、for、while、do-while、break、continue、switch-case、assert，略

####6.2 异常

try、catch、finally、throw，略

### 5.函数

#### 5.1 函数的声明与实现

```dart
// 无参无返回函数，可以省略void返回值类型
add0(int a, int b) {}
// 一般写法
int add1(int a, int b) {
  return a + b;
}
// 单行返回函数的简写
int add2(int a, int b) => a + b;
// 调用时需要带参数名的函数(增强函数参数可读性)
int add3({int a, int b}) => a + b;  // 声明与实现
add3(a: 8, b: 10);  								// 调用
```

#### 5.2 参数设置默认值、可选参数

```dart
// 用给形参赋值的形式，可设置参数默认值，默认值必须为编译期常量
// 可选参数，用[]将形参括起来即可声明为可选参数
String sayHello(String name, int age, [String sex, double height = 170.0]) {
  var result = "Hello, my name is $name. I am $age years old.";
  if (sex != null)
    result += "I am a $sex.";
  if (height != null)
    result += "I am ${height}cm high.";

  return result;
}
print(sayHello("Jack", 24, 'boy'));
```

#### 5.3 在Dart中函数是一类对象，可作为参数进行传递、可以被声明为变量、匿名函数、测试函数相等

```dart
// 函数传参(注：如果不关注形参类型，形参类型可以缺省)
printFoo(content) {
  print(content);
}
var list = [1, 2, 3];
list.forEach(printFoo);

// 函数赋值给变量(注：由于赋值是一个表达式，所以赋值语句之后要跟‘;’)
var printFooCopy = printFoo;
var printFooRe = (x) { print(x); };
// 匿名函数
list.forEach((x) { print(x); });
// 如果为单行函数，也可以这样写
list.forEach((x) => print(x));

// 判断函数相等
print(printFoo == printFooCopy);  // true
print(printFoo == printFooRe);	  // false
```

#### 5.4闭包

```dart
// 捕获实参，返回一个函数对象
Function makeAdder(num addBy) {
  return (num i) => addBy + i;
}

// 实参2被捕获
var adder2 = makeAdder(2);
// 实参4被捕获
var adder4 = makeAdder(4);

// 捕获之后任意时刻都可以通过调用函数访问到被捕获的值
print(adder2(3) == 5);
print(adder4(3) == 7);
```

#### 5.5 注

【注1】所有的函数都返回一个值。如果没有指定返回值，则 默认把语句 return null; 作为函数的最后一个语句执行。

### 6.类

每个对象都是一个类的实例，所有的类都继承于Object。

#### 6.1 构造器

【默认构造器】如果你没有定义构造函数，则会有个默认构造函数。 默认构造函数没有参数，并且会调用超类的 没有参数的构造函数。

【构造器不能被继承】子类不会继承超类的构造函数。 子类如果没有定义构造函数，则只有一个默认构造函数 （没有名字没有参数）。

【命名构造器】

```dart
class Point {
  num x;
  num y;

  // 默认构造函数
  //Point();

  // 带参构造函数
  /*
  Point(num x, num y) {
    this.x = x;
    this.y = y;
  }
  */
  // 只要不带名字的构造器，都是同一个构造器
  Point(this.x, this.y);

  // 带名字的构造器
  Point.fromMap(Map m) {
    x = m['x'];
    y = m['y'];
  }
  // 同上，初始化列表，’=‘右侧不能访问this
  Point.fromMap1(Map m) : x = m['x'], y = m['y'];
  // 同上
  Point.fromMap2(Map m)
      : x = m['x'], y = m['y']
  {
    print('x=$x, y = $y');
  }
}
```

调用父类构造器

```dart
// 继承自Point
class Point3D extends Point {
  num z;
  // 调用父类构造器(函数先执行父类构造器，再调用子类构造器)
  // △默认情况下，子类的构造函数会自动调用超类的 无名无参数的默认构造函数。
  // △如果超类没有无名无参数构造函数， 则你需要手工的调用超类的其他构造函数。 在构造函数参数后使用冒号 (:) 可以调用 超类构造函数。
  Point3D(num x, num y, this.z) : super(x, y);
}

// 使用
var point1 = Point3D(3, 4, 5);
print("x = ${point1.x}, y = ${point1.y}, z = ${point1.z}");
```

重定向构造器

```dart
class Rect {
  num width;
  num height;

  Rect(this.width, this.height);
  // 调用当前类其他构造器
  Rect.square(num width) : this(width, width);
}
```

常量构造器

如果你的类提供一个状态不变的对象，你可以把这些对象 定义为编译时常量。要实现这个功能，需要定义一个 `const` 构造函数， 并且声明所有类的变量为 `final`。

```dart
class ImmutableRect {
  final num width;
  final num height;
  const ImmutableRect(this.width, this.height);
  // 使用常量构造器，创建一个静态成员origin
  static final ImmutableRect origin = const ImmutableRect(0, 0);
}
```

工厂构造器

工厂构造器无法访问 `this`。

```dart
class Logger {
  final String name;
  // logger实例cache
  static final Map<String, Logger> _cache =
      <String, Logger>{};

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      final logger = new Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }
  
  Logger._internal(this.name);
}
```

【注】判断一个对象的类型，返回值为Type类的对象

```dart
print('The type of a is ${obj.runtimeType}');
```

####6.2 方法

实例方法，略。

Getters and Setters

```dart
class Rect {
  num left;
  num top;
  num width;
  num height;

  // Getters and Setters
  // final属性会自动生成Getter，普通属性会自动生成Getter和Setter函数
  // 这里通过实现Getter和Setter方法，提供了两个计算属性
  num get right => left + width;
  set right(num value) => left = value - width;
  num get bottom => top + height;
  set bottom(num value) => top = value - height;

  Rect(this.left, this.top, this.width, this.height);
}
```

静态变量、静态方法，略

虚方法、虚类

```dart
// 定义抽象类、抽象方法
abstract class AbstractContainer {
  void updateChildren();
}

// 继承自抽象类，实现抽象方法
class SpecializedContainer extends AbstractContainer {
  void updateChildren() {

  }
  // 该类中也有一个抽象方法，会导致一个警告，但是不影响该类的实例化
  void doSomething();
}
```

隐式接口（避免继承）

```dart
class Person {
  final _name;
  Person(this._name);
  String greet(who) => 'Hello, $who. I am $_name.';
}

// Person隐士接口的实现
class Imposter implements Person {
  // 虽然可能用不到这个属性，但是必须定义它
  final _name = "";

  String greet(who) => 'Hi $who. Do you know who I am?';
}

greetBob(Person person) => person.greet('bob');

main() {
  print(greetBob(new Person('kathy')));
  print(greetBob(new Imposter()));
}
```

mixin

#### 6.3 继承

继承

重写，略

noSuchMethod()

```dart
// 如果调用了对象上不存在的函数，则就会触发noSuchMethod()函数。
class A {
  @override
  void noSuchMethod(Invocation mirror) {
    // ...
  }
}
```

重载

重载操作符

```dart
class Vector {
  final int x;
  final int y;
  const Vector(this.x, this.y);

  // 重载 +
  Vector operator +(Vector v) {
    return new Vector(x + v.x, y + v.y);
  }

  // 重载 -
  Vector operator -(Vector v) {
    return new Vector(x - v.x, y - v.y);
  }
}

main() {
  final v = new Vector(2, 3);
  final w = new Vector(2, 2);

  // v + w == (4, 5)
  var v1 = v + w;
  // v - w == (0, 1)
	var v2 = v - w;
}
```

mixins

#### 6.4 其他

可以调用的类（callable classes）

```dart
class Person {
  var firstName;
  var lastName;

  call(String caller) {
    print('嘿，你好$caller，我是$firstName $lastName.');
  }
}

var person = Person();
person.firstName = "刘";
person.lastName = "诗诗";
// 实现call方法后，实例变量可以这样”调用“，其实只是走的call方法而已
person("吴奇隆");
```

### 7. 泛型

泛型集合

集合枚举器

指定构造器参数类型

约定参数化类型

泛型函数

### 8.使用类库

导入一个类库

明确类前缀

部分导入库

懒加载库

### 9.异步支持



###10.元数据

使用元数据给你的代码添加其他额外信息。 元数据注解是以 `@` 字符开头，后面是一个编译时 常量(例如 `deprecated`)或者 调用一个常量构造函数。

常用的有`@deprecated`、` @override` 和 `@proxy`。



