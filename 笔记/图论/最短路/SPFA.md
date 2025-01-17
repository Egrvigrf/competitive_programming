```cpp
int dis[MAXN];//dis[i]=源点s->i最短路径
bool vis[MAXN];//vis[i]表示i是否在队列
void spfa(int s){
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