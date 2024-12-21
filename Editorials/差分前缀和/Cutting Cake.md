#二分 #前缀和 
爱丽丝正在参加疯帽子的茶会！有一个长条蛋糕，由 n 个部分组成，美味值为 a1,a2,…,ana 。茶会上有 m 个生物，不包括爱丽丝。

爱丽丝会把蛋糕切成 m+1 块。从形式上看，她会将蛋糕分割成 m+1 个子数组，其中每个子数组由一定数量的相邻部分组成。一块蛋糕的美味程度是其各部分美味程度的总和。之后，她会把这些 m+1 碎片分给 m 个生物和她自己(她的碎片可以是空的)。然而，只有当每个 m 生物的美味度达到或超过 v 时，它们才会感到快乐。

爱丽丝希望确保每个生物都快乐。受限于这个条件，她也想让自己的棋子美味度最大化。你能帮爱丽丝找到她的棋子的最大美味度吗？如果无法确保每个生物都快乐，则输出 −1。


---

Alice的答案区间为\[i,j],暴力枚举所有可能的情况。
用前缀，后缀信息记录从\[:i]，\[i:]的最多可能情况。
枚举i，对于每一个i，右区间可以二分来枚举满足所有可能情况的j的最大值。

---

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
#define int ll

// ll sum[N];
// int pre[N], suf[N];  // 表示[:i],[i:] 有多少个满足条件的
void solve() {
    int n, m, v;
    cin >> n >> m >> v;
    vector<int> a(n+1);
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }
    vector<int> sum(n+1,0),pre(n+2),suf(n+2);
    for (int i = 1; i <= n; i++) {
        sum[i] = sum[i-1] + a[i]; 
    }
    int tmp = 0;
    for (int i = 1; i <= n; i++) {
        tmp += a[i];
        pre[i] = pre[i-1];
        if (tmp >= v) {
            tmp = 0;
            pre[i]++;
        }
    }
    tmp = 0;
    for (int i = n; i >= 1; i--) {
        tmp += a[i];
        suf[i] = suf[i+1];
        if (tmp >= v) {
            tmp = 0;
            suf[i]++;
        }
    }
    if (suf[1] < m) {
        cout << -1 << endl;
        return;
    }
    int mx = 0;
    for (int i = 1; i <= n; i++) {
        int L = i, R = n;
        while(L <= R) {
            int mid = (L+R) >> 1;
            if (pre[i-1]+suf[mid+1] >= m) {
                mx = max(sum[mid]-sum[i-1],mx);
                L = mid + 1;
            } else {
                R = mid - 1;
            }
        }
    }
    cout << mx << endl;
}

signed main() {
    cin.tie(nullptr)->ios::sync_with_stdio(false);
    int T = 1;
    cin >> T;
    while (T--) {
        solve();
    }
    return 0;
} /* created: 2024-12-10 16:44 author: Egrvigrf */
```