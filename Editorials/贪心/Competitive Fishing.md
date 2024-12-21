#贪心
爱丽丝和鲍勃参加钓鱼比赛！他们总共钓到了 $n$ 条鱼，编号从 $1$ 到 $n$ （鱼越大，其指数越大）。这些鱼有些是爱丽丝钓到的，有些是鲍勃钓到的。

它们的表现将按以下方式进行评估。首先，我们将选择一个整数 $m$ ，然后将所有的鱼分成 $m$ 个**非空**组。。第一组应包含几条（至少一条）最小的鱼，第二组--几条（至少一条）次小的鱼，以此类推。每条鱼应正好属于一个组，每个组应是鱼类的连续子段。请注意，各组的编号顺序完全相同；例如，第二组的鱼不可能比第一组的鱼小，因为第一组包含最小的鱼。

然后，每条鱼将根据其组别索引分配一个值：第一组中每条鱼的值等于 $0$ ，第二组中每条鱼的值等于 $1$ ，以此类推。因此， $i$ \-3 组中的每条鱼得到的值等于 $(i-1)$ 。

每位参赛者的得分就是该参赛者钓到的所有鱼的总价值。

你希望鲍勃的得分比爱丽丝的得分至少多 $k$ 分。你至少要把鱼分成多少组$m$ ？如果不可能，你应该报告。

---

有一个trick:无后效性的累加。

选一个位置分组，后面每个位置的权值都增加1。
即，每选一个位置的净收益是：和后缀和的1,0数量的差值。

且这样分组无后效性，每次的净收益都是该位置后缀数组0,1的差值。

那么可以预先处理每个位置的0,1后缀和的差值，并放到优先队列（或者直接排序），依次取出判断即可。

---

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;

#define int ll
#define DBG

#define rep(i,a,b) for(int i=(a);i<=(b);i++)
#define rrep(i,b,a) for(int i=(b);i>=(a);i--)
#ifdef DBG
#define dbg(...) (cout<<":D ",_((char*)#__VA_ARGS__,__VA_ARGS__))
template<typename t> void _(char* p,t x){cout<<p<<'='<<x<<'\n';}
template<typename t,typename... a>
void _(char* p,t x,a... y){while(*p!=',')cout<<*p++;cout<<'='<<x<<',';_(p+1,y...);}
#else
#define dbg(...) ((void)0)
#endif

void solve() {
    int n,k;
    cin >> n >> k;
    string s;
    cin >> s;
    s = '6' + s;
    int cnt = 0;
    int c0[n+2],c1[n+2];
    c0[n+1] = c1[n+1] = 0;
    int mx = 0;
    int loc;
    for (int i = n; i >= 1; i--) {
        c0[i] = c0[i+1];
        c1[i] = c1[i+1];
        if (s[i] == '1') {
            cnt++;
            c1[i]++;
        } else {
            cnt--;
            c0[i]++;
        }
    }
    priority_queue<int> q;
    for (int i = 1; i <= n; i++) {
        q.push(c1[i+1] - c0[i+1]);
    }
    int sum = 0;
    int ans = 1;
    while (!q.empty()) {
        if (q.top() <= 0) {
            cout << -1 << endl;
            return;
        } else {
            sum += q.top();
        }
        ans++;
        if (sum >= k) {
            cout << ans << endl;
            return;
        }
        q.pop();
    }
    cout << -1 << endl;
}

signed main() {
    ios::sync_with_stdio(false);cin.tie(nullptr);
    int T; cin >> T;
    while (T--) solve();
    return 0;
}   /* created: 2024-12-02 23:00 author: Egrvigrf */
```