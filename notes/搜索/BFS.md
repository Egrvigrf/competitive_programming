# 广度优先搜索

## 本质是状态的逐层转移并判断，搜索不一定要有具体的图

## 树的层次遍历类似广搜
### 算法思想
维护一个队列，用于存放节点的信息。当访问一个节点时，先访问该节点，然后将它的子节点分别入队。
### 伪代码
```c++
void ccbl(int root)
{
    queue<int> Q;
    Q.push(root);
    cout<<root;
    while(!Q.empty())
    {
        int t = Q.front();
        Q.pop();
        cout<<t;
        子节点入队
    }
}
```
## BFS基本思想
从初始状态开始，利用规则，生成所有可能的状态，构成树的下一层节点。

检查 是否出现目标状态G,若未出现,就对该层所有状态节点，分别利用规则，生成再下一层的所有状态节点。

对新一层的所有状态节点继续检查是否出现G,若未出现，继续按上面思想生成再下一层的所有状态节点，这样一层一层往下展开，直到出现目标状态为止。

## 伪代码
```c++
node bfs(node source , node target)
{
    memset(visit,0,sizeof(visit));
    queue<node> Q;
    Q.push(source);
    visit[source]=1;
    while(!Q.empty())
    {
        node a =Q.front();
        Q.pop();
        if(a==target) { return a; }
        for(对于a所有的后继节点b)
        {
            if(visit[b]){ continue; }
            Q.push(b);
            visit[b]=1；//剪枝，保证节点只进队列一次
        }
    }
    return NULL;
}
```
## 题目
[洛谷 P1443 马的遍历](https://www.luogu.com.cn/problem/P1443)
- 可以用queue<pair<int,int>> q;存储一对元素
- q.front().first;
- q.front().second;