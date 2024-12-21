#差分前缀和
[Photoshoot for Gorillas](https://codeforces.com/contest/2000/problem/E)
You really love gorillas, so you decided to organize a photoshoot for them. Gorillas live in the jungle. The jungle is represented as a grid of $n$ rows and $m$ columns. $w$ gorillas agreed to participate in the photoshoot, and the gorilla with index $i$ ($1 \le i \le w$) has a height of $a_i$. You want to place **all** the gorillas in the cells of the grid such that there is **no more than one gorilla** in each cell. The spectacle of the arrangement is equal to the sum of the spectacles of all sub-squares of the grid with a side length of $k$. The spectacle of a sub-square is equal to the sum of the heights of the gorillas in it. From all suitable arrangements, choose the arrangement with the **maximum** spectacle.

**Input**
The first line contains an integer $t$ ($1 \le t \le 10^3$) — the number of test cases. The descriptions of the test cases follow. The first line contains integers $n$, $m$, $k$ ($1 \le n, m \le 2 \cdot 10^5$, $1 \le n \cdot m \le 2 \cdot 10^5$, $1 \le k \le \min(n, m)$) — the dimensions of the grid and the side length of the square. The second line contains an integer $w$ ($1 \le w \le n \cdot m$) — the number of gorillas. The third line contains $w$ integers $a_1, a_2, \ldots, a_w$ ($1 \le a_i \le 10^9$) — the heights of the gorillas. It is guaranteed that the sum of $n \cdot m$ across all test cases does not exceed $2 \cdot 10^5$. The same guarantee applies to $w$.

贪心地考虑把从高到矮把大猩猩放入从密到疏的格子里。
在n\*m的网格里饱和放入k\*k的矩阵，用二维差分快速计算每个格子的重叠矩阵数目。
重叠数目从大到小排序，猩猩身高从高到矮排序，相乘求和。

```cpp
#define int long long
void solve() {
    int n,m,k,w;
    cin >> n >> m >> k >> w;
    int a[w+1];
    _rep(i,1,w) cin >> a[i];
    int sum[n+2][m+2];
    memset(sum,0,sizeof(sum));
    for(int i = 1; i + k - 1 <= n; i++) {
        for(int j = 1; j + k - 1 <= m; j++) {
            int i2 = i + k - 1, j2 = j + k - 1;
            sum[i][j]++;
            sum[i2+1][j2+1]++;
            sum[i2+1][j]--;
            sum[i][j2+1]--;
        }
    }
    vector<int> b;
    for(int i = 1; i <= n; i++) {
        for(int j = 1; j <= m; j++) {
            sum[i][j] += sum[i-1][j] + sum[i][j-1] - sum[i-1][j-1];
            b.push_back(sum[i][j]);
        }
    }
    sort(all(b));
    sort(a+1,a+w+1);
    int cnt = b.size() - 1;
    int ans = 0;
    rep_(i,w,1) {
        ans += a[i]*b[cnt--];
    }
    cout<<ans<<endl;
}
```