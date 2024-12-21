[[差分前缀和]]
[Lycanthropy](https://www.luogu.com.cn/problem/P5026)
为了防止边界处理的讨论，直接在数组的左边和右边扩大了offset,避免出错
```cpp
```c++
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
using ld = long double;
using ull = unsigned long long;
#define IOS ios::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr)
#define endl '\n'
const int N = 1000001;
const int offset = 300001;
int n, m;
ll ans[offset + N + offset];

void op(int l, int r, int s, int e,int d) {
    ans[l + offset] += s;
    ans[l + 1 + offset] += d - s;
    ans[r + 1 + offset] += -e - d;
    ans[r + 2 + offset] += e;
}

void fall(int v, int x) {
    op(x - 3 * v + 1, x - 2 * v-1, 1, v - 1,1);
    op(x - 2 * v, x - 1, v, -v + 1,-1);
    op(x, x + 2 * v, -v, v,1);
    op(x + 2 * v+1, x + 3 * v - 1, v - 1, 1,-1);
}

void build() {
    for (int i = 2; i <= m+ offset; i++) {
        ans[i] += ans[i - 1];
    }
    for (int i = 2; i <= m + offset; i++) {
        ans[i] += ans[i - 1];
    }
}

int main() {
    IOS;
    int v, x;
    cin >> n >> m;
    //memset(ans,0,sizeof(ans));
    for (int i = 1; i <= n; i++) {
        cin >> v >> x;
        fall(v, x);
    }
    build();
    int start = offset + 1;
    for(int i = 1; i <= m; i++) {
        cout<<ans[start]<<" ";
        start++;
    }
    return 0;
}

/**
 * author:  Egrvigrf
 * created: 2024-07-27 20:01
**/
```
```