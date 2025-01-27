# 单源最短路算法--Dijktra
## 理解
&emsp;&emsp;该算法可以求单源最短路径，即一个节点到其他所有节点的最短路径。开始建立一个距离数组存放起始节点到其他所有节点的值：自身为0，其他全部为无穷大。接着遍历从起始节点开始能到达的所有节点并更新距离。然后遍历距离数组，寻找**从未被选中**的距离的最小值。选中该最小值，此时可以确定从起始节点到该节点的最小值（因为经过其他节点再到到达该节点必然会大于当前选中的距离的最小值）。然后从该节点出发遍历能到达的节点并更新起始节点到这些距离的值（取较小值）。重复这样的过程直到下次没有更新新访问的结点。

不能有负边
## **源代码**
```cpp
#include <bits/stdc++.h>
using namespace std;
const long long inf = 2147483647;
struct edge
{
    int to, next, w;
} e[1001000];
int cnt = 0;
int head[1001000];
void addedge(int x, int y, int v)
{
    e[++cnt].next = head[x];
    e[cnt].to = y;
    e[cnt].w = v;
    head[x] = cnt;
}
int main()
{
    ios::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);//数据多加快读
    int n, m, s; // 三个整数n,m,s分别表示点的个数、有向边的个数、出发点的编号
    cin >> n >> m >> s;
    long long dist[n + 1];
    bool is_visit[n + 1];
    memset(is_visit, 0, sizeof(is_visit));
    for (int i = 1; i <= n; i++)
    {
        dist[i] = inf;
    }
    dist[s] = 0;
    /*使用前向星*/
    for (int i = 1; i <= m; i++)
    {
        int begin, end, v;
        cin >> begin >> end >> v;
        addedge(begin, end, v);
    }
    int cur = s;
    while (is_visit[cur] == false)
    {
        is_visit[cur] = true;
        for (int j = head[cur]; j != 0; j = e[j].next)
        {
            if (!is_visit[e[j].to] && dist[cur] + e[j].w < dist[e[j].to])
                dist[e[j].to] = dist[cur] + e[j].w;
        }
        int min = inf;
        for (int j = 1; j <= n; j++) // 依次找最短的，每次找到的最短的路径为最终的最短路径
        {
            if (dist[j] < min && is_visit[j] == false)
            {
                min = dist[j];
                cur = j;
            }
        }
    }
    for (int i = 1; i <= n; i++)
        cout << dist[i] << " ";
    return 0;
}
```
## 相关题目
- [P3371 【模板】单源最短路径（弱化版）](https://www.luogu.com.cn/problem/P3371)


可以考虑采用堆优化
[[堆]]
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
struct priority {
    int dis;
    int id;
    bool operator <(const priority& x)const {
        return x.dis < dis;
    }
};
int main() {
    ios::sync_with_stdio(false); cin.tie(nullptr); cout.tie(nullptr);//数据多加快读
    int n, m, s; // 三个整数n,m,s分别表示点的个数、有向边的个数、出发点的编号
    cin >> n >> m >> s;
    long long dist[n + 1];
    bool is_visit[n + 1];
    for (int i = 1; i <= n; i++) {
        dist[i] = inf;
        is_visit[i] = false;
    }
    dist[s] = 0;
    /*使用前向星*/
    for (int i = 1; i <= m; i++) {
        int begin, end, v;
        cin >> begin >> end >> v;
        addedge(begin, end, v);
    }
    priority_queue<priority> q;
    q.push((priority) {0,s});
    while (!q.empty()) {
        priority temp = q.top();
        q.pop();
        if(is_visit[temp.id]) continue;
        is_visit[temp.id] = true;
        int cur = temp.id;
        for (int j = head[cur]; j != 0; j = e[j].next) {
            int to = e[j].to;
            if (!is_visit[to] && dist[cur] + e[j].w < dist[to]) {
                dist[to] = dist[cur] + e[j].w;
                q.push((priority){dist[to],to});
            }
        }
    }
    for (int i = 1; i <= n; i++) 
        cout << dist[i] << " ";
    return 0;
}
```






## 文档历史
- 文档创建：2024/4/25 Thur. 0:28