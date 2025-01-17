[链接：牛客](https://ac.nowcoder.com/acm/contest/81596/I)  

#模拟 #分层图 #记忆化搜索

---
### Problem Statement

There is an $n \times m$ mirror maze, where there is a mirror on each grid. The mirrors are in one of the following four types:  

- `-`: The light from **above** or **below** will be reflected back, while the light from **left** or **right** will continue going forward without being reflected, respectively.
- `|`: The light from **left** or **right** will be reflected back, while the light from **above** or **below** will continue going forward without being reflected, respectively.
- `/`: The light from **left**, **right**, **above**, or **below** will be reflected to go **above**, **below**, **left**, or **right**, respectively.
- `\`: The light from **left**, **right**, **above**, or **below** will be reflected to go **below**, **above**, **right**, or **left**, respectively.

Now there are  $q$  light sources. Little G, the believer of the light, wants to know the numbers of different mirrors the emitted light will be reflected by within sufficient time for each light source.

## 输入描述:

The first line contains two integers $n$ and $m$ (`1 ≤ n, m ≤ 1000`), denoting the size of the mirror maze.

Each of the following `n` lines contains a string of length `m`, where the character $S_{i,j}$  (`Si,j ∈ { |, -, /, \ }`) denotes the mirror on grid `(i, j)`.

The next line contains an integer `q` (`1 ≤ q ≤ 10^5`), denoting the number of light sources.

Each of the following `q` lines contains:
- Two integers `u` (`1 ≤ u ≤ n`) and `v` (`1 ≤ v ≤ m`), representing the position of the light source.
- A string `dir` (`dir ∈ { above, below, left, right }`), representing the direction in which the light is emitted.

The light will not be influenced by the mirror on grid `(u, v)` initially.


## 输出描述:

Output $q$ lines each containing one integer, denoting the number of different mirrors the emitted light will be reflected by within sufficient time for each light source.

### 样例输入

```
2 3
/\-
\/|
2
1 2 below
2 2 right
```
### 样例输出
```
4
2
```

## 说明
- For the first light, it will be reflected by the mirrors at (2,2), (2,1), (1,1), (1,2), (2,2), (2,1), (1,1), (1,2), (2,2), (2,1), (1,1), (1,2) repeatedly, and stay in the mirror maze.
- For the second light, it will be reflected by (2,3), (2,3), (2,3), and go back to (2,2), (2,2), (2,2), then reflected by (2,2), (2,2), (2,2), go below, and get away from the mirror maze.

---

## 题解
发现所有的入射光线不是走出迷宫，就是一直在内部循环，路径形成链或者环。
对于每次查询，计算完整的链或者环。不可计算一半然后下次连上，会算重。

---

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
#define int ll
#define rep(i, a, b) for (int i = (a); i <= (b); i++)
#define rrep(i, b, a) for (int i = (b); i >= (a); i--)
#define pii pair<int, int>
#define endl '\n'
const int N = 1010;
int n, m;
char M[N][N];
int go[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
int dp[N][N][4];
bool vis[N][N];
tuple<int, int, int> ed1, ed2;
stack<pair<int, int>> stk;
map<string, int> mpss = {{"above", 0}, {"below", 1}, {"left", 2}, {"right", 3}};
unordered_map<char, map<int, int>> mp = {
    {'/', {{0, 3}, {1, 2}, {2, 1}, {3, 0}}},
    {'\\', {{0, 2}, {1, 3}, {2, 0}, {3, 1}}},
    {'|', {{0, 0}, {1, 1}, {2, 3}, {3, 2}}},
    {'-', {{0, 1}, {1, 0}, {2, 2}, {3, 3}}},
};
map<int, int> vs = {{1, 0}, {0, 1}, {2, 3}, {3, 2}};
void clr() {
    while (stk.size()) {
        vis[stk.top().first][stk.top().second] = false;
        stk.pop();
    }
}
int f1(int x, int y, int dir) { // 计算完整的光链，如果不是计算完整的光链而是算半截，可能会算重镜面
    if (dp[x][y][dir] != -1) { 
        ed2 = {x, y, dir};
        return dp[x][y][dir];
    }
    int nx = x + go[dir][0], ny = y + go[dir][1];
    int ndir = mp[M[nx][ny]][dir];
    int cnt = f1(nx, ny, ndir);
    //flag 判断当前是否应该记录反射，注意应该在所有递归终止时开始比较，从光链尾部到头部，开始记录。从头部到尾部会少算
    bool flag = 0; 
    if (dir != ndir && !vis[nx][ny]) { //方向变化且这个镜子没有计算时flag才为1
        vis[nx][ny] = true;
        stk.push({nx, ny}); //这样只能用一个栈来消除vis
        flag = 1; 
    }
    return dp[x][y][dir] = cnt + flag;
}

int f2(int x, int y, int dir, int step, int sx, int sy, int sdir) { // 判断有无环
    if (dp[x][y][dir] != -1) {
        ed1 = {x, y, dir};
        return 0;
    }
    int nx = x + go[dir][0], ny = y + go[dir][1];
    int ndir = mp[M[nx][ny]][dir];
    if (dir != ndir && !vis[nx][ny]) {
        vis[nx][ny] = true;
        step++;
    }
    if (nx == sx && ny == sy && ndir == sdir) {
        dp[x][y][dir] = step;
        vis[nx][ny] = false;
        return 1;
    }
    int cnt = f2(nx, ny, ndir, step, sx, sy, sdir);
    vis[nx][ny] = false;
    if (cnt) dp[x][y][dir] = dp[nx][ny][ndir];
    return cnt;
}

signed main() {
    cin >> n >> m;
    rep(i, 1, n) rep(j, 1, m) cin >> M[i][j];
    rep(i, 0, n + 1) rep(j, 0, m + 1) rep(k, 0, 3) dp[i][j][k] = -1;
    rep(i, 1, m) dp[1][i][0] = dp[n][i][1] = 0;
    rep(i, 1, n) dp[i][1][2] = dp[i][m][3] = 0;
    int q;
    cin >> q;
    while (q--) {
        int x, y;
        string ss;
        cin >> x >> y >> ss;
        int dir = mpss[ss];
        if (dp[x][y][dir] != -1) {
            cout << dp[x][y][dir] << endl;
            continue;
        }// 判断是否是循环链条，是循环链则在f2中更新各个循环部分的值
        if (f2(x, y, dir, 0, x, y, dir) == 0) { 
            //计算循环链条时顺带记录一个光链终点的值
            int ex = get<0>(ed1), ey = get<1>(ed1), edir = get<2>(ed1); 
            // 从终点开始跟新路径上的值，顺便记录出口
            f1(ex, ey, mp[M[ex][ey]][vs[edir]]); 
            clr(); // 如果第二个出口不等于第一个出口，则光链有两个口，再从另一端跑一遍dfs
            if (ed2 != ed1) { 
                int ex2 = get<0>(ed2), ey2 = get<1>(ed2), edir2 = get<2>(ed2);
                f1(ex2, ey2, mp[M[ex2][ey2]][vs[edir2]]);  
                clr();
            }
        }
        cout << dp[x][y][dir] << endl;
    }
    return 0;
}
```