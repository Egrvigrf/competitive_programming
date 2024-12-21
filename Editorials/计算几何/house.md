在一个二维平面内，一个房子由一个长方形和一个等腰三角形组成。
给定 n 个在二维平面中的点，从中选择 5 个不相同的点，能组成有多少个不相同的房 子。 两个房子不相同当且仅当存在至少一个点的坐标不同。

第一行一个整数 n（1 ≤ n ≤ 300），表示点的个数。 第 2 ∼ (n + 1) 行，每行两个整数 x, y（−10e9 ≤ x, y ≤ 10e9），表示一个点。 保证不存在相同坐标的两个点。

枚举等腰三角形，用map记录满足等腰的三角形底边长度，并用map记录该长度的边的数量
每次遍历到等腰都尝试组合满足条件的长方形。
叉积== 0 （共线） 和 叉积 < 0 (房顶朝下) 也要舍去

```cpp
#include<bits/stdc++.h>
using namespace std;
using ll = long long;
const int N = 310;
#define debug(x) cout << #x << " = " << x << endl
struct Point {
    ll x,y;
    Point operator+(Point p) { return Point{x + p.x, y + p.y}; }
    Point operator-(Point p) { return Point{x - p.x, y - p.y}; }
    ll operator^(Point p) { return x * p.y - p.x * y; } //叉积
    ll operator*(Point p) { return  x * p.x + y * p.y; } 
}p[N];
ll sqPP(Point u, Point v) {
    return (u.x - v.x) * (u.x - v.x) + (u.y - v.y) * (u.y - v.y);
}
int main() {
    ios::sync_with_stdio(0),cin.tie(nullptr);
    int n; cin >> n;
    for (int i = 1; i <= n; i++) {
        cin >> p[i].x >> p[i].y;
    }
    ll ans = 0;
    for (int i = 1; i <= n; i++) {
        map<pair<ll,ll>,int> mp;
        for (int j = 1; j <= n; j++) {
            for (int k = 1; k <= n; k++) { 
                if (i == j || j == k || i == k) {
                    continue;
                }
                if (sqPP(p[i], p[j]) != sqPP(p[i], p[k])) {
                    continue;
                }
                if ( ((p[i]-p[j])^(p[i] - p[k])) <= 0) {
                    continue;
                }
                auto d = p[k] - p[j];
                ans += mp[{d.x,d.y}]++;
            }
        }
    }
    cout<<ans <<endl;
    return 0;
}
```