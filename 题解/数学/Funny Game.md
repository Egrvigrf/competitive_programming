[Funny Game](https://codeforces.com/contest/1994/problem/D)
Vanya has a graph with nn vertices (numbered from 11 to nn) and an array aa of nn integers; initially, there are no edges in the graph. Vanya got bored, and to have fun, he decided to perform n−1n−1 operations.

Operation number xx (operations are numbered in order starting from 11) is as follows:

- Choose 22 different numbers 1≤u,v≤n1≤u,v≤n, such that |au−av||au−av| is divisible by xx.
- Add an undirected edge between vertices uu and vv to the graph.

Help Vanya get a connected∗∗ graph using the n−1n−1 operations, or determine that it is impossible.

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;

#define int ll
#define DBG

#define rep(i,a,b) for(int i=(a);i<=(b);i++)
#define rrep(i,b,a) for(int i=(b);i>=(a);i--)
#ifdef DBG
#define dbg(...) (cout<<":D ",_((char*)#__VA_ARGS__,__VA_ARGS__))
template<typename t> void _(char* p,t x){cout<<p<<'='<<x<<'\n';}
template<typename t,typename... a>
void _(char* p,t x,a... y){while(*p!=',')cout<<*p++;cout<<'='<<x<<',';_(p+1,y...);}
#else
#define dbg(...) ((void)0)
#endif

void solve() {
    int n;
    cin >> n;
    int a[n+1];
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }
    stack<pair<int,int>> ans;
    bool vis[n+1];
    memset(vis,0,sizeof(vis));
    for (int x = n - 1; x >= 1; x--) { //鸽巢原理必有两个相同
        unordered_map<int,int> mp;
        for (int i = 1; i <= n; i++) {
            if (vis[i]) continue;
            int cur = a[i]%x;
            if (mp.find(cur) != mp.end()) {
                ans.push({mp[cur],i});
                vis[i] = 1;
                break;
            } else {
                mp[cur] = i;
            }
        }
    }
    cout << "YES" << endl;
    while(ans.size()) {
        cout << ans.top().first << " " << ans.top().second << endl;
        ans.pop();
    }
}

signed main() {
    ios::sync_with_stdio(false);cin.tie(nullptr);
    int T; cin >> T;
    while (T--) solve();
    return 0;
}   /* created: 2024-11-29 16:47 author: Egrvigrf */
```