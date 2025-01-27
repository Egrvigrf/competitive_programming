[ D-Function](https://codeforces.com/contest/1985/problem/G)
Let D(n) represent the sum of digits of nn. For how many integers nn where 10l≤n<10r10l≤n<10r satisfy D(k⋅n)=k⋅D(n)D(k⋅n)=k⋅D(n)? Output the answer modulo 109+7109+7.

Input

The first line contains an integer tt (1≤t≤1041≤t≤104) – the number of test cases.

Each test case contains three integers ll, rr, and kk (0≤l<r≤1090≤l<r≤109, 1≤k≤1091≤k≤109).

Output

For each test case, output an integer, the answer, modulo 109+7109+7.

满足要求要每一位的数字能扩大k倍不溢出显每一位能取到\[0,9/k]
当k >= 10 时直接输出0

最终的答案用快速幂求得后相减即可

```cpp
#include<bits/stdc++.h>
using namespace std;
#define int long long
int mod = 1e9 + 7;
#define dbg(x) cout<<#x<<" = "<<endl
int power(int a, int b) {
    int ans = 1;
    while (b != 0) {
        if (b % 2) {
            ans = ans*a%mod;
        }
        a = a*a%mod;
        b /= 2;
    }
    return ans;
}
void solve() {
    int l, r, k;
    cin >> l >> r >> k;
    if (k > 10) {
        cout << 0 << endl;
        return;
    } else {
        int lim = 9 / k;
        cout<<(power(lim+1,r) - power(lim+1,l) + mod)%mod<<endl;
    }

}
signed main() {
    int T;
    cin >> T;
    while (T--) {
        solve();
    }
}
```
