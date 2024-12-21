[CF](https://codeforces.com/contest/2047/problem/D)
You are given an array of integers $a$ of length $n$. You can perform the following operation zero or more times:

-   In one operation choose an index $i$ ($1 \le i \le n$), assign $a_i := a_i + 1$, and then move $a_i$ to the back of the array (to the rightmost position). For example, if $a = [3, 5, 1, 9]$, and you choose $i = 2$, the array becomes $[3, 1, 9, 6]$.

Find the lexicographically smallest$^{\text{∗}}$ array you can get by performing these operations.

$^{\text{∗}}$An array $c$ is lexicographically smaller than an array $d$ if and only if one of the following holds:

-   $c$ is a prefix of $d$, but $c \ne d$; or
-   in the first position where $c$ and $d$ differ, the array $c$ has a smaller element than the corresponding element in $d$.

---
因为每次操作可以任意选择下标，每个数最多被增加一次，所以我们只要确定哪些元素被操作过。
考虑用单调栈维护一个递增的序列，每当元素进入破坏单调递增时，把前面的元素移动走，始终单增。对于栈内剩下的元素，如果比已经操作过的元素的最小值还要大，那就++.
相当于就是有一部分元素（单调栈的前面部分或者全部）不动，其他位置都按照某一种顺序进行操作。


---

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
//#define int ll

void solve() {
    int n;
    cin >> n;
    int a[n+1];
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }
    int stk[n+1];
    int top = 0;
    vector<int> ans;
    int mi = 1000000000;
    for (int i = 1; i <= n; i++) {
        while(top && a[i] < a[stk[top]]) {
            ans.push_back(a[stk[top]]+1);
            mi = min(mi,a[stk[top]]+1);
            top--;
        }
        stk[++top] = i;
    }
    // cout << mi << endl;
    while(top) {
        // cout << a[stk[top]] << endl;
        if (a[stk[top]] > mi) {
            ans.push_back(a[stk[top--]]+1);
        } else {
            ans.push_back(a[stk[top--]]);
        }
    }
    sort(ans.begin(),ans.end());
    for (auto i : ans) {
        cout << i << " ";
    }
    cout << '\n';
}

signed main() {
    cin.tie(nullptr)->ios::sync_with_stdio(false);
    int T = 1;
    cin >> T;
    while (T--) {
       solve();
    }
    return 0;
}   /* created: 2024-12-10 15:11 author: Egrvigrf */
```