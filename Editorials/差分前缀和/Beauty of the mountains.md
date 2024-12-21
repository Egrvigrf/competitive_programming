[Beauty of the mountains](https://codeforces.com/contest/1982/problem/D)

尼基塔喜欢山，终于决定去贝里安德山脉看看！这座山脉如此美丽，尼基塔决定用地图记录下来。地图是一个由 $n$行和 $m$ 列组成的表格，每个单元格都包含一个非负整数，代表山的高度。

他还注意到，山有两种类型：

- 有雪盖。
- 无雪帽。

尼基塔是一个非常务实的人。他希望有雪帽的山的高度总和等于没有雪帽的山的高度总和。他已经和贝里安德的市长波利卡普-波利卡波维奇达成了协议，允许他改造地貌。

尼基塔可以对大小为 $k \times k$ 的子矩阵进行如下变换：他可以在该区域内的山峰高度上添加一个整数常数 $c$ ，但山峰的类型保持不变。尼基塔可以为每次变换独立选择常数 $c$ 。**注意 $c$ 可以是负值**。

在进行变换之前，尼基塔会要求您找出是否有可能实现总和相等，或者是否不可能。代价是什么并不重要，即使山变成了峡谷，高度是负数也没关系。

如果地图上只有一种类型的山，那么另一种类型的山的高度之和将被视为零。

```c++
void solve() {
    int n,m,k;
    cin >> n >> m >> k;
    int a[n+1][m+1];
    bool tp[n+1][m+1];
    _rep(i,1,n) {
        _rep(j,1,m) {
            cin >> a[i][j];
        }
    }
    _rep(i,1,n) {
        string s;
        cin >> s;
        _rep(j,1,m) {
            tp[i][j] = (s[j-1] == '0' ? false : true);
        }
    }
    int s1[n+1][m+1],s0[n+1][m+1];
    memset(s1,0,sizeof(s1));
    memset(s0,0,sizeof(s0));
    _rep(i,1,n) {
        _rep(j,1,m) {
            s1[i][j] = s1[i-1][j] + s1[i][j-1] - s1[i-1][j-1] + tp[i][j];
            s0[i][j] = s0[i-1][j] + s0[i][j-1] - s0[i-1][j-1] + (tp[i][j] ? 0 : 1);
        }
    }
    int cnt1 = 0,cnt0 = 0;
    _rep(i,1,n) {
        _rep(j,1,m) {
            if(tp[i][j]) {
                cnt1 += a[i][j];
            } else {
                cnt0 += a[i][j];
            }
        }
    }
    if(cnt1 == cnt0) {
        cout<<"YES"<<endl;
        return;
    } 
    int dis = abs(cnt1-cnt0);
    bool ok = false;
    int ggcd = 0;
    _rep(i,k,n) {
        _rep(j,k,m) {
            int cal1 = s1[i][j] - s1[i-k][j] - s1[i][j-k] + s1[i-k][j-k];
            int cal0 = s0[i][j] - s0[i-k][j] - s0[i][j-k] + s0[i-k][j-k];
            int cnt = abs(cal1-cal0);
            if(cnt) {
                ggcd = gcd(ggcd,cnt);
            } 
        }
    }
    if(ggcd && dis%ggcd == 0) cout<<"YES";
    else cout<<"NO";
    cout<<endl;
}
```