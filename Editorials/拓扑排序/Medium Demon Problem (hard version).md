[CF](https://codeforces.com/problemset/problem/2044/G2)

一群 n 蜘蛛聚在一起交换毛绒玩具。最初，每只蜘蛛都有 1 个毛绒玩具。每年，如果蜘蛛 i 至少有一个毛绒玩具，他就会给蜘蛛 ri一个毛绒玩具。否则，他什么也不会做。请注意，所有毛绒玩具的转移都是同时进行的。**在这个版本中，每只蜘蛛在任何时候都可以拥有一个以上的毛绒玩具。

如果每只蜘蛛在本年度(本年度交换前)拥有的毛绒玩具数量与上一年度(上一年度交换前)相同，则本年度的进程是稳定的。请注意， 第 1 年不可能是稳定的。

请找出进程趋于稳定的第一年。

---

所有的玩具都会指向某一个环，指向环的是若干颗树，稳定时就是每颗树的节点数+2,求所有树的节点+2的最小值。环外的点可以用拓扑排序求得，玩具的值可以从树叶到树根层层向上累加，也就是拓扑序，按拓扑序建立一个数组，然后从头到尾依次累加即可。

---

Code
```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
//#define int ll

void solve() {
    int n;
    cin >> n;
    vector<int> deg(n+1,0),v(n+1,1),nx(n+1);
    vector<bool> vis(n+1,false);
    for (int i = 1; i <= n; i++) {
        int y;
        cin >> y;
        nx[i] = y;
        deg[y]++;
    }
    vector<int> ad;
    queue<int> q;
    for (int i = 1; i <= n; i++) {
        if (deg[i] == 0) {
            q.push(i);
        }
    }
    while(q.size()) {
        int t = q.front();
        q.pop();
        ad.push_back(t);
        vis[t] = true;
        if (--deg[nx[t]] == 0) {
            q.push(nx[t]);
        }
    }
    for (auto i : ad) {
        v[nx[i]] += v[i];
    }
    int ans = 0;
    for (int i = 1; i <= n; i++) {
        if (vis[i]) {
            ans = max(ans,v[i]);
        }
    }
    cout << ans + 2 << '\n';
}

signed main() {
    cin.tie(nullptr)->ios::sync_with_stdio(false);
    int T = 1;
    cin >> T;
    while (T--) {
       solve();
    }
    return 0;
}   /* created: 2025-01-08 16:04 author: Egrvigrf */
```