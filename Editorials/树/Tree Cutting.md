[C. Tree Cutting](https://codeforces.com/contest/1946/problem/C)

#二分
#DFS
#树
题意：给一棵树，恰好切除k条边，被分割的所有子树的顶点数量的最小值为x,求x的最大值


对于一个k,判断是否满足某一个x比较容易，而其x具有单调性：随着x增大，满足条件的可能性减小
可以考虑二分

如何判断一对于一组(k,x)是否满足条件？考虑贪心：

从树的底部开始累加顶点的数量，如果顶点的数量等于x，计数清零并累加tmp的值，最后跑完DFS判断tmp的值是否大于k+1(切割k次，得到k+1块)

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
using ld = long double;
using ull = unsigned long long;
#define IOS ios::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr)
#define _for(i,start,end) for(int i = (start); i < (end); i++)
#define _rep(i,start,end) for(int i = (start); i <= (end); i++)
#define for_(i,end,start) for(int i = (end); i > (start); i--)
#define rep_(i,end,start) for(int i = (end); i >= (start); i--)
#define all(x) (x).begin(), (x).end()
#define rall(x) (x).rbegin(), (x).rend()
#define inf 0x3f3f3f3f // 1e9
#define endl '\n'
int n,k;
const int N = 1e5+1;
int head[N];
int to[2*N];
int nxt[2*N];
int cnt = 1;
int tmp;
int vis[N];
void addedge(int x,int y) {
    to[cnt] = y;
    nxt[cnt] = head[x];
    head[x] = cnt++; 
}
void clear_(int n) {
    for(int i = 1; i <= n; i++) {
        head[i] = 0;
        vis[i] = 0;
    }
}
int dfs(int p, int ch,int x) {
    vis[p] = 1; 
    if(head[p] == 0) return 1;
    for(int i = head[p]; i; i = nxt[i]) {
        int t = to[i];
        if(!vis[t])
            ch += dfs(t,0,x);
    }
    if(ch + 1 >= x) {
        tmp++;
        return 0;
    } else {
        return ch+1;
    }
}

bool ck(int x) {
    tmp = 0;
    dfs(1,0,x);
    if(tmp >= k+1) return true;
    else return false;
}
void solve() {
    cin >> n >> k;
    clear_(n);
    cnt = 1;
    for(int i = 1; i <= n-1; i++) {
        int x,y;
        cin >> x >> y;
        addedge(x,y);
        addedge(y,x);
    }
    int l = 1,r = n;
    int ans = 1;
    while(l <= r) {
        int mid = (l+r) >> 1;
        dbg(mid);
        if(ck(mid)) {
            l = mid + 1;
            ans = max(ans,mid);
        } else {
            r = mid - 1; 
        }
        for(int i = 1; i <= n; i++) vis[i] = 0;
    }
    cout<<ans<<endl;
}

int main() {
    IOS;
    int T;
    cin >> T;
    while(T--) {
        solve();
    }           
    return 0;
}

/**
 * author:  Egrvigrf
 * created: 2024-07-18 16:17
**/
```