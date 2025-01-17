# 杂项
## login

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
//#define int ll

#define dbg(...) _((char*)#__VA_ARGS__,__VA_ARGS__)
template<typename t> void _(char* p,t x){cout<<p<<'='<<x<<'\n';}
template<typename t,typename... a>
void _(char* p,t x,a... y){while(*p!=',')cout<<*p++;cout<<'='<<x<<',';_(p+1,y...);}

void solve() {
    
}

signed main() {
    cin.tie(nullptr)->ios::sync_with_stdio(false);
    int T = 1;
    cin >> T;
    while (T--) {
       solve();
    }
    return 0;
} 
```

## 对拍

输入输出重定向  
```cpp
// wa.cpp, 存放待寻找错误的代码
freopen("rd.txt","r",stdin);
freopen("wa.out","w",stdout);

// ac.cpp, 存放暴力或正确的代码
freopen("rd.txt","r",stdin);
freopen("ac.out","w",stdout);

// rd.cpp
freopen("rd.txt", "w", stdout);
```

随机数生成  
```cpp
mt19937 rnd(chrono::steady_clock::now().time_since_epoch().count());
int r(int a, int b) {
    return rnd() % (b - a + 1) + a;
}
```

对拍器  
```cpp
#include<bits/stdc++.h>
using namespace std;
int main() {
    int i=1;
    int n = 10;
    while (i <= n) { //一直循环，直到找到不一样的数据
        // cout<<i<<endl;
        system("rd.exe");
        system("wa.exe");
        system("ac.exe");
        if (system("fc ac.txt wa.txt")) { //当 fc 返回 1 时，说明这时数据不一样
            cout << "WA" << endl;
            return 0; 
        } 		 
        i++;                     
    }
    cout << n << "组数据"<< "OK" <<'\n';
    return 0;
}
```
## 快读

```cpp
#include <bits/stdc++.h>
using namespace std;
inline int read(){
    int s=0,w=1;
    char ch=getchar();
    while(ch<'0'||ch>'9'){if(ch=='-'){w=-1;}ch=getchar();}
    while(ch>='0'&&ch<='9'){s=s*10+ch-'0';ch=getchar();}
    return s*w;
}
inline void write(int x){
    if(x<0){putchar('-');x=-x;}
    if(x>9){write(x/10);}
    putchar(x%10+'0');
}
#define TIME  (1.0 * clock() / CLOCKS_PER_SEC)
#define file(name)  if (fopen(name".inp", "r")) { freopen(name".inp", "r", stdin); freopen(name".out", "w", stdout); }
int main()
{
    //int n = read();
    for(int i = 1; i <= 100000; i++)
        cout<<i;
    cerr << "Time elapsed: " << TIME << " s.\n";
    return 0;
}
```

## int128

```cpp
using i128 = __int128_t;
auto& operator>>(istream& it, __int128_t& j) {
    string val;
    it >> val;
    reverse(val.begin(), val.end());
    __int128_t ans = 0;
    bool f = 0;
    char c = val.back();
    val.pop_back();
    for (; c < '0' || c > '9'; c = val.back(), val.pop_back()) {
        if (c == '-') {
            f = 1;
        }
    }
    for (; c >= '0' && c <= '9'; c = val.back(), val.pop_back()) {
        ans = ans * 10 + c - '0';
    }
    j = f ? -ans : ans;
    return it;
}
auto& operator<<(ostream& os, const __int128_t& j) {
    string ans;
    function<void(__int128_t)> write = [&](__int128_t x) {
        if (x < 0) ans += '-', x = -x;
        if (x > 9) write(x / 10);
        ans += x % 10 + '0';
        };
    write(j);
    return os << ans;
}
```


## 一些STL

对 vector 进行去重  
`sort(vec.begin(), vec.end());`
`vec.erase(unique(vec.begin(), vec.end()), vec.end());`
//或者  
`sort(vec.begin(), vec.end());`
`vec.resize(unique(vec.begin(), vec.end()) - vec.begin());`

对于 unique 函数来说，要求元素必须是相邻的才能进行去重操作，而且它只会去除相邻的重复元素。  
因此，在使用 unique 去重之前，通常需要先对容器进行排序，以确保相同的元素都相邻排列，才能正确去重  

## 前缀和
预处理后可以用O(1)的时间复杂度求一个区间的值  
能显著降低查询时间复杂度  

### 一维
(从原数组)构建  
```cpp
a[0] = 0;
for(int i = 1;i <= n; i++) {
	a[i] += a[i-1];
}
```
查询\[l,r]区间的和
`a[r] - a[l-1]` 
``
### 二维
求一个矩形区域的所有值的和  
(从原数组)构建  
```cpp
for(int i = 0; i <= m; i++) sum[0][i] = 0;
for(int i = 0; i <= n; i++) sum[i][0] = 0;
for(int i = 1; i <= n; i++) {
	for(int j = 1; i <= m; j++) {
		sum[i][j] += sum[i-1][j] + sum[i][j-1] - sum[i-1][j-1];
	}
}
```

查询(x1,y1)和(x2,y2)包裹的矩形区域内的和  
```cpp
int query(int x1 ,int y1 ,int x2, int y2) {
    return sum[x2][y2] - sum[x2][y1-1] - sum[x1-1][y2] + sum[x1-1][y1-1];
}
```

## 差分

### 一维
不支持边操作边查询  
数组$a$在一个区间$[l,r]$上每个位置都增加相同的值$x$  
如果$a[i] = x$;  
含义是，无限远的数轴上从i位置(包括)开始，每个位置的值变化$x$  
可用差分数组标记  
```cpp
a[l] += x;
a[r+1] -= x;
```
求前缀和即可得到每一位的值  

### 等差序列差分  

s    d-s        0          0       ...    0     -e-d    e
s      d         d          d       ...    d      -e      0     
s    s+d    s+2d    s+3d    ...    e        0      0  

进行标记  
```cpp
void op(int l, int r, int s, int e,int d) {
    ans[l] += s;
    ans[l + 1] += d - s;
    ans[r + 1] += -e - d;
    ans[r + 2] += e;
}
```
求两次前缀和即可  

### 二维差分
$sum$数组在(x1,y1)和(x2,y2)包裹的矩形区域内每个sum\[i]\[j]的值增加v。  
如果`sum[x][y] = v`，那么大于等于$i >= x,j >= y$的位置的点所有点`sum[i][j]`的值都增加v  
```cpp
void add(int x1, int y1, int x2, int y2, int v) {
    sum[x1][y1] += v;
    sum[x2 + 1][y2 + 1] += v;
    sum[x2 + 1][y1] -= v;
    sum[x1][y2 + 1] -= v;
}
```
之后再求一遍二维前缀和就可以得到每个点的值  

## 二分
```cpp
while (l <= r) {
    int mid = (l + r) / 2;
    if (check(mid)) {
        r = mid - 1;
        ans = mid;
    } else {
        l = mid + 1;
    }
}
```

## 三分
# 图论

## 建图

### 链式前向星

有n个点，m条边（无向图开双倍）
cnt：边号
e\[cnt].to ：与第cnt条边相连的边  
e\[cnt].to ：第cnt条边的邻边  
e\[cnt].w  ：第cnt条边的权值  
head\[x]   ：点x的头边号  

```cpp
int id = 1;
int head[N]; 
int to[M];  
int nx[M]; 
int w[N];
//N是点的最大数量，M是边的最大数量，无向图记得开双倍
```
多组数据一定要初始化head和id  
to,nx,w数组由id控制，所以只要id重置为1即可  
head数组必须重置为0,因为判断根据0判断有无相邻节点

```cpp
memset(head,0,sizeof(head));
cnt = 1;
```

添加边  
```cpp
void addedge(int x,int y,int v) {
    w[id] = v; 
    to[id] = y;
    nx[id] = head[x]; 
    head[x] = id++; //添加的过程不断更新链表的头部，对于一个节点，最后添加的边是链表头。
}
```

遍历和点x所连接的所有边  
```cpp
for(int i = head[x]; i > 0; i = nx[i]) {
    
}
```

### 邻接表
```cpp
const int N = 2e5+1;
vector<pair<int,int> > adj[N];
void addedge(int x,int y,int v) {
    adj[x].push_back(make_pair(y,v));
    //adj[y].push_back(make_pair(x,v));
}
for(auto& i : adj[x]) {
    int t = i.first;
}
```
## Dijkstra
```cpp
#include <bits/stdc++.h>
using namespace std;
const long long inf = 2147483647;
struct edge {
    int to, next, w;
} e[1001000];
int cnt = 0;
int head[1001000];
void addedge(int x, int y, int v) {
    e[++cnt].next = head[x];
    e[cnt].to = y;
    e[cnt].w = v;
    head[x] = cnt;
}
struct Node {
    int dis;
    int id;
    bool operator <(const Node& b)const { //重载比较运算符，可以直接放进优先队列
        return dis > b.dis;
    }
};
int main() {
    ios::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);//数据多加快读
    int n, m, s; // 三个整数n,m,s分别表示点的个数、有向边的个数、出发点的编号
    cin >> n >> m >> s;
    long long dist[n + 1];
    bool vis[n + 1];
    for (int i = 1; i <= n; i++) {
        dist[i] = inf;
        vis[i] = false;
    }
    dist[s] = 0;
    /*使用前向星*/
    for (int i = 1; i <= m; i++) {
        int begin, end, v;
        cin >> begin >> end >> v;
        addedge(begin, end, v);
    }
    priority_queue<Node> q;
    q.push((Node) {0,s});
    while (!q.empty()) {
        Node temp = q.top();
        q.pop();
        if(vis[temp.id]) continue;
        vis[temp.id] = true;
        int cur = temp.id;
        for (int j = head[cur]; j != 0; j = e[j].next) {
            int to = e[j].to;
            if (!vis[to] && dist[cur] + e[j].w < dist[to]) {
                dist[to] = dist[cur] + e[j].w;
                q.push((Node){dist[to],to});
            }
        }
    }
    for (int i = 1; i <= n; i++) 
        cout << dist[i] << " ";
    return 0;
}

```

## Floyd
全源最短路  
时间复杂度O(N^3)  
空间复杂度O(N^2)  
能有负边不能有负环  

```cpp
for(int k = 1; k <= n; k++) { //途径k
    for(int i = 1; i <= n; i++) {
        for(int j = 1; j <= n; j++) {
            dis[i][j] = min(dis[i][j],dis[i][k] + dis[k][j]);
        }
    }
}
```

## SPFA
```cpp
int dis[MAXN];//dis[i]=源点s->i最短路径
bool vis[MAXN];//vis[i]表示i是否在队列
void spfa(int s) {
    for(int i=1;i<=MAXN;i++){//初始化
        dis[i]=inf;
        vis[i]=false;
    }
    dis[s]=0;//源点到自身距离为0
    queue <int> q;//使用C++自带队列
    q.push(s);//源点入队
    vis[s]=true;
    while(!q.empty()){//若队列不为空
        int cur=q.front();//取出队首元素弹出
        q.pop();
        vis[u]=true;
        for(int i=head[cur];~i;i=nx[i]){//遍历
            int to=ed[i].to;//
            if(dis[cur]+ed[i].w<dis[cur]){//如果不满足三角形不等式
                dis[to]=dis[cur]+ed[i].w;//更新答案
                if(!vis[v]){//如果终点不在队列
                    q.push(to);//入队
                    vis[to]=true;
                }
            }
        }
    }
}
```



## 拓扑排序
入度删除法，入度数为0的节点先全部入队。 
然后依次出队，出队后相当于在DAG中删除与之相连的节点的入度,如果有新的节点入度  
删除后变成0，入队。 
如果统计的出队的总数小于点的数量，则存在环。 

```cpp
queue<int> q;
for (int i = 1; i <= n; i++) {
    if (deg[i] == 0) {
        q.push(i);
    }
}
while (q.size()) {
    int t = q.front();
    q.pop();
    cout << t << " ";
    for (int i = head[t]; i > 0; i = nx[i]) {
        int tt = to[i];
        if (deg[tt] == 0) continue;
        deg[tt]--;
        if (deg[tt] == 0) {
            q.push(tt);
        }
    }
}
```

## 最小生成树

```cpp
const int MAXN = 2e5 + 1;
struct Node {
    int x,y,v;
} a[MAXN];
int fa[5001];
int find(int x) {
    if(fa[x] != x) {
        x = find(fa[x]);
    }
    return fa[x];
}
bool merge(int x,int y) {
    int fx = find(x),fy = find(y);
    if(fx != fy) {
        fa[fx] = fy;
        return true;
    } else {
        return false;
    }
}
int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
    int n,m;
    cin >> n >> m;
    _rep(i,1,m) {
        cin >> a[i].x >> a[i].y >> a[i].v;
    }
    _rep(i,1,n) {
        fa[i] = i;
    }
    sort(a+1,a+m+1,[](Node a,Node b) {return a.v < b.v;});
    int cnt = 0;
    int ans = 0;
    _rep(i,1,m) {
        if(merge(a[i].x,a[i].y)) {
            cnt++;
            ans += a[i].v;
        }
    }
    if(cnt == n - 1) {
        cout<<ans;
    } else {
        cout<<"orz";
    }
    cout<<endl;
    return 0;
}
```

# 字符串

## 字符串哈希

### 自然溢出
```cpp
mt19937_64 rng(std::chrono::steady_clock::now().time_since_epoch().count());
int base = rng();
ll hash_(string& s) {
    ll ans = 0;
    for(int i = 0; i < s.size(); i++) {
        ans = ans*base + s[i] - 'a' + 1;
    }
    return ans;
}
```

常用base: 31、131、1313、13131、131313  
质数：433、499、599、1000000007  
得到子串哈希O(1)  
比较一个字符串中的两个子串是否相等的时间复杂度能从O(n)降低到O(1)  

```cpp
mt19937_64 rng(std::chrono::steady_clock::now().time_since_epoch().count());
int base = rng();
ll hash_[n+1];
ll power[n+1];
for(int i = 0; i <= s.size(); i++) {
    power[i] = power[i-1]*base;
    hash_[i] = hash_[i-1]*base + s[i] - 'a' + 1;
}
ll hash1 = hash_[r] - hash_[l]*power[r-l+1];

```

## KMP

字符串匹配算法  
求字符串$s1$中匹配的$s2$字符串  
如果暴力匹配最糟糕时间复杂度$O(n*m)$,用KMP可以降低到$O(n+m)$  
构建一个nx数组存放每一位的前一位的除本身外的字串的最长前缀后缀匹配数量  

```cpp
vector<int> nx(m + 1, 0);
int j = 0;
for(int i = 2,i <= m; i++) {
    while (j > 0 && s2[i - 1] != s2[j]) {
        j = nx[j];
    }
    if (s2[i - 1] == s2[j]) {
        j++;
    }
    nx[i] = j;
}
int x = 0, y = 0;
while (x < n) {
    if (s1[x] == s2[y]) {
        x++, y++;
    } else if (y > 0) {
        y = nx[y];
    } else {
        x++;
    }
    if (y == m) {
        //cout << x - y + 1 << endl;
        //y = nx[y];
    }
}
```

# 数论
## GCD
```cpp
int gcd(int a, int b) {
    return a % b == 0 ? b : gcd(b, a % b);
}
int lcm(int a,int b) {
	return a / gcd(a, b) * b;
}
```
## 快速幂

```cpp
const int mod = 1e9 + 10;
int ksm(int a,int b) {
    int ans = 1;
    while (b > 0) {
        if (b & 1) {
            ans = ans * a % mod;
        }
        a = a*a%mod;
        b >>= 1;
    }
    return ans;
}
```

## 逆元
费马小定理求逆元，要求b和mod互质  
// b的逆元 = ksm(b,mod-2)  
// (a / b) % mod = (a * b的逆元) % mod   

递推求逆元
```cpp
inv[1] = 1;
for (int i = 2; i < mod; ++i)
    inv[i] = (mod - mod / i) * inv[mod % i] % mod;
```


### 卢卡斯定理
当n,m很大时求组合数  

$$
\binom{n}{m} = \binom{m \mod p}{n \mod p} \cdot \binom{\lfloor \frac{m}{p} \rfloor}{\lfloor \frac{n}{p} \rfloor} \quad (\text{mod } p)  
$$

```cpp
const int N = 100000;  // 定义常量 N 的大小
int fac[N + 5], inv[N + 5];  // 用于存储阶乘和阶乘的逆元
// 计算 a 的 b 次方模 mod
int mod = 1e9 + 7;
int ksm(int a, int b) {
    int res = 1;
    while (b) {
        if (b & 1) res = (res * a) % mod;
        a = (a * a) % mod;
        b >>= 1;
    }
    return res;
}

// 预处理前n阶乘和阶乘逆元
void pre(int n) {
    fac[0] = 1;
    for (int i = 1; i <= n; i++) {
        fac[i] = (fac[i - 1] * i) % mod;  // 阶乘
    }
    inv[n] = ksm(fac[n], mod - 2);  // 逆元（费马小定理）
    for (int i = n - 1; i >= 0; i--) {
        inv[i] = (inv[i + 1] * (i + 1)) % mod;  // 逆元
    }
}

int C(int n, int m) {
    if (m > n) return 0;  // 不合法情况
    return (fac[n] * inv[m] % mod * inv[n - m] % mod);
}

int Lucas(int n, int m) {
    if (m == 0) return 1;  
    return (C(n % mod, m % mod) * Lucas(n / mod, m / mod) % mod);
}
```


## 矩阵快速幂
类似快速幂，初始I等于单位矩阵  
```cpp
const int Mod = 1000000007;
struct Matrix {
    long long c[101][101];
} A, I;
long long n, k;
Matrix operator*(const Matrix& x, const Matrix& y) {
    Matrix a;
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= n; j++)
            a.c[i][j] = 0;
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= n; j++)
            for (int k = 1; k <= n; k++) {
                a.c[i][j] += x.c[i][k] * y.c[k][j] % Mod;
                a.c[i][j] %= Mod;
            }
    return a;
}

signed main() {
    ios::sync_with_stdio(false);cin.tie(nullptr);
    cin >> n >> k;
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= n; j++)
            cin >> A.c[i][j];
    for (int i = 1; i <= n; i++)
        I.c[i][i] = 1;
    while (k > 0) {
        if (k & 1) I = I * A;
        A = A * A;
        k = k >> 1;
    }
    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++)
            cout << I.c[i][j] << ' ';
        cout << endl;
    }
    return 0;
}   
```
## 素数筛
### 埃氏筛
先假设假设1-n所有数都是素数  
从2开始筛  
小于调和级数O(n*log(n))  
时间复杂度O(n*log(logn))  
```cpp
ll countPrimes(ll n) {
    bool vis[n + 1];
    for (int i = 0; i <= n; i++) vis[i] = false;
    for (ll i = 2; i <= n; i++) {
        if (!vis[i]) {
            for (ll j = i * i; j <= n; j += i) {
                vis[j] = true;
            }
        }
    }
    ll cnt = 0;
    for (ll i = 2; i <= n; i++) {
        if (!vis[i]) {
            cnt++;
        }
    }
    return cnt;
}

int gcd(int a, int b) {
    return a % b == 0 ? b : gcd(b, a % b);
}


```


# 数据结构

## 并查集

```cpp
struct DSU {
    vector<int> f, siz;
    
    DSU() {}
    DSU(int n) {
        init(n);
    }
    
    void init(int n) {
        f.resize(n+1);
        iota(f.begin(), f.end(), 0);
        siz.assign(n+1, 1);
    }
    
    int find(int x) {
        while (x != f[x]) {
            x = f[x] = f[f[x]];
        }
        /*
        if (x != f[x]) {
			x = find(f[x]);  
        }
        */
        return x;
    }
    
    bool same(int x, int y) {
        return find(x) == find(y);
    }
    
    bool merge(int x, int y) {
        x = find(x);
        y = find(y);
        if (x == y) {
            return false;
        }
        siz[x] += siz[y];
        f[y] = x;
        return true;
    }
    
    int size(int x) {
        return siz[find(x)];
    }
};
```
# 单调栈
可以求序列中左边/右边第一大/小的元素位置,出栈/入栈可以获得信息  
时间复杂度O(n)  
单调和严格单调有区别  
单调递减栈维护数组中一个数左右两边离他最近的大于（等于）它的值  
单调递增栈维护数组中一个数左右两边离他最近的小于它的值  

after\[i] 表示离 a\[i]最近的右边的 > a\[i] 的元素  
```cpp
for (int i = 1; i <= n; i++) {
    while (sz >= 1 && a[i] > a[stk[sz]]) {
        after[stk[sz--]] = i;
    }
    stk[++sz] = i;
}
while (sz >= 1) {
    after[stk[sz--]] = 0; // 0 标记不存在
}
```

分别求左边/右边  
```cpp
int sz = 0;
for (int i = 0; i < n; i++) {
    while (sz && h[i] <= h[stk[sz]]) {
        pre[stk[sz--]] = (sz == 1 ? -1 : stk[sz - 1]);
    }
    stk[++sz] = i;
}
while (sz >= 1) {
    pre[stk[sz--]] = (sz == 1 ? -1 : stk[sz - 1]);
}
sz = 0;
for (int i = 0; i < n; i++) {
    while (sz && h[i] < h[stk[sz]]) {
        nx[stk[sz--]] = i;
    }
    stk[++sz] = i;
}
while (sz >= 1) {
    nx[stk[sz--]] = n;
}
```



维护左/右信息   
```cpp
for (int i = 1; i <= n; i++) {
    while (sz >= 1 && a[i] <= a[stk[sz]]) {
        before[stk[sz]] = (sz == 1 ? 0 : stk[sz - 1]);
        after[stk[sz--]] = i;
    }
    stk[++sz] = i;
}
while (sz >= 1) {
    before[stk[sz]] = (sz == 1 ? 0 : stk[sz - 1]);
    after[stk[sz--]] = 0;
}
for (int i = 1; i <= n; i++) {
    while (after[i] != 0 && a[i] == a[after[i]]) {
        after[i] = after[after[i]];
    }
}
```


## 单调队列

维护区间最值，时间复杂度O(n)  
单调递减维护区间最大值可能性  
入队时，当一个元素的下标更加大且值 >= , 优化队内元素，R指针回退  
每次取取a\[q\[L]] 即是最大值  
出队时判断队首L元素的是否满足在区间内  


求区间长度为k的最大值  

```cpp
int L = 1, R = 0; // [L,R]
for (int i = 1; i <= n; i++) {
    while (R - L + 1 >= 1 && a[i] < a[qmini[R]]) {
        R--;
    }
    qmini[++R] = i;
    if (i > k && i - k >= qmini[L]) {
        L++;
    }
    if (i >= k) cout << a[qmini[L]] << " ";
}
```

## 树状数组

```cpp
template <typename T>
struct Fenwick {
    int n;
    vector<T> a;
    
    Fenwick(int n_ = 0) {
        init(n_);
    }
    
    void init(int n_) {
        n = n_;
        a.assign(n + 1, T{}); // n + 1 大小，索引从 1 开始
    }
    
    void add(int x, const T &v) {
        for (int i = x; i <= n; i += i & -i) {
            a[i] = a[i] + v; 
        }
    }
    
    T sum(int x) {
        T ans{};
        for (int i = x; i > 0; i -= i & -i) {
            ans = ans + a[i]; 
        }
        return ans;
    }
    
    T rangeSum(int l, int r) {
        return sum(r) - sum(l - 1); // [l, r] 闭区间
    }
    
    int select(const T &k) { // 从一个前缀和数组中找到一个位置 `x`，使得从数组开头到 `x` 的前缀和刚好大于或等于给定的值 `k`
        int x = 0;
        T cur{};
        for (int i = 1 << __lg(n); i; i /= 2) {
            if (x + i <= n && cur + a[x + i] <= k) { // 1 索引操作
                x += i;
                cur = cur + a[x];
            }
        }
        return x;
    }
};
```

RQM && ST
```cpp
int st[N][__lg(N) + 1];
int lg[N];
void solve() {
    int n,m;
    cin >> n >> m;
    for (int i = 1; i <= n; i++) {
        cin >> st[i][0];
    }
    lg[1] = 0;
    for (int i = 2; i <= n; i++) {
        lg[i] = lg[i >> 1] + 1;
    }
    for (int j = 1; j <= lg[n]; j++) {
        for (int i = 1; i+(1<<(j-1)) <= n; i++) {
            st[i][j] = max(st[i][j-1],st[i+(1<<(j-1))][j-1]);
        } 
    }
    while(m--) {
        int l, r;
        cin >> l >> r;
        int k = lg[r-l+1];
        cout << max(st[l][k],st[r-(1<<k)+1][k]) << "\n";
    }
}
```
## 线段树
#### 懒标记
新建一下数组用于存放懒信息  
如果能不更新就不更新，必须更新时只往下更新一层。 
为什么懒？只有用到当前节点所覆盖的区间时，才下发懒标记  
如何下发，分别清算左，右区间，再分别给左右区间打上懒标记，自身懒标记清除。 
为什么效率高？可能多次的修改只需要传递一次，优化常数，（一次传递包括了多次修改） 

#### 线段树常见方法一览
void build(l, r, i)  : 建树  
void up(i..) : 根据子范围的查询信息，把父范围的查询信息更新正确  
void down(i..) : 父范围的懒信息，往下只下发一层，给左范围、右范围，然后父范围的懒信息清空  
void apply(): 当前范围被修改任务全覆盖时 或 父范围发下来的懒更新时，信息数组们如何修改  
void midify(jobl, jobr, jobv, l, r, i) : 范围上修改维护信息  
int query(jobl, jobr, l, r, i) : 范围上的信息查询任务  

#### 1.懒标记线段树维护简单区间信息
根据要维护的信息修改Node和Tag结构体  
重载+运算符  

```cpp
struct LazySegmentTree {
    int n;
    vector<Node> tree;
    vector<Tag> tag;
    LazySegmentTree(const vector<Node>& a, int _n) :n(_n), tree(4 << __lg(n)), tag(4 << __lg(n)) {
        build(a, 1, 1, _n);
    }
    void up(int p) {
        tree[p] = tree[p << 1] + tree[p << 1 | 1];
    }
    void build(const vector<Node>& a, int p, int l, int r) {
        if (l == r) {
            tree[p] = a[l];
            return;
        }
        int m = (l + r) >> 1;
        build(a, p << 1, l, m);
        build(a, p << 1 | 1, m + 1, r);
        up(p);
    }
    void apply(int p, const Tag& v) {
        tree[p].apply(v);
        tag[p].apply(v);
    }
    void down(int p) {
        apply(p << 1, tag[p]);
        apply(p << 1 | 1, tag[p]);
        tag[p] = Tag();
    }
    void modify(int ml, int mr, Tag& v, int p, int l, int r) {
        if (ml <= l && r <= mr) {
            apply(p, v);
            return;
        }
        int m = (l + r) >> 1;
        down(p);
        if (ml <= m) modify(ml, mr, v, p << 1, l, m);
        if (mr > m) modify(ml, mr, v, p << 1 | 1, m + 1, r);
        up(p);
    }
    void modify(int ml ,int mr, Tag& v) {
        modify(ml, mr, v, 1, 1, n);
    }
    void query(int ql, int qr, int p, int l, int r, Node& res) {
        if (ql <= l && r <= qr) {
            res = res + tree[p];
            return;
        }
        int m = (l + r) >> 1;
        down(p);
        if (ql <= m) query(ql, qr, p << 1, l, m, res);
        if (qr > m) query(ql, qr, p << 1 | 1, m + 1, r, res);
    }
    Node query(int ql, int qr) {
        Node res;
        query(ql, qr, 1, 1, n, res);
        return res;
    }
};
```


[洛谷](https://www.luogu.com.cn/problem/P1253)
区间最值  
操作：区间加，区间重置  
```cpp
struct Tag {
    int addV, resetV;
    bool isreset;
    Tag() : addV(0), isreset(false) {}
    void apply(Tag t) {
        if (t.isreset) { 
            isreset = true;
            resetV = t.resetV;
            addV = 0; 
        }
        addV += t.addV;
    }
};
struct Node {
    ll sum, mx, mini, len;
    Node() :sum(0),len(1), mx(-inf), mini(inf) {}
    Node operator+ (const Node& b) const {
        Node t;
        t.len = len + b.len;
        t.sum = sum + b.sum;
        t.mx = max(mx, b.mx);
        t.mini = min(mini, b.mini);
        return t;
    }
    void apply(Tag t) {
        if(t.isreset) {
            sum = t.resetV * len;
            mx = t.resetV;
            mini = t.resetV;
        } 
        sum += t.addV * len;
        mx += t.addV;
        mini += t.addV;
    }
};
```

[洛谷](https://www.luogu.com.cn/problem/P3373)
维护区间和  
操作： 加，乘  
```cpp
int m;
struct Tag {
    int addV, mul;
    Tag() : addV(0), mul(1) {}
    void apply(Tag t) {
        addV = (addV * t.mul + t.addV) % m;
        mul = (mul * t.mul) % m;
    }
};
struct Node {
    ll sum, len;
    Node() :sum(0), len(1) {}
    Node operator+ (const Node& b) const {
        Node t;
        t.sum = sum + b.sum;
        t.len = len + b.len;
        return t;
    }
    void apply(Tag t) {
        sum = (sum * t.mul + t.addV * len) % m;
    }
};
```


# DP
## 背包DP

### 01背包
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

滚动数组压缩空间  
**从后往前**更新  
```c++
for(int i = 1; i <= n; i++) {
    for(int j = V; j >= v[i]; j--) {
        ans[j] = max(ans[j],ans[j-v[i]] + w[i]);
    }
}
```
### 完全背包
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


### n维背包
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


# 几何
## 点
```cpp
struct Point {
    double x, y;
    Point() : x(0), y(0) {}
    Point(double _x, double _y) : x(_x), y(_y) {}
    Point operator+(Point& p) { return { x + p.x, y + p.y }; }
    Point operator-(Point& p) { return { x - p.x, y - p.y }; }
    double operator*(Point& p) { return x * p.x + y * p.y; } //点积
    double operator^(Point& p) { return x * p.y - y * p.x; } //叉积
};
```

## 误差消除

```cpp
const double eps=1e-9;
int dcmp(double x){
    return (fabs(x)<=eps)?0:(x<0?-1:1);
}
```

## 直线
```cpp
struct Line{
	//ax+by+c=0
	double a,b,c;
	//u为直线上一点，v为方向向量
	Point u,v;
	Line(){}
	//两点确定的直线方程
	Line(Point p,Point q){
		a=p.y-q.y;b=q.x-p.x;c=p.x*q.y-q.x*p.y;
		//保证u、v两点逆时针排列
		if((p^q)<0) swap(p,q);
		u=p;v=q-p;
	}
};
```

## 点到直线的距离
```cpp
double disPL(Point u,Line l){
	double length;
	length = abs(l.a*u.x+l.b*u.y+l.c)/(sqrt(l.a*l.a+l.b*l.b));
	return length;
}
```

## 点在直线上的投影点
```cpp
point proPointLine(Point u,Line l){
	point v;
	double t=(-u.x*l.a-u.y*l.b-l.c)/(l.a*l.a+l.b*l.b);
	v.x=u.x+l.a*t;
	v.y=u.y+l.b*t;
	return v;
}
```
## 求两直线的交点
```cpp
Point itsLineLine(Line l1,Line l2){
	Point p;
	double k = l1.a*l2.b-l1.b*l2.a;
	p.x = -(l1.c*l2.b-l1.b*l2.c)/k;
	p.y = -(l1.a*l2.c-l1.c*l2.a)/k;
	return p;
}
```

## 求三角形面积
```cpp
//求三角形面积
double triarea(Point u,Point v,Point w){
	//叉积方法
	return abs((v-u)^(w-u))/2.0;
}
double triarea(double a,double b,double c){
	//海伦公式
	double p=(a+b+c)/2;
	return sqrt(p*(p-a)*(p-b)*(p-c));
}
```

## 求多边形的面积
```cpp
//求多边形的面积
double polygonArea(point *u,int size){
	double area=0;
	point begin=u[1];
	/*
	  由第一个点起始的顺序叉积，其中，点可以无序，
	  面积值为边之间连线的封闭部分，叉积能够计算容斥部分
	 */
	for(int i=3;i<=size;i++) area+=((u[i-1]-begin)^(u[i]-begin))/2;
	return area;
}
```
## 圆
```cpp
//圆结构
struct circle{
	//圆心
	point cc;
	//半径
	double radius;
};
//求三点所确定的圆
circle concyclic(point u,point v,point w){
	circle c;
	point o;
	double k=2*(v.x-u.x)*(w.y-v.y)-2*(v.y-u.y)*(w.x-v.x);
	o.x=(w.y-v.y)*(v.x*v.x+v.y*v.y-u.x*u.x-u.y*u.y)-(v.y-u.y)*(w.x*w.x+w.y*w.y-v.x*v.x-v.y*v.y);
	o.y=(v.x-u.x)*(w.x*w.x+w.y*w.y-v.x*v.x-v.y*v.y)-(w.x-v.x)*(v.x*v.x+v.y*v.y-u.x*u.x-u.y*u.y);
	o.x/=k;o.y/=k;
	c.cc=o;c.radius=disPointPoint(o,u);
	return c;
}
//求圆与直线的交点
vector<point> itsStrCir(line l,circle c){
	double k=l.u*l.v,a=norm(l.u),b=norm(l.v),r=c.radius;
	double d=k*k-b*b*(a*a-r*r);
	vector<point>ans;
	if(d==0) ans.push_back(l.u+l.v*(-k/(b*b)));
	else {
		ans.push_back(l.u+l.v*((-k+d)/(b*b)));
		ans.push_back(l.u+l.v*((-k-d)/(b*b)));
	}
	return ans;
}
//求两圆的交点
vector<point> itsCirCir(circle c1,circle c2){
	vector<point> ans;
	point o1=c1.cc,o2=c2.cc,a=o2-o1,b;
	b.x=a.y;b.y=-a.x;
	double r1=c1.radius,r2=c2.radius;
	double d=disPointPoint(o1,o2);
	double S=triarea(r1,r2,d);
	double h=2*S/d;
	double t=sqrt(r1*r1-h*h);
	//目标两点的中垂线与O1O2反向
	if(r1*r1+d*d<r2*r2) t=-t;
	//不能用半径和来判断，否则会漏掉内切的情况
	if(h==0) ans.push_back(o1+a*t/norm(a));
	else {
		ans.push_back(o1+a*t/norm(a)+b*h/norm(b));
		ans.push_back(o1+a*t/norm(a)-b*h/norm(b));
	}
	return ans;
}
//求一点与圆的切线
vector<line> tlPointCircle(point u,circle c){
	vector<line> ans;
	circle o;
	o.cc=(c.cc+u)/2;
	o.radius=disPointPoint(c.cc,u)/2;
	vector<point> p=itsCirCir(o,c);
	if(p.size()==1) {
		point v;
		v.x=(u-c.cc).y;v.y=-(u-c.cc).x;
		ans.push_back(line(u,u+v));
	}
	if(p.size()==2){
		ans.push_back(line(p[0],u));
		ans.push_back(line(p[1],u));
	}
	return ans;
}
//求两圆的公切线
vector<line> comTangent(circle c1,circle c2){
	vector<line> ans,q;
	int r1=c1.radius,r2=c2.radius;
	int d=disPointPoint(c1.cc,c2.cc);
	point u,v,a=c2.cc-c1.cc,t;
	if(r1==r2){
		u=c1.cc-c2.cc;
		v.x=u.y;v.y=-u.x;
		ans.push_back(line(c1.cc+v*r1/norm(v),c1.cc+v*r1/norm(v)+u));
		ans.push_back(line(c1.cc-v*r1/norm(v),c1.cc-v*r1/norm(v)+u));
	}
	else {
		//内侧切线
		if(triarea(r1,r2,d)==0){
			t=c1.cc+a*r1/r2;
			q=tlPointCircle(t,c1);
			while(q.size()) ans.push_back(q.back()),q.pop_back();
		}
		//外侧切线
		t=c1.cc+a*r1/(r1-r2);
		q=tlPointCircle(t,c1);
		while(q.size()) ans.push_back(q.back()),q.pop_back();
	}
	return ans;
}
//最小圆覆盖
circle Smallestcir(point *u,int size){
	random_shuffle(u+1,u+1+size);
	point o=u[1];
	double r=0;
	for(int i=2;i<=size;i++){
		if(disPointPoint(o,u[i])<=r) continue;
		o=(u[i]+u[1])/2;
		r=disPointPoint(u[i],u[1])/2;
		for(int j=2;j<i;j++){
			if(disPointPoint(u[j],o)<=r) continue;
			o=(u[i]+u[j])/2;
			r=disPointPoint(u[i],u[j])/2;
			for(int k=1;k<j;k++){
				if(disPointPoint(u[k],o)<=r) continue;
				circle c=concyclic(u[i],u[j],u[k]);
				o=c.cc;r=c.radius;
			}
		}
	}
	circle c;
	c.cc=o;c.radius=r;
	return c;
}
```
## 凸包

[圈奶牛](https://www.luogu.com.cn/problem/P2742)  
Andrew法  
手写栈，先求求下凸包，后求上凸包  
```cpp
int stk[N << 1]; // 记得开双倍
vector<Point> andrew(Point* poly,int n) {
    sort(poly + 1, poly + n + 1, [](Point u, Point v) {return (u.x == v.x ? u.y > v.y : u.x < v.x);});
    int top = 1;
    for (int i = 1; i <= n; i++) {
        while (top >= 3 && ((poly[stk[top - 1]] - poly[stk[top - 2]]) ^ (poly[i] - poly[stk[top - 1]])) < 0) {
            top--;
        }
        stk[top++] = i;
    }
    for (int i = n; i >= 1; i--) {
        while (top >= 3 && ((poly[stk[top - 1]] - poly[stk[top - 2]]) ^ (poly[i] - poly[stk[top - 1]])) < 0) {
            top--;
        }
        stk[top++] = i;
    }
    vector<Point> tmp;
    for (int i = 1; i < top - 1; i++) {
        tmp.push_back(poly[stk[i]]);
    }
    return tmp;
}
```

