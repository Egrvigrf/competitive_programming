Suppose you play a game where the game field looks like a strip of $1 \times 10^9$ square cells, numbered from $1$ to $10^9$.

You have $n$ snakes (numbered from $1$ to $n$) you need to place into some cells. Initially, each snake occupies exactly one cell, and you can't place more than one snake into one cell. After that, the game starts.

The game lasts for $q$ seconds. There are two types of events that may happen each second:

-   snake $s_i$ enlarges: if snake $s_i$ occupied cells $[l, r]$, it enlarges to a segment $[l, r + 1]$;
-   snake $s_i$ shrinks: if snake $s_i$ occupied cells $[l, r]$, it shrinks to a segment $[l + 1, r]$.

Each second, exactly one of the events happens.

If at any moment of time, any snake runs into some obstacle (either another snake or the end of the strip), you lose. Otherwise, you win with the score equal to the maximum cell occupied by any snake so far.

What is the minimum possible score you can achieve?

---

**Input**

The first line contains two integers $n$ and $q$ ($1 \le n \le 20$; $1 \le q \le 2 \cdot 10^5$) — the number of snakes and the number of events. Next $q$ lines contain the description of events — one per line.

The $i$\-th line contains

-   either "$s_i$ +" ($1 \le s_i \le n$) meaning that the $s_i$\-th snake enlarges
-   or "$s_i$ \-" ($1 \le s_i \le n$) meaning that the $s_i$\-th snake shrinks.

Additional constraint on the input: the given sequence of events is valid, i. e. a snake of length $1$ never shrinks.

---

占的距离要小，贪心地想蛇要尽可能挨在一起，如果对于每一种蛇的排列方法都能求出最小值，那么最小值就是求每一种排列的最小值，想到旅行商问题。
给定若干个点以及点与点之间的距离，求经过每个点一次的路径最小值。（其实一看数据范围n <= 20 也可想到复杂度2^n的做法）。

这个题目关键是如何求点与点之间的最小距离。可以贪心，假设dis\[i]\[j]存放第i条蛇之后跟着j的间隔，可以想象它们本来挨着。如果q时刻第x条蛇遇到+，那么x与它之后的蛇的距离减小，dis\[x]\[i]--（遇到-同理dis\[i]\[x]++）经过q个时间以内的任意一个时刻都>=0,那么紧挨着就行，间隔设为1,如果之前距离出现负数，那要记录负数的最小值(再设一个数组)，到时候取它的绝对值+1来防止相撞。

最终的长度为:1 + min（间隔之和+最后一条蛇向右挪的距离）
1是因为蛇只能往前挪动，第一条蛇放在第一格最优，然后不要忘了题目问的是过程之中占据的最大格子，所以要加上尾巴蛇的挪动距离。

Code 
```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
//#define int ll
#define inf 1e9
void solve() {
    int n, q;
    cin >> n >> q;
    vector<vector<int>> dis(n+1, vector<int>(n+1,0)), mindis(n+1, vector<int>(n+1,0));
    vector<int> move(n+1,0);
    while(q--) {
        int x;
        char op;
        cin >> x >> op;
        for (int i = 1; i <= n; i++) {
            if (op == '+') {
                dis[x][i]--;
                mindis[x][i] = min(mindis[x][i],dis[x][i]);     
                if (i == x) {
                    move[x]++;
                }       
            } else {
                dis[i][x]++;
            }
        }
    }
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            if (mindis[i][j] >= 0) {
                mindis[i][j] = 1;
            } else {
                mindis[i][j] = -mindis[i][j] + 1;
            }
        }
    }
    vector<vector<int>> dp(1<<n,vector<int>(n+1,inf));
    for (int i = 0; i < n; i++) {
        dp[1<<i][i+1] = 1;
    }
    for (int i = 1; i < (1 << n); i++) {
        for (int j = 0; j < n; j++) {
            if (((1 << j) & i) == 0) continue;
            for (int k = 0; k < n; k++) {
                if (((1 << k) & i) == 0 || k == j) continue;
                dp[i][j+1] = min(dp[i][j+1],dp[i^(1<<j)][k+1]+mindis[k+1][j+1]);
            } 
        }
    }
    int ans = inf;
    for (int i = 1; i <= n; i++) {
        ans = min(ans,dp[(1<<n)-1][i] + move[i]);
    }
    cout << ans << '\n';
}

signed main() {
    cin.tie(nullptr)->ios::sync_with_stdio(false);
    int T = 1;
    // cin >> T;
    while (T--) {
       solve();
    }
    return 0;
}   /* created: 2025-01-12 17:45 */
```