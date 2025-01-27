# 01背包
每种物品只能选择一次,设有$n$种物品，每种物品的价值为$w_i$，体积为$v_i$，背包的容量为$V$。
`ans[i][j]`代表有前$i$个物品，空间为j时的价值最大值。
取选第$i$个物品与不选第$i$个物品的较大值。

```c++
for (int i = 1; i <= n; i++) {
    for (int j = 1; j <= V; j++) {
        if (j < v[i]) { 
            ans[i][j] = ans[i - 1][j];
        } else { 
            ans[i][j] = max(ans[i - 1][j], ans[i - 1][j - v[i]] + w[i]); 
        }
    }
}
```

滚动数组压缩空间
**从后往前**更新
```c++
for(int i = 1; i <= n; i++) {
    for(int j = V; j >= v[i]; j--) {
        ans[j] = max(ans[j],ans[j-v[i]] + w[i]);
    }
}
```

- [P1048 [NOIP2005 普及组] 采药](https://www.luogu.com.cn/problem/P1048)

# 完全背包
每种物品可以取任意次。
转移方程和01背包类似
```c++
for (int i = 1; i <= n; i++) {
    for (int j = 1; j <= V; j++) {
        if (j < v[i]) { 
            ans[i][j] = ans[i - 1][j];
        } else { 
            ans[i][j] = max(ans[i - 1][j], ans[i][j - v[i]] + w[i]); 
        }
    }
}
```

滚动数组压缩空间
**从前往后**更新
```c++
for(int i = 1; i <= n; i++) {
    for(int j = v[i]; j <= V; j++) {
        ans[j] = max(ans[j],ans[j-v[i]] + w[i]);
    }
}
```

- [P1616 疯狂的采药](https://www.luogu.com.cn/problem/P1616)

# n维背包
有多个考虑因素
以二维01背包为例，增加条件背包最大承重为$M$，每一件物品的质量为$m_i$。
```c++
for (int i = 1; i <= n; i++)//放置第i件物品
{
    for (int j = 1; j <= V; j++)//j为当前体积
    {
        for (int k = 1; k <= M; k++)//k为当前质量
        {
            if (j - v[i] < 0 || k - m[i] < 0) { //任意一种条件不满足就放不进去
                a[i][j][k] = a[i - 1][j][k];
            } else {
                a[i][j][k] = max(a[i - 1][j][k], a[i - 1][j - v[i]][k - m[i]] + c[i]);
            }
        }
    }
}
```

滚动数组压缩空间
```c++
for (int i = 1; i <= n; i++) {
    for (int j = V; j >= v[i]; j--) { // j为当前体积
        for (int k = M; k >= m[i]; k--) { // k为当前质量
            b[j][k] = max(b[j][k], b[j - v[i]][k - m[i]] + c[i]);
        }
    }
}
```
- [P1507 NASA的食物计划](https://www.luogu.com.cn/problem/P1507)

# 分组背包
[通天之分组背包](https://www.luogu.com.cn/problem/P1757)
每个物品属于一个组，每组物品只能选一个
转换为0-1背包，对于一组内的每个物品，枚举选哪个或者不选的最大值


```cpp
const int N = 1010;
struct node {
    int w,v,id;
} a[N];
ll dp[N][N];
int main() {
    ios::sync_with_stdio(false); cin.tie(nullptr);
    int m,n;
    cin >> m >> n;
    for(int i = 1; i <= n; i++) {
        cin >> a[i].w >> a[i].v >> a[i].id;
    }
    sort(a+1,a+n+1,[](node x,node y) { return x.id < y.id;});
    int team = 1;
    for(int i = 1; i < n; i++) {
        if(a[i].id != a[i+1].id) team++; 
    }
    for(int i = 0; i <= team; i++) {
        for(int j = 0; j <= m; j++) {
            dp[i][j] = 0;
        }
    }
    for(int st = 1,ed = 2,i = 1; st <= n && i <= team; i++) {
        while(ed <= n && a[ed].id == a[st].id) {
            ed++;
        }
        for(int j = 1; j <= m; j++) {
            dp[i][j] = dp[i-1][j];
            for(int k = st; k < ed; k++) {
                if(j >= a[k].w) {
                    dp[i][j] = max(dp[i][j], dp[i - 1][j - a[k].w] + a[k].v);
                }
            }
        }
        st = ed++;
    }
    cout << dp[team][m]<<endl;
    return 0;
}   /* created: 2024-09-27 19:44 author: Egrvigrf */
```

## 空间压缩
```cpp
const int N = 1010;
struct node {
    int w,v,id;
} a[N];
ll dp2[N];
int main() {
    ios::sync_with_stdio(false); cin.tie(nullptr);
    int m,n;
    cin >> m >> n;
    for(int i = 1; i <= n; i++) {
        cin >> a[i].w >> a[i].v >> a[i].id;
    }
    sort(a+1,a+n+1,[](node x,node y) { return x.id < y.id;});
    int team = 1;
    for(int i = 1; i < n; i++) {
        if(a[i].id != a[i+1].id) team++; 
    }
    for(int i = 0; i <= m; i++) {
        dp2[i] = 0;
    }
    for (int st = 1, ed = 2, i = 1; st <= n && i <= team; i++) {
        while (ed <= n && a[ed].id == a[st].id) {
            ed++;
        }
        for (int j = m; j >= 1; j--) {
            for (int k = st; k < ed; k++) {
                if (j >= a[k].w) {
                    dp2[j] = max(dp2[j], dp2[j - a[k].w] + a[k].v);
                }
            }
        }
        st = ed++;
    }
    cout<<dp2[m]<<endl;
    return 0;
}   /* created: 2024-09-27 19:44 author: Egrvigrf */
```

# 多重背包 二进制优化
[P1776 宝物筛选](https://www.luogu.com.cn/problem/P1776)
时间复杂度O(背包容量\*log物品总数)
打包成多组后跑一遍0-1背包
```cpp
const int N = 4e4 + 10;
int dp[N];
int v[N];
int w[N];
int main() {
    ios::sync_with_stdio(false); cin.tie(nullptr);
    int n,W;
    cin >> n >> W;
    int cnt = 1;
    for(int i = 1; i <= n; i++) {
        int v0,w0,m0;
        cin >> v0 >> w0 >> m0;
        int k = 1;
        while(k <= m0) {
            w[cnt] = w0*k;
            v[cnt++] = v0*k;    
            m0 -= k;
            k *= 2;
        }
        if(m0 > 0) {
            w[cnt] = m0 * w0;
            v[cnt++] = m0 * v0;
        }        
    }
    for(int i = 0; i < cnt; i++) dp[i] = 0;
    for(int i = 1; i < cnt; i++) {
        for(int j = W; j >= w[i]; j--) {
            dp[j] = max(dp[j],dp[j-w[i]] + v[i]);
        }
    }
    cout<<dp[W]<<endl;
    return 0;
}   /* created: 2024-09-27 20:57 author: Egrvigrf */
```

#  混合背包
[# P1833 樱花](https://www.luogu.com.cn/problem/P1833)
里面的物品可以选无限次也可以选k次
组合一下多重背包和完全背包
```cpp
const int N = 1e4 + 10;
int dp[N];
const int M = 1e6;
int w[M];
int v[M];
bool complete[M];
int main() {
    ios::sync_with_stdio(false); cin.tie(nullptr);
    string s1, s2;
    int n;
    cin >> s1 >> s2 >> n;
    int W = conv(s1, s2);
    int cnt = 1;
    for (int i = 1; i <= n; i++) {
        int w0, v0, p0;
        cin >> w0 >> v0 >> p0;
        if (p0 == 0) {
            complete[cnt] = true;
            w[cnt] = w0;
            v[cnt++] = v0;
        } else {
            int k = 1;
            while (k <= p0) {
                w[cnt] = k * w0;
                v[cnt++] = k * v0;
                p0 -= k;
                k *= 2;
            }
            if (p0 > 0) {
                w[cnt] = p0 * w0;
                v[cnt++] = p0 * v0;
            }
        }
    }
    for (int i = 1; i < cnt; i++) {
        if(complete[i]) {
            for(int j = w[i]; j <= W; j++) {
                dp[j] = max(dp[j], dp[j - w[i]] + v[i]);
            }
        } else {
            for (int j = W; j >= w[i]; j--) {
                dp[j] = max(dp[j], dp[j - w[i]] + v[i]);
            }
        }
    }
    cout << dp[W] << endl;
    return 0;
}   /* created: 2024-09-28 20:48 author: Egrvigrf */
```

# 有依赖的背包
[金明的预算方案](https://www.luogu.com.cn/problem/P1064)
枚举可能的附件选择情况并转化为0-1背包，一个主键如果有k个附件则枚举2^k次

```cpp
const int N = 350000;
const int M = 65;
int dp[M][N];
int king[M];
int v[M];
int cost[M];
int fans[M];
int follow[M][2];
int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
    int n, m;
    cin >> n >> m;
    for (int i = 1; i <= m; i++) {
        int co, p, q;
        cin >> co >> p >> q;
        v[i] = co * p;
        cost[i] = co;
        king[i] = q;
        if (q) {
            follow[q][fans[q]++] = i; 
        }
    }
    int p = 0;
    for (int i = 1; i <= m; i++) {
        if (king[i] != 0) continue;
        int p1 = (fans[i] >= 1 ? follow[i][0] : -1);
        int p2 = (fans[i] >= 2 ? follow[i][1] : -1);
        for (int j = 0; j <= n; j++) {
            dp[i][j] = dp[p][j]; // 不选主件
            if (j - cost[i] >= 0) { //主
                dp[i][j] = max(dp[i][j], dp[p][j - cost[i]] + v[i]);
            }
            if (p1 != -1 && j - cost[i] - cost[p1] >= 0) {
                dp[i][j] = max(dp[i][j], dp[p][j - cost[i] - cost[p1]] + v[i] + v[p1]);
            }
            if (p2 != -1 && j - cost[i] - cost[p2] >= 0) {
                dp[i][j] = max(dp[i][j], dp[p][j - cost[i] - cost[p2]] + v[i] + v[p2]);
            }
            if (p1 != -1 && p2 != -1 && j - cost[i] - cost[p1] - cost[p2] >= 0) {
                dp[i][j] = max(dp[i][j], dp[p][j - cost[i] - cost[p1] - cost[p2]] + v[i] + v[p1] + v[p2]);
            }
        }
        p = i;
    }
    cout<<dp[p][n];
    return 0;
}
```