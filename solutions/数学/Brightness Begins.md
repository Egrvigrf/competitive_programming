[CF](https://codeforces.com/contest/2020/problem/B)
Imagine you have $n$ light bulbs numbered $1, 2, \ldots, n$. **Initially, all bulbs are on**. To flip the state of a bulb means to turn it off if it used to be on, and to turn it on otherwise.

Next, you do the following:

-   for each $i = 1, 2, \ldots, n$, flip the state of all bulbs $j$ such that $j$ is divisible by $i^\dagger$.

After performing all operations, there will be several bulbs that are still on. Your goal is to make this number exactly $k$.

Find the smallest suitable $n$ such that after performing the operations there will be exactly $k$ bulbs on. We can show that an answer always exists.

$^\dagger$ An integer $x$ is divisible by $y$ if there exists an integer $z$ such that $x = y\cdot z$.

**Input**

Each test contains multiple test cases. The first line contains the number of test cases $t$ ($1 \le t \le 10^4$). The description of the test cases follows.

The only line of each test case contains a single integer $k$ ($1 \le k \le 10^{18}$).

---

**有一个trick:只有平方数的因子个数为奇数。**
非平方数因子都成对，只有平方数的因子k,k\*k = n不能成对。

考虑二分查找含有平方数的个数，注意手写整数开根别爆long long。

---

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
//#define int ll
ll k;
bool check(ll m) { 
    ll L = 1, R = m;
    ll mx = 0;
    while(L <= R) { // 手写二分开根
        ll mid = (L+R) >> 1;
        if (mid <= m/mid) { // 注意，不能写成 mid*mid <= m 会爆long long
            mx = max(mx,mid);
            L = mid + 1;
        } else {
            R = mid - 1;
        }
    }
    if (m - mx >= k) return true;
    else return false;
}
void solve() {
    cin >> k;
    ll L = 1, R = 2e18;
    ll ans = 2e18;
    while(L <= R) {
        ll mid = (L+R) >> 1;
        if (check(mid)) {
            ans = min(ans,mid);
            R = mid - 1;
        } else {
            L = mid + 1;
        }
    } 
    cout << ans << endl;
}

signed main() {
    cin.tie(nullptr)->ios::sync_with_stdio(false);
    int T = 1;
    cin >> T;
    while (T--) {
       solve();
    }
    return 0;
}   /* created: 2024-12-09 23:57 author: Egrvigrf */
```