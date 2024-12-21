
考虑排序后，如果最大的数可操作，那么把k全部给最大数，收益最大。
如果最大的数不可操作，可以考虑增加中位数的值，和操作索引最大的可操作数进行比较。
考虑如何增加中位数的值，考虑二分中位数的值，对于一个值mid,如果操作后有一半的数能大于mid,则check函数返回true
判断时注意奇偶`if(cnt >= (n+1)/2)`

```cpp
// Problem: C. Perform Operations to Maximize Score
// Contest: Codeforces - Codeforces Round 965 (Div. 2)
// URL: https://codeforces.com/contest/1998/problem/C
// Memory Limit: 256 MB
// Time Limit: 3000 ms
// Created: 2024-08-12 20:20:52

#include <bits/stdc++.h>

using namespace std;
using ll = long long;
using ld = long double;
using ull = unsigned long long;

#define _for(i,a,b) for(int i = (a); i < (b); i++)
#define _rep(i,a,b) for(int i = (a); i <= (b); i++)
#define for_(i,b,a) for(int i = (b); i > (a); i--)
#define rep_(i,b,a) for(int i = (b); i >= (a); i--)
#define all(x) (x).begin(), (x).end()
#define rall(x) (x).rbegin(), (x).rend()
#define inf 0x3f3f3f3f // 1e9
#define endl '\n'

#define LOCAL
#ifdef LOCAL
#define dbg(...) (cout << "--> ", _debug((char*)#__VA_ARGS__, __VA_ARGS__))
#else
#define dbg(...) ((void)0)
#endif
#define int long long
template<typename T>
void _debug(char* f, T t) {
    cout << f << '=' << t << endl;
}
template<typename T, typename... Args>
void _debug(char* f, T x, Args... y) {
    while (*f != ',') {
        cout << *f++;
    }
    cout << '=' << x << ", ";
    _debug(f + 1, y...);
}
const int N = 2e5+1;
struct node {
	int a,b;
}a[N];
int n,k;
bool check(int mid) {
	int cnt = 0;
	vector<int> t;
	for(int i = 1; i <= n-1; i++) {
		if(a[i].a >= mid) {
			cnt++;
		} else {
			if(a[i].b == 1) {
				t.push_back(mid - a[i].a);
			} 
		}
	}
	int kk = k;
	for(int i = t.size()-1; i >= 0; i--) {
		if(kk - t[i] >= 0) {
			kk -= t[i];
			cnt++;
		} else break;
	}
	if(cnt >= (n+1)/2) return true;
	else return false; 
}
void solve() {
    cin >> n >> k;
    
    _rep(i,1,n) cin >> a[i].a;
    _rep(i,1,n) cin >> a[i].b;
    sort(a+1,a+n+1,[](node x,node y) {
    	return x.a < y.a;
    });
    if(a[n].b == 1) {
    	cout<<a[n/2].a + k + a[n].a << endl;
    	return;
    }
    int ans = 0;
    for(int i = n-1; i >= 1; i--) {
    	if(a[i].b == 1) {
    		if(i > n/2) {
    			ans = a[n/2].a + k + a[i].a; 
    		} else {
    			ans = a[n/2+1].a + k + a[i].a;
    		}
    		break;
    	}
    }
    int l = 0, r = 2e9;
    int t = 0;
    while(l <= r) {
    	int mid = (l+r) >> 1;
    	if(check(mid)) {
    		l = mid + 1;
    		t = max(t,mid);
    	} else {
    		r = mid - 1;
    	}
    }
    ans = max(ans,t+a[n].a);
    cout<<ans<<endl;
}

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    cout.tie(nullptr);
    int T;
    cin >> T;
    while(T--) {
        solve();
    }
    return 0;
}


```