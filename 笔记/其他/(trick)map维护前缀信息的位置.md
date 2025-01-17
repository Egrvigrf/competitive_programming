1.求累加和为k的最长子序列
[牛客](https://www.nowcoder.com/practice/36fb0fd3c656480c92b569258a1223d5)
```cpp
#include <iostream>
#include <vector>
#include <map>
using namespace std;

int main() {
    int n, k;
    cin >> n >> k;
    vector<int> a(n+1);
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
    }
    map<int,int> mp;
    int sum = 0, ans = 0;
    mp[0] = 0;
    for (int i = 1; i <= n; i++) {
        sum += a[i];
        if (mp.find(sum-k) != mp.end()) {
            ans = max(ans,i - mp[sum-k]);
        }
        if (mp.find(sum) == mp.end()) {
            mp[sum] = i;
        }
    }
    cout << ans;
    return 0;
}
// 64 位输出请用 printf("%lld")
```

2.累加和为k的子数组数量
[leetcode](https://leetcode.cn/problems/subarray-sum-equals-k/description/)
```cpp
class Solution {
public:
    int subarraySum(vector<int>& a, int k) {
        unordered_map<int,int> mp;
        mp[0] = 1;
        int sum = 0;
        int ans = 0;
        for (int i = 0; i < a.size(); i++) {
            sum += a[i];
            if (mp.find(sum-k) != mp.end()) {
                ans += mp[sum-k];
            }
            mp[sum]++;
        }
        return ans;
    }
};
```

以下几个题目都是题目1的变种

3. 正负数个数相同的最长子数
[牛客](https://www.nowcoder.com/practice/545544c060804eceaed0bb84fcd992fb)

把正数记作1,负数记作-1,0记作0.
题目转化为求和为0的最长子数组长度。

```cpp
#include <bits/stdc++.h>
using namespace std;
using ll = long long;
#define _ cout << "----------" << endl
//#define int ll 

signed main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    int n;
    cin >> n;
    vector<int> a(n+1);
    for (int i = 1; i <= n; i++) {
        cin >> a[i];
        if (a[i] > 0) {
            a[i] = 1;
        } else if (a[i] < 0) {
            a[i] = -1;
        } else {
            a[i] = 0;
        }
    }
    map<int,int> mp;
    mp[0] = 0;
    int sum = 0;
    int ans = 0;
    for (int i = 1; i <= n; i++) {
        sum += a[i];
        if (mp.find(sum) != mp.end()) {
            ans = max(ans,i - mp[sum]);
        }
        if (mp.find(sum) == mp.end()) {
            mp[sum] = i;
        }
    }
    cout << ans;
    return 0;
} /* 2025-01-16 16:34 */
```

4. 求表现良好的最长时间段
[leetcode](https://leetcode.cn/problems/longest-well-performing-interval/description/)
给你一份工作时间表 hours，上面记录着某一位员工每天的工作小时数。

我们认为当员工一天中的工作小时数大于 8 小时的时候，那么这一天就是「劳累的一天」。

所谓「表现良好的时间段」，意味在这段时间内，「劳累的天数」是严格 大于「不劳累的天数」。

请你返回「表现良好时间段」的最大长度。

---

类似的处理, 转化为题目1
大于 8 的记作1  
<=  8 的记作-1  
如果当前的前缀和 >= 1， 说明从头取到当前都能满足
如果< 1
则取前缀和 sum - 1 位置的最小值， 这样取得的刚好满足  
为什么不取sum - 2 ?  
因为sum 的值都是连续的， 若能取得sum - 2 的位置， 那么一定有比他前面的（更优的） sum - 1 的位置。  
所以贪心地取sum - 1位置即可。  

```cpp
class Solution {
public:
    int longestWPI(vector<int>& a) {
        int n = a.size();
        int ans = 0;
        int sum = 0;
        map<int,int> mp;
        mp[0] = -1;
        for (int i = 0; i < n; i++) {
            sum += a[i] > 8 ? 1 : -1;
            if (sum >= 1) {
                ans = i + 1;
            } else {
                if (mp.find(sum - 1) != mp.end()) {
                    ans = max(ans,i - mp[sum-1]);
                }
            }
            if (mp.find(sum) == mp.end()) {
                mp[sum] = i;
            }
        }
        return ans;
    }
};
```

5. 使数组和能被p整除
[leetcode](https://leetcode.cn/problems/make-sum-divisible-by-p/)
给你一个正整数数组 nums，请你移除 最短 子数组（可以为 空），使得剩余元素的 和 能被 p 整除。 不允许 将整个数组都移除。

请你返回你需要移除的最短子数组的长度，如果无法满足题目要求，返回 -1 。

子数组 定义为原数组中连续的一组元素。

这里求的是最短，同理

```cpp
class Solution {
public:
    int minSubarray(vector<int>& a, int p) {
        int n = a.size();
        int tot = 0;
        for (int i = 0; i < n; i++) {
            tot = (tot + a[i]) % p;
        }
        unordered_map<int,int> mp;
        mp[0] = -1;
        int sum = 0;
        int ans = n;
        for (int i = 0; i < n; i++) {
            sum = (sum + a[i])%p;
            mp[sum] = i; // 可以什么都不移除
            if (mp.find((sum - tot + p)%p) != mp.end()) { // 同余
                ans = min(ans,i - mp[(sum - tot + p)%p]);
            }
        }
        return ans == n ? -1 : ans;
    }
};
```

6. 每个元音包含偶数次的最长长度
[leetcode](https://leetcode.cn/problems/find-the-longest-substring-containing-vowels-in-even-counts/description/)
给你一个字符串 s ，请你返回满足以下条件的最长子字符串的长度：每个元音字母，即 'a'，'e'，'i'，'o'，'u' ，在子字符串中都恰好出现了偶数次。

状压一下，记某位为0代表这个元音从头到现在出现了偶数次，1为奇数。
每次新出现，对应元素的位翻转一次。相当于那一位异或1。

```cpp
class Solution {
public:
    int findTheLongestSubstring(string s) {
        int n = s.size();
        map<int,int> mp; // 00000
        mp[0] = -1;      // uoiea
        int cur = 0;
        int ans = 0;
        for (int i = 0; i < n; i++) {
            if (s[i] == 'a') {
                cur ^= (1 << 0); 
            } else if (s[i] == 'e') {
                cur ^= (1 << 1); 
            } else if (s[i] == 'i') {
                cur ^= (1 << 2); 
            } else if (s[i] == 'o') {
                cur ^= (1 << 3); 
            } else if (s[i] == 'u') {
                cur ^= (1 << 4); 
            } 
            if (mp.find(cur) != mp.end()) {
                ans = max(ans,i - mp[cur]);
            }
            if (mp.find(cur) == mp.end()) {
                mp[cur] = i;
            }
        }
        return ans;
    }
};
```