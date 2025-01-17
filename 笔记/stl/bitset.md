

# C++ 中的 bitset 和 bool 数组

## 1. 引入头文件

```cpp  
// 引入 bitset 头文件  
#include <bitset>  
```  
  

## 2. 创建 bitset

```cpp  
// 创建一个大小为 8 的 bitset，默认初始化为 00000000  
std::bitset<8> bs;  
  
// 通过整数进行初始化，42 的二进制表示为 00101010  
std::bitset<8> bs1(42);  
  
// 通过字符串进行初始化，右对齐，结果为 00001101  
std::bitset<8> bs2("1101");  
  
// 通过字符串进行初始化，从第 2 位开始，结果为 00000011  
std::bitset<8> bs3("1101", 2);  
```

## 3. 基本操作

### 设置位

```cpp  
bs.set();       // 全部设置为 1  
bs.set(3);      // 将第 3 位设置为 1  
bs.set(3, 0);   // 将第 3 位设置为 0  
```

### 清除位

```cpp  
bs.reset();     // 全部清除为 0  
bs.reset(3);    // 将第 3 位清除为 0  
```

### 翻转位

```cpp  
bs.flip();      // 全部位翻转bs.flip(3);     // 翻转第 3 位  
```  
  

### 访问位

```cpp  
bool b = bs.test(3);  // 检查第 3 位是否为 1  
bool b = bs[3];       // 也可以使用下标访问  
```  
  

### 获取二进制表示的字符串

```cpp  
std::string str = bs.to_string();  // 转换为字符串  
```  
  

### 其他操作

```cpp  
size_t count = bs.count();     // 返回 1 的数量size_t size = bs.size();       // 返回位的总数bool any = bs.any();           // 是否有任何一位为 1  
bool none = bs.none();         // 是否全为 0  
```

## 4. 示例代码

  
以下是一个完整的示例程序：  
  
```cpp  
#include <iostream>  
#include <bitset>  
  
int main() {  
    std::bitset<8> bs1(42);     // 00101010  
    std::bitset<8> bs2("1101"); // 00001101  
  
    std::cout << "bs1: " << bs1 << std::endl;  
    std::cout << "bs2: " << bs2 << std::endl;  
  
    bs1.set(3);  
    std::cout << "bs1 after set(3): " << bs1 << std::endl; // 00111010  
  
    bs2.flip();  
    std::cout << "bs2 after flip(): " << bs2 << std::endl; // 11110010  
  
    bs2.reset(1);  
    std::cout << "bs2 after reset(1): " << bs2 << std::endl; // 11110000  
  
    std::cout << "bs1 has " << bs1.count() << " bits set to 1" << std::endl;  
    std::cout << "bs2 has " << bs2.count() << " bits set to 1" << std::endl;  
  
    return 0;  
}  
```  
  

### 运行结果

  
```  
bs1: 00101010  
bs2: 00001101  
bs1 after set(3): 00111010  
bs2 after flip(): 11110010  
bs2 after reset(1): 11110000  
bs1 has 4 bits set to 1  
bs2 has 4 bits set to 1  
```  
  

## 5. `bitset` 和 `bool` 数组比较

### 内存使用

- `bitset` 更加高效：每个位只占用1 bit。- `bool` 数组较为低效：每个布尔值占用1字节（8 bits）。  
  

### 操作便捷性

- `bitset` 提供丰富的位操作方法，如 `set`、`reset`、`flip` 等。- `bool` 数组需要手动实现这些操作。  
  

### 使用场景

#### 使用 `bool` 数组的场景

- 当需要对单个位进行频繁且独立的读写操作时。- 当数组大小较小，内存开销不是主要考虑因素时。  
  

#### 使用 `bitset` 的场景

- 当需要处理大量的位数据，并且需要节省内存时。- 当需要进行位操作（如与、或、异或、非等）时，`bitset` 提供了方便的方法。- 当需要将位数据转换为字符串或整数时，`bitset` 提供了直接支持。  
  

## 6. 示例代码比较

### `bool` 数组代码

```cpp  
#include <iostream>  
  
int main() {  
    bool boolArray[8] = {true, false, true, true, false, false, true, false};  
  
    // 输出 bool 数组    for (int i = 0; i < 8; ++i) {  
        std::cout << boolArray[i] << " ";  
    }  
    std::cout << std::endl;  
  
    // 修改 bool 数组    boolArray[1] = true;  
    boolArray[4] = true;  
  
    // 再次输出 bool 数组    for (int i = 0; i < 8; ++i) {  
        std::cout << boolArray[i] << " ";  
    }  
    std::cout << std::endl;  
  
    return 0;  
}  
```

### `bitset` 代码

```cpp  
#include <iostream>  
#include <bitset>  
  
int main() {  
    std::bitset<8> bitsetExample("10110010");  
  
    // 输出 bitset  
    std::cout << "bitset: " << bitsetExample << std::endl;  
  
    // 修改 bitset  
    bitsetExample.set(1);  
    bitsetExample.set(4);  
  
    // 再次输出 bitset  
    std::cout << "bitset after modification: " << bitsetExample << std::endl;  
  
    return 0;  
}  
```

手写位图
[手写位图](https://leetcode.cn/problems/design-bitset/description/)