[CF](https://codeforces.com/contest/1975/problem/D)
378QAQ has a tree with $n$ vertices. Initially, all vertices are white.

There are two chess pieces called $P_A$ and $P_B$ on the tree. $P_A$ and $P_B$ are initially located on vertices $a$ and $b$ respectively. In one step, 378QAQ will do the following in order:

1.  Move $P_A$ to a neighboring vertex. If the target vertex is white, this vertex will be painted red.
2.  Move $P_B$ to a neighboring vertex. If the target vertex is colored in red, this vertex will be painted blue.

Initially, the vertex $a$ is painted red. If $a=b$, the vertex $a$ is painted blue instead. Note that both the chess pieces **must** be moved in each step. Two pieces can be on the same vertex at any given time.

378QAQ wants to know the minimum number of steps to paint all vertices blue.

---
两个棋子的轨迹相遇前没有贡献，相遇后，则最贪心做法是贴着走。
以a为根节点建树，求出b的深度为dep\[b]。
这里分奇偶讨论以下，求出相遇点为r.
然后以r为根节点再跑一遍dfs，求出最长链。
从一个点出发遍历完整颗树再回到原点的距离为2*(n-1),如果不用回到原点则减去一条从根出发的最长链的长度。

---
```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
//#define int ll
const int N = 2e5+10;
int head[N];
int to[2*N];
int nx[2*N];
int id;
void add(int x,int y) {
    to[id] = y;
    nx[id] = head[x];
    head[x] = id++;
}
int f[N];
int dep[N];
void dfs(int cur,int fa) {
    bool f1 = false;
    if (fa == 0) {
        dep[cur] = 0;
    } else {
        dep[cur] = dep[fa] + 1;
    }
    for (int i = head[cur]; i > 0; i = nx[i]) {
        int nxt = to[i];
        if (nxt == fa) continue;
        dfs(nxt,cur);
    }
    f[cur] = fa;
}

void solve() {
    int n;
    cin >> n;
    id = 1;
    for (int i = 0; i <= n; i++) {
        head[i] = 0;
        f[i] = 0;
    }
    int a,b;
    cin >> a >> b;
    for (int i = 1; i <= n-1; i++) {
        int u, v;
        cin >> u >> v;
        add(u,v);
        add(v,u);
    }
    dfs(a,0);
    int len, r = b;
    if (dep[b]%2 == 1) {
        len = dep[b]/2 + 1;
    } else {
        len = dep[b]/2;
    }
    for (int i = 1; i <= len; i++) {
        r =  f[r];
    }
    dfs(r,0);
    int mx = 0;
    for (int i = 1; i <= n; i++) {
        mx = max(mx,dep[i]);
    }
    // cout << mx << endl;
    // cout << len << endl;
    cout << (n-1) * 2 - mx + len << endl;
}

signed main() {
    cin.tie(nullptr)->ios::sync_with_stdio(false);
    int T = 1;
    cin >> T;
    while (T--) {
       solve();
    }
    return 0;
}   /* created: 2024-12-12 18:05 author: Egrvigrf */
```