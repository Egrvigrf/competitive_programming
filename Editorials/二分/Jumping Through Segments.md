[Jumping Through Segments](https://codeforces.com/problemset/problem/1907/D)
波利卡普正在为一款游戏设计一个关卡。关卡由数线上的 $n$ 段组成，其中 $i$ -th 段从坐标为 $l_i$ 的点开始，到坐标为 $r_i$ 的点结束。

玩家从坐标为 $0$ 的点开始本关。在一次移动中，他们可以移动到距离不超过 $k$ 的任意一点。在完成 $i$ 次移动后，玩家必须在 $i$ 段内着陆，也就是在坐标为 $x$ 且 $l_i \le x \le r_i$ 的位置着陆。这意味着

- 第一次移动后，他们必须在第一段(从 $l_1$ 到 $r_1$ )内；
- 第二次移动后，它们必须位于第二个线段内(从 $l_2$ 到 $r_2$ )；
- ...
- 第 $n$ 步之后，它们必须位于第 $n$ 段之内(从 $l_n$ 到 $r_n$ )。

如果棋手按照上述规则下到了 $n$ 这一段，那么这关就算完成了。经过一番思考后，波利卡普意识到，在 $k$ 的某些值下是不可能完成这个关卡的。

波利卡普不希望这个关卡太简单，所以他要求你确定可以完成这个关卡的最小整数 $k$ 。


分析：
关键在于判断每一个mid是否能满足要求，维护一个区间，每次扩展区间取交集，如果为空集则不能满足。

```cpp
const int N = 2e5+1;
pair<int,int> p[N];
int n;
bool judge(int mid) {
    int l = 0,r = 0;
    _rep(i,1,n) {
        l = max(l-mid,p[i].first);
        r = min(r + mid,p[i].second);
        if(l > r) return false;
    }
    return true;
}
void solve() {
    cin >> n;
    _rep(i,1,n) cin>>p[i].first >> p[i].second;
    int l = 0,r = 1e9;
    int mi = 1e9;
    while (l <= r) {
        int mid = (l+r)/2;
        if(judge(mid)) {
            r = mid - 1;
            mi = min(mi,mid);
        } else {
            l = mid + 1;
        }
    }
    cout<<mi<<endl;
}
