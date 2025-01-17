[Educational Codeforces Round 168 (Rated for Div. 2)](https://codeforces.com/contest/1997)
[Maximize the Root](https://codeforces.com/contest/1997/problem/D)

#树 
#DFS 
题意：给一颗树，每个节点都有一个值。
可以对节点进行操作：自身+1，子树所有节点-1（要求必须>0）
求根节点的最大值

由于对子树所有节点都进行-1操作，根节点能增加的值由其中最小值决定。
转化为操作后求子树将最小值最大化。考虑贪心
发现对于任意一颗树，如果它的根节点值大于其子树的最小值，这颗子树的最小值继承其子树的最小值
如果根节点的值小于其子树的最小值，考虑平均它们的值
从根进行DFS，则一定是自底向顶进行操作，这样可以使根节点的值最大化。

```cpp
#include<bits/stdc++.h>
using ll = long long;
using namespace std;
#define dbg(x) cout<<#x<<" = "<<x<<endl
#define int long long 
int head[200001];
int to[200001];
int nx[200001];
int v[200001];
int cnt = 1;
void add(int x, int y) {
    to[cnt] = y;
    nx[cnt] = head[x];
    head[x] = cnt++;
}
int mi[2000001];
int dfs(int p) {
    if (mi[p] > 0) {
        return mi[p];
    }
    ll tmp = 1e18;
    for (int i = head[p]; i; i = nx[i]) {
        tmp = min(tmp, dfs(to[i]));
    }
    if(tmp == 1e18) { //叶子节点
        mi[p] = v[p];
    } else {
        if(tmp > v[p]) {
            int dis = tmp - v[p];
            mi[p] =v[p] + dis/2;
        } else {
            mi[p] = tmp;
        }
    }
    return mi[p];
}
void solve() {
    int n;
    cin >> n;
    cnt = 1;
    for (int i = 1; i <= n; i++) {
        head[i] = 0;
        mi[i] = 0;
    }
    for (int i = 1; i <= n; i++) cin >> v[i];
    for (int i = 2; i <= n; i++) {
        int y;
        cin >> y;
        add(y, i);
    }
    dfs(1);
    ll mini = 1e18;
    for(int i = head[1]; i; i= nx[i]) {
        mini = min(mini,mi[to[i]]);
    }
    cout<<mini + v[1]<<endl;
}
signed main() {
    int T;
    cin >> T;
    while (T--) {
        solve();
    }
}
```