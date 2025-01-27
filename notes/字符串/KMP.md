字符串匹配算法
求字符串$s1$中匹配的$s2$字符串
如果暴力匹配最糟糕时间复杂度$O(n*m)$
,用KMP可以降低到$O(n+m)$

构建一个nx数组存放每一位的前一位的除本身外的字串的最长前缀后缀匹配数量

```cpp
vector<int> nx(m + 1, 0);
int j = 0;
for(int i = 2,i <= m; i++) {
    while (j > 0 && s2[i - 1] != s2[j]) {
        j = nx[j];
    }
    if (s2[i - 1] == s2[j]) {
        j++;
    }
    nx[i] = j;
}
int x = 0, y = 0;
while (x < n) {
    if (s1[x] == s2[y]) {
        x++, y++;
    } else if (y > 0) {
        y = nx[y];
    } else {
        x++;
    }
    if (y == m) {
        //cout << x - y + 1 << endl;
        //y = nx[y];
    }
}
```