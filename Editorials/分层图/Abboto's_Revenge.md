分层图BFS
[Abbott的复仇](https://www.luogu.com.cn/problem/UVA816)

给出一个箭头迷宫，在每个路口处，如果你从某个方向进入了该路口，那么路口的地面上在靠近你的方向会画有一组箭头，它们相对于你的方向可以是向左，向前，向右，或者是它们的任意组合。

当你从某一方向进入某个入口时，下一步只能在这个入口对应方向上标记的箭头中选一个方向继续行进。在起点时，可以选择任何方向。

给出起点和终点，求它们之间的最短路径。

每条边的长度为1

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
using ld = long double;
using ull = unsigned long long;
#define IOS                      \
    ios::sync_with_stdio(false); \
    cin.tie(nullptr);            \
    cout.tie(nullptr)
#define _for(i, start, end) for (int i = (start); i < (end); i++)
#define _rep(i, start, end) for (int i = (start); i <= (end); i++)
#define for_(i, end, start) for (int i = (end); i > (start); i--)
#define rep_(i, end, start) for (int i = (end); i >= (start); i--)
#define all(x) (x).begin(), (x).end()
#define rall(x) (x).rbegin(), (x).rend()
#define inf 0x3f3f3f3f  // 1e9
#define endl '\n'
#define debug(x) cout << #x << " = " << x << endl

int main() {
    IOS;
    string name;
    pair<int, int> dir[4] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}}; // E S W N
    int R[4] = {1, 2, 3, 0};
    int L[4] = {3, 0, 1, 2};
    map<char, int> dir_mp = {{'E', 0}, {'S', 1}, {'W', 2}, {'N', 3}};
    while (cin >> name) {
        if (name == "END") break;
        int sx, sy, ex, ey;
        char direction;
        cin >> sx >> sy >> direction >> ex >> ey;
        vector<char> M[10][10][4];
        bool vis[10][10][4];
        memset(vis, 0, sizeof(vis));
        while (true) {
            int x, y;
            cin >> x;
            if (x == 0) break;
            cin >> y;
            while (true) {
                string s;
                cin >> s;
                if (s == "*") break;
                for (size_t i = 1; i < s.size(); i++) {
                    M[x][y][dir_mp[s[0]]].push_back(s[i]);
                }
            }
        }
        struct Node {
            int x, y, dir;  // E S W N
        };
        int sdir = dir_mp[direction];
        Node start = {sx + dir[sdir].first, sy + dir[sdir].second, sdir};
        queue<Node> q;
        q.push(start);
        bool ok = false;
        Node pre[10][10][4];
        pre[sx + dir[sdir].first][sy + dir[sdir].second][sdir] = {0, 0, 0}; //不包括第一个起点避免成环
        int enddir;
        while (!q.empty()) {
            Node current = q.front();
            q.pop();
            int x = current.x, y = current.y;
            int curdir = current.dir;
            vis[x][y][curdir] = 1;
            if (x == ex && y == ey) {
                ok = true;
                enddir = curdir;
                break;
            }
            for (auto& z : M[x][y][curdir]) {
                int ndir;
                if (z == 'L') {
                    ndir = L[curdir];
                } else if (z == 'R') {
                    ndir = R[curdir];
                } else {
                    ndir = curdir;
                }
                int nx = x + dir[ndir].first, ny = y + dir[ndir].second;
                if (nx < 1 || nx > 9 || ny < 1 || ny > 9) continue;
                if (!vis[nx][ny][ndir]) {
                    Node next = {nx, ny, ndir};
                    pre[nx][ny][ndir] = {x, y, curdir};
                    q.push(next);
                } 
            }
        }
        cout << name << endl << "  ";
        if (ok) {
            stack<pair<int, int>> ans;
            Node tra = {ex, ey, enddir};
            while (!(tra.x == 0 && tra.y == 0 && tra.dir == 0)) {
                ans.push(make_pair(tra.x, tra.y));
                tra = pre[tra.x][tra.y][tra.dir];
            }
            ans.push(make_pair(sx, sy));  // 起点
            int i = 1;
            while (ans.size()) {
                cout << "(" << ans.top().first << "," << ans.top().second << ")";
                if (ans.size() != 1 && i % 10 != 0) cout << " ";
                if (ans.size() != 1 && i % 10 == 0) cout << endl << "  ";
                ans.pop();
                i++;
            }
        } else {
            cout << "No Solution Possible";
        }
        cout << endl;
    }
    return 0;
}

/**
 * author:  Egrvigrf
 * created: 2024-07-15 12:07
 **/

```