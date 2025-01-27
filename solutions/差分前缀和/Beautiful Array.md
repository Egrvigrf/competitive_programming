[Beautiful Array](https://codeforces.com/contest/1986/problem/E)
给你一个整数数组 $a_1, a_2, \ldots, a_n$ 和一个整数 $k$ 。您需要用最少的运算量使数组漂亮。

在进行操作前，可以随意对数组元素进行洗牌。对于一个操作，您可以执行以下操作：

- 选择一个索引 $1 \leq i \leq n$，
- 生成 $a_i = a_i + k$。

如果 $b_i = b_{n - i + 1}$ 为所有 $1 \leq i \leq n$ 的数组 $b_1, b_2, \ldots, b_n$ ，则数组 $b_1, b_2, \ldots, b_n$ 是美丽的。

求使数组美丽所需的最小运算次数，或报告不可能。

分析：
取模k相同的数分在同一组，元素数量为偶数的组排序后相邻求值，元素数量为奇数个的组最多存在一个。
如果存在一组元素数量为奇数，则需要删除一个元素（放在中间不计算，相当于删除），求前缀和，后缀和，遍历求最小值。
仅仅求前缀和或者是后缀和都是不行的，使用前缀和加后缀和完美解决。
```c++
void solve() {
    map<int, vector<int>> mp;
    int n, k;
    cin >> n >> k;
    int x;
    _rep(i, 1, n) {
        cin >> x;
        mp[x % k].push_back(x);
    }
    bool fst = true;
    int ans = 0;
    for (auto& [key, v] : mp) {
        if (v.size() % 2 == 0) {
            sort(all(v));
            for (int i = 1; i < v.size(); i += 2) {
                if (v[i] - v[i - 1])
                    ans += (v[i] - v[i - 1]) / k;
            }
        } else {
            if (fst) {
                fst = false;
                sort(all(v));
                if (v.size() == 1) continue;
                else {
                    vector<ll> pre(v.size());
                    vector<ll> suf(v.size());
                    pre[0] = pre[1] = v[1] - v[0];
                    suf[v.size()-1] = suf[v.size()-2] = v[v.size()-1] - v[v.size()-2];
                    for(int i = 3; i < v.size(); i += 2) {
                        pre[i-1] = pre[i] = v[i] - v[i-1] + pre[i-2];
                    }
                    for(int i = v.size()-3; i > 0; i -= 2) {
                        suf[i-1] = suf[i] = v[i] - v[i-1] + suf[i+1];
                    }
                    ll m = inf;
                    int loc = 2;
                    for (int i = 2; i < v.size()-1; i += 2) {
                        if (pre[i-1] + suf[i+1] < m) {
                            m = pre[i-1] + suf[i+1];
                            loc = i;
                        }
                    }
                    if(suf[1] < m) { m = suf[1],loc = 0; }
                    if(pre[v.size()-2] < m) { loc = v.size()-1; }
                    v.erase(v.begin() + loc);
                    for (int i = 1; i < v.size(); i += 2) {
                        if (v[i] - v[i - 1])
                            ans += (v[i] - v[i - 1]) / k;       
                    }
                }
            } else {
                cout << -1 << endl;
                return;
            }
        }
    }
    cout << ans << endl;
}
```
