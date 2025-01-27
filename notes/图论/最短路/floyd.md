全源最短路
时间复杂度O(N^3)
空间复杂度O(N^2)
能有负边不能有负环

```cpp
for(int k = 0; k < n; k++) { //途径k
	for(int i = 0; i < n; i++) {
		for(int j = 0; j < n; j++) {
			if(dis[i][k] != inf && dis[k][j] != inf 
			&& dis[i][k] + dis[k][j] < dis[i][j]) {
				dis[i][j] = dis[i][k] + dis[k][j];
			}
		}
	}
}
```

模板
[ Clear And Present Danger S](https://www.luogu.com.cn/problem/P2910)
