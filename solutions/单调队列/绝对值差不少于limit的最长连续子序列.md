给你一个整数数组 `nums` ，和一个表示限制的整数 `limit`，请你返回最长连续子数组的长度，该子数组中的任意两个元素之间的绝对差必须小于或者等于 `limit` _。_

如果不存在满足条件的子数组，则返回 `0` 。

---

滑动窗口+单调队列  
单调性显然：窗口长度增加，最大值增加(>=)，最小值增加(>=)  
用单调队列维护滑动窗口中的最值  

---
```cpp
//这里min和mx写反了
const int N = 1e5 + 10;
int mx[N],mini[N];
class Solution {
public:
    int longestSubarray(vector<int>& a, int limit) {
        int Lmx = 1, Rmx = 0;
        int Lmi = 1, Rmi = 0;
        int n = a.size();
        int ans = 0;
        for (int L = 0, R = 0; R <= n-1; R++) {
            while (Rmx - Lmx + 1 >= 1 && a[R] < a[mx[Rmx]]) {
                Rmx--;
            }
            mx[++Rmx] = R;
            while (Rmi - Lmi + 1 >= 1 && a[R] > a[mini[Rmi]]) {
                Rmi--;
            }
            mini[++Rmi] = R;
            while (R - L + 1 >= 1 && a[mini[Lmi]] - a[mx[Lmx]] > limit) {
                L++;
                while (mx[Lmx] < L) {
                    Lmx++;
                }
                while (mini[Lmi] < L) {
                    Lmi++;
                }
            }
            ans = max(ans,R-L+1);
        }
        return ans;
    }
};
```