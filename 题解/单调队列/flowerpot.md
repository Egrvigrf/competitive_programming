[flowerpot](https://www.luogu.com.cn/problem/P2698)

老板需要你帮忙浇花。给出 $N$ 滴水的坐标，$y$ 表示水滴的高度，$x$ 表示它下落到 $x$ 轴的位置。

每滴水以每秒 1 个单位长度的速度下落。你需要把花盆放在 $x$ 轴上的某个位置，使得从被花盆接着的第 1 滴水开始，到被花盆接着的最后 1 滴水结束，之间的时间差至少为 D。

我们认为，只要水滴落到 $x$ 轴上，与花盆的边沿对齐，就认为被接住。给出 N 滴水的坐标和 D 的大小，请算出最小的花盆的宽度 W。


滑动窗口+单调队列

状态存在pair里面稍微复杂一点，其实就是一个经典的滑动窗口
都取闭区间L到R
枚举以R为固定右边界时的情况

注意
`R - L + 1 >= 2 `
缩小窗口时当前窗口长度至少要>=2
当R = L 时缩小窗口会使窗口为空
但是单调队列可以`Rmx - Lmx + 1 >= 1`
因为当前进入队列的元素可能比之前的所有元素都更优，可以把队列便空
```cpp
#define pii pair<int,int> 
const int N = 1e5 + 10;
const int inf = 1e9;
int n,D;
pii node[N];
int mx[N], mi[N]; 
bool check(int L, int Lmi, int Lmx) {
    if (mi[Lmi] < L) {
        Lmi++;
    }
    if (mx[Lmx] < L) {
        Lmx++;
    }
    return node[mx[Lmx]].second - node[mi[Lmi]].second >= D;
}
signed main() {
    ios::sync_with_stdio(false);cin.tie(nullptr);
    cin >> n >> D;
    rep(i,1,n) {
        cin >> node[i].first >> node[i].second;
    }
    sort(node + 1,node + n + 1,[](pii a, pii b) {return a.first < b.first;});
    int ans = inf;
    int Lmx = 1, Lmi = 1, Rmx = 0, Rmi = 0;
    for (int L = 1, R = 1; R <= n; R++) {
        while (Rmx - Lmx + 1 >= 1 && node[R].second >= node[mx[Rmx]].second) {
            Rmx--;
        } 
        mx[++Rmx] = R;
        while (Rmi - Lmi + 1 >= 1 && node[R].second <= node[mi[Rmi]].second) {
            Rmi--;
        }
        mi[++Rmi] = R;
        while (R - L + 1 >= 2 && check(L+1, Lmi, Lmx)) {
            L++;
            if (mi[Lmi] < L) {
                Lmi++;
            }
            if (mx[Lmx] < L) {
                Lmx++;
            }
        }
        if (node[mx[Lmx]].second - node[mi[Lmi]].second >= D) {
            ans = min(ans, node[R].first - node[L].first);
        }
    }
    if (ans == inf) cout << -1 << endl;
    else cout << ans << endl;
    return 0;
}   /* created: 2024-10-31 20:30 author: Egrvigrf */
```