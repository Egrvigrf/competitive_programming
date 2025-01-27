[Atcode](https://atcoder.jp/contests/abc383/tasks/abc383_d)
Find the number of positive integers not greater than N that have exactly 9 positive divisors.
- 1≤N≤4×1012

---
**唯一分解定理**
任何一个> 1 的数都能分解成若干素数的乘积，且合并后如果不考虑顺序分解是唯一的。
$$
n = p_1^{r_1} \cdot r_2^{r_2} \cdot \dots \cdot r_k^{r_k}
$$
且$n$的所有因子个数为$$\prod_{i=1}^{n} (r_i + 1) = (r_1 + 1)(r_2 + 1) \dots (r_n + 1)$$
排列组合:对于每个素数$r_i$，可以有从$[0,r_i]$共$r_i+1$种不同的选法

---

如果n含有九个因子，9只能分解为 9 = 3 * 3 或者 9 * 1 这两种可能情况.
根据唯一分解定理，设$a,b$为素数，则所有可能的情况为


$$
\sum_{i=1}^{n} \left[ a^8 \leq n \right] + \sum_{i=1}^{n} \sum_{j=i+1}^{n} \left[ a^2 b^2 \leq n \right]
$$

可以筛出2e6以内的素数然后枚举

---

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
#define int ll
const int N = 2e6+10;
int cnt = 0;
int nprime[N];
int pri[N];
ll p(ll x) {
    return x*x*x*x;
}
signed main() {
    cin.tie(nullptr)->ios::sync_with_stdio(false);
    ll n;
    cin >> n;
    ll sq = sqrtl(n);
    for (ll i = 2; i <= sq; i++) {
        if (nprime[i]) continue;
        pri[++cnt] = i;
        for (ll j = 2*i; j <= sq; j += i) {
            nprime[j] = true;
        }
    }
    int ans = 0;
    for (int i = 1; i <= cnt; i++) {
        if (p(pri[i])> sq) {
            ans += i - 1;
            break;
        }
    }
    for (int i = 1; i <= cnt; i++) {
        for (int j = i + 1; j <= cnt; j++) {
            if (pri[i]*pri[j] > sq) {
                ans += j - 1 - i;
                break;
            }
        }
    }
    cout << ans << endl;
    return 0;
}   /* created: 2024-12-09 23:08 author: Egrvigrf */
```