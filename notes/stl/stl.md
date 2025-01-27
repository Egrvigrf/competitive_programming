# Vector 

初始化一个空的 vector
`vector<int> vec;`

初始化一个包含 5 个元素，每个元素的值都为 0 的 vector
`vector<int> vec1(5);`

初始化一个包含 5 个元素，每个元素的值都为 0 的 vector，C++11 之后可以用以下方式
`vector<int> vec2(5, 0);`

通过初始化列表初始化 vector
`vector<int> vec3 = {1, 2, 3, 4, 5};`

复制另一个 vector
`vector<int> vec4(vec3);`

通过赋值运算符赋值
`vector<int> vec5;`
`vec5 = vec4;`

通过下标访问元素
`int x = vec3[0];`

使用 at() 函数访问元素，会进行越界检查
`int y = vec3.at(1);`

获取第一个和最后一个元素
`int first = vec3.front();`
`int last = vec3.back();`

在末尾插入一个元素
`vec.push_back(10);`

在指定位置插入一个元素
`vec.insert(vec.begin() + 2, 20);`

删除末尾的元素
`vec.pop_back();`

删除指定位置的元素
`vec.erase(vec.begin() + 1);`

清空 vector
`vec.clear();`

使用范围-based for 循环遍历
```cpp
for (int x : vec) {
    cout<<x<<endl;
}
```

使用迭代器遍历
```cpp
for (auto it = vec.begin(); it != vec.end(); ++it) {
    cout<<*it<<" ";
}
```
下标遍历
```cpp
for (size_t i = 0; i < vec.size(); i++) {
    cout<<vec[i]<<" ">>;
}
```

获取 vector 的大小
`int n = vec.size();`

检查 vector 是否为空
`bool empty = vec.empty();`

重设 vector 的大小
`vec.resize(10);`

翻转 vector
`reverse(vec.begin(), vec.end());`

对 vector 进行排序
`sort(vec.begin(), vec.end());`

对 vector 进行去重
`sort(vec.begin(), vec.end());`
`vec.erase(unique(vec.begin(), vec.end()), vec.end());`
//或者
`sort(vec.begin(), vec.end());`
`vec.resize(unique(vec.begin(), vec.end()) - vec.begin());`

对于 unique 函数来说，要求元素必须是相邻的才能进行去重操作，而且它只会去除相邻的重复元素。  
因此，在使用 unique 去重之前，通常需要先对容器进行排序，以确保相同的元素都相邻排列，才能正确去重

## 二维vetor
建立空的二维vector数组
`vector<vector<int>> vec;`

建立有五行，列数未知的的二维vector数组
`vector<vector<int>> vec(5);`


# string

`string s = "";`

## 获取长度
`int n = s.length();` 
## 取子串
从loc位置开始(包括a)取长度为n
`string s1 = s.substr(loc,n);` 
省略长度，从loc位置开始取到末尾
`string s1 = s.substr(loc);`   
## 串内排序
把字符串内的字符按字典序排序 "deacb" --> "abcde"
`sort(s.begin(),s.end());`    
## 查找子串，字符
返回s中出现的第一个s1的第一个字符的位置
`int loc = s.find(s1);`
从右往左第一个匹配的
`int loc = s.rfind(s1);`
从startpos开始往后找
`int loc = s.find(s1,startpos);`
从startpos开始往前找
`int loc = s.rfind(s1,startpos);`
判断是否找到
`if(s.find(s2) == string::npos) cout<<"Not found";`
## 字符串之间比较大小
\>,<,=已经被重载，可以直接用于字符串之间大小比较。
方法： 从第一位开始按位按照字典序比较，不同的位字典序大的更大，若一个串是另一个串的字串，则字串更小。

##  与整数相互转换
s(tring) to i(nt)
`int a = stoi("1234");`
int to string
`string s = to_string(1234);`

## 流提取
```cpp
#include <iostream>
#include <sstream>
#include <string>

int main() {
    std::string input = "First line\nSecond line\nThird line";
    std::stringstream ss(input);
    std::string line;

    while (std::getline(ss, line)) {
        std::cout << line << std::endl;
    }

    return 0;
}
```
分隔一行中空格
```cpp
while(getline(cin,line)) {
    stringstream ss(line);
    size_t wi = 0;
    while(ss >> word) {
        len[wi] = max(len[wi],word.size());
        wi++;
        words[cnt].push_back(word);
    }
    cnt++;
}
```
按符号分隔
```cpp
cin >> line;
stringstream ss(line);
string s;
int cnt = 1;
while (getline(ss, s, '.')) {
    a[i][cnt] = s;
    b[i][cnt] = trans(s);
    cnt++;
}
```
# lowerbound
对vector进行二分查找
时间复杂度O($n\log_2 n$)
用于查找在已排序范围内，大于等于指定值的第一个元素的位置。如果找到了符合条件的元素，则返回一个指向该元素的迭代器；如果没有找到符合条件的元素，则返回一个指向大于指定值的第一个元素的位置的迭代器。
降序序列a，loc是第一个大于等于key的迭代器。如果key比所有元素都要大，返回a.end()
int loc = lower_bound(a.begin(), a.end(), key) - a.begin();
upper_bound : 大于

# sort
内部采用快速排序
时间复杂度O($n\log_2 n$)
最坏情况O($n^2$)

```cpp
int a[n];
sort(a,a+n);//默认升序
sort(a,a+n,[](int a,int b){ return a>b;} );//降序排列
vector a(n);
sort(a.begin(),a.end());//默认升序
sort(a.begin(),a.end(),[](int a,int b){return a>b;})//降序
```

# pair
含有两个“元素”first,second
first 和 second 成员的数据类型可以是任意类型。因为 pair 是一个模板类，它的模板参数可以接受任何类型。
```cpp
pair<int,string> p[n];
int x = p[1].first;
string y = p[1].second;
pair<int,string> p2(6,"Egrvigrf");
pair<int,string> p3;
p3 = {6,"Egrvigrf"};
```

# map
- 内部用红黑树实现，具有按键从小到大自动排序的功能。
- 优点：内部元素有序，查询时间复杂度为 O(log n)。
- 缺点：占用空间较大。

## 遍历map
使用迭代器遍历
```cpp
for (auto it = mp.begin(); it != mp.end(); ++it) {
    cout << "Key: " << it->first << ", Value: " << it->second << endl;
}
```
使用结构化绑定遍历(c++ 17) 
```cpp
for (const auto& [key, value] : mp) {
    cout << "Key: " << key << ", Value: " << value << endl;
}
```

## 查询键是否存在
如果键不存在，则返回迭代器的结尾
```c++
if(mp.find(key) == mp.end()) {
    cout<<"Not found";
} else {
    cout<<"found";
}
```

# unordered_map
cf会用unordered_map会被hack
- 内部用哈希表实现，查找速度非常快。
- 缺点：建立哈希表比较耗时。
- 用 [] 查找元素时，如果不存在会创建空的键值对，降低后续创建查询删除效率。
- 最优方法：先判断存在与否，再索引对应值。

总的来说，`[]`运算符和`insert`函数都可以用于向`map`中插入元素，但它们有一些性能方面的区别：

- `[]`运算符插入元素时会先进行查找操作，如果元素不存在则会插入一个默认值的新元素，然后返回该元素的引用。这个过程可能会引起底层容器的重排。
- `insert`函数直接插入一个新的元素，不会先进行查找操作。如果插入的键已经存在，则不会插入新元素。

在插入大量元素时，使用`[]`运算符可能会比使用`insert`函数稍慢，因为它可能会引起额外的查找和重排操作。但对于单个元素的插入操作，两者的性能差异可能不太明显。因此，在选择使用哪种方法时，可以根据具体的需求和性能要求进行考虑。


# set
- 元素不重复，插入已存在元素不会插入，保证元素唯一性。
- 元素按照升序（从小到大）排列。
- 内部实现通常基于红黑树，因此插入、删除和查找操作的平均时间复杂度为 O(log n)。

# multiset
- 允许元素重复，可以存储相同的元素。
- 元素按照升序（从小到大）排列。
- 内部实现通常基于红黑树，因此插入、删除和查找操作的平均时间复杂度为 O(log n)。

# unordered_set
- 元素不重复，插入已存在元素时不会插入，保证元素唯一性。
- 元素无序存储，内部实现通常基于哈希表。
- 插入、删除和查找操作的平均时间复杂度为 O(1)，但可能会受到哈希冲突的影响。

# unordered_multiset
- 允许元素重复，可以存储相同的元素。
- 元素无序存储，内部实现通常基于哈希表。
- 插入、删除和查找操作的平均时间复杂度为 O(1)，但可能会受到哈希冲突的影响。

总的来说，set 和 multiset 是有序容器，unordered_set 和 unordered_multiset 是无序容器。有序容器在插入、删除和查找操作上通常比无序容器慢，但可以保持元素的顺序。相反，无序容器在插入、删除和查找操作上通常更快，但元素的顺序是不确定的。选择适当的容器取决于具体的需求和性能要求。

# queue

## 优先队列
用`top()`而不是`front()`取队头

默认从大到小
`priority_queue<int> pq;`  
从小到大
`priority_queue<int, vector<int>, greator<int> > pq2;`
自定义
`priority_queue<int, vector<int>, cmp> pq;`

## 双端队列
`deque<int> dq;`

入队
`dq.push_front(x)`
`dq.push_back(x)`
读取队首，尾
`x = dq.front();`
`x = dq.back();`

出队
`pop_front();`
`pop_back();`

# stack

`·stack<int> s;`

入栈
`s.push();`

出栈
`s.pop();`

取栈顶
`s.top();`

# 输入，输出

## 1. 缓冲区概述

在C++中，标准输入缓冲区是一个存储输入字符的区域。当你在控制台中输入数据并按下回车键后，所有的输入字符（包括空格、制表符和换行符）都会被存储到缓冲区中。程序可以通过输入流对象 `cin` 从缓冲区读取数据。



## `cin` 的工作原理

`cin` 是标准输入流，用于从缓冲区读取数据。`cin` 使用操作符 `>>` 读取数据时，会自动跳过前导空白字符（包括空格、制表符和换行符）。

1. **忽略前导空白字符**：在读取数据时，`cin` 会跳过所有前导的空格、制表符和换行符。
2. **读取数据直到下一个空白字符**：`cin` 从第一个非空白字符开始读取，直到遇到下一个空白字符为止。读取的数据会被保存到指定的变量中。
3. **更新指针位置**：`cin` 指针会移动到读取的最后一个字符之后，准备进行下一次读取。


## `getline` 的工作原理

`getline` 用于从缓冲区读取一整行数据，直到遇到换行符 `\n` 为止。`getline` 读取后会丢弃换行符，但不会跳过前导空白字符。

getline(cin,s);
1. **从当前指针位置开始读取**：`getline` 从缓冲区当前指针位置开始读取字符。
2. **读取直到遇到换行符**：`getline` 读取字符直到遇到换行符 `\n`，并将读取的内容保存到字符串变量中。
3. **丢弃换行符**：`getline` 会丢弃遇到的换行符 `\n`，指针移动到换行符之后的位置。

std::getline(std::istream& is, std::string& str, char delim)
读取到指定字符为止，不会存入该字符。

## `getchar` 的工作原理

`getchar` 是一个标准输入函数，用于从标准输入缓冲区读取一个字符，返回其 ASCII 码值，并将输入指针后移一位。

1. **读取当前位置的字符**：从标准输入缓冲区中读取当前指针位置的字符。
2. **返回 ASCII 码**：返回读取字符的 ASCII 码值。
3. **指针后移**：将输入指针移动到下一个字符的位置。

## `cin.ignore()` 介绍

`cin.ignore()` 是 C++ 标准库中的一个函数，用于忽略输入流中的字符。它有两个重载形式：

1. **无参数形式**：忽略一个字符(指针移动一位)。
2. **带参数形式**：忽略指定数量的字符，或者直到遇到指定的终止字符。

```cpp
std::istream& ignore(std::streamsize n = 1, int delim = EOF);
```

## 其他c++输入函数
cin.getline(s,100);//读取一定数量的字符，功能和getline()相近
读取到指定字符数或/n
cin.getline(s,100,c);
读取到指定字符数或字符c
cin.get(c)
单个字符c,不能重载为字符串
cin.get(s,100);
读取字符串，长度为100或\n停止
cin.get(s,100，c);
cin.read()
读取字符放到缓冲区

cin.get() 和 getline的区别在是否保留\n

## 精度输出
setpricision(n)前加fixed保留小数位数
不加fixed有效位数
```cpp
cout<<fixed<<setprecision(4)<<3.1415926;
const double eps = 1 - 1e5;
```
对齐
```cpp
#include <iostream>
#include <iomanip>
using namespace std;

int main() {
    int a = 123;
    double b = 45.678;
    string c = "example";

    // 输出左对齐，右对齐
    cout << setw(10) << left << "Number" << setw(10) << right << a << endl;
    cout << setw(10) << left << "Value" << setw(10) << right << b << endl;
    cout << setw(10) << left << "Text" << setw(10) << right << c << endl;

    return 0;
}
```
# Debug
assert(表达式);
表达式不满足时终止程序

