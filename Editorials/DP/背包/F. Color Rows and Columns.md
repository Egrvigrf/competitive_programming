You have $n$ rectangles, the $i$\-th of which has a width of $a_i$ and a height of $b_i$.

You can perform the following operation an unlimited number of times: choose a rectangle and a cell in it, and then color it.

Each time you completely color any row or column, you earn $1$ point. Your task is to score at least $k$ points with as few operations as possible.

Suppose you have a rectangle with a width of $6$ and a height of $3$. You can score $4$ points by coloring all the cells in any $4$ columns, thus performing $12$ operations.

**Input**

The first line contains an integer $t$ ($1 \le t \le 100$) — the number of test cases. The following are the descriptions of the test cases.

The first line of each test case description contains two integers $n$ and $k$ ($1 \le n \le 1000, 1 \le k \le 100$) — the number of rectangles in the case and the required number of points.

The next $n$ lines contain the descriptions of the rectangles. The $i$\-th line contains two integers $a_i$ and $b_i$ ($1 \le a_i, b_i \le 100$) — the width and height of the $i$\-th rectangle.

It is guaranteed that the sum of the values of $n$ across all test cases does not exceed $1000$.

**Output**

For each test case, output a single integer — the minimum number of operations required to score at least $k$ points. If it is impossible to score at least $k$ points, output \-1.

对于每个矩形有最优解，但是选择时每个矩形不一定要完全涂完，不能贪心。
考虑分组DP,每个矩形为1组，组内的物品看成所选矩形的不同的涂色方案，而对于一个确定的矩形，涂色方案是确定的：先涂短边。
记dp\[i]\[j] ： 为前k个矩形涂色获得j分的代价
状态转移方程为 dp\[i]\[j1+j] = min(dp\[i-1]\[j1+j],dp\[i-1]\[j1] + cost)
其中cost为当前矩形涂j分所花费的代价
```cpp
int dp[1001][101];
int a[1001];
int b[1001];
void solve() {
    int n, k;
    cin >> n >> k;
    for (int i = 1; i <= n; i++) {
        cin >> a[i] >> b[i];
    }
    for (int i = 0; i <= n; i++) {
        for (int j = 0; j <= k; j++) {
            dp[i][j] = inf;
        }
    }
    dp[0][0] = 0;
    for (int i = 1; i <= n; i++) {
        int x = a[i], y = b[i];
        int xy = x + y;
        int cost = 0;
        for (int j = 0; j <= xy; j++) { // 分组背包，每个矩形的不同操作方案是同一个组，枚举组内最优解
            for (int j1 = 0; j1 + j <= k; j1++) {
                dp[i][j1 + j] = min(dp[i][j1 + j], dp[i - 1][j1] + cost);
            }
            if (x > y) {
                cost += y;
                x--;
            } else {
                cost += x;
                y--;
            }

        }
    }
    cout << (dp[n][k] == inf ? -1 : dp[n][k]) << endl;
}
```