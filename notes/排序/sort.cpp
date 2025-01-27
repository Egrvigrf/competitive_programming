#include <bits/stdc++.h>
#if !defined(ONLINE_JUDGE) && defined(LOCAL)
#include "debug.h"
#else
#define debug(...) ((void)0)
#endif
using namespace std;
using ll = long long;
using ld = long double;
using ull = unsigned long long;

mt19937 rnd(chrono::steady_clock::now().time_since_epoch().count());
int r(int a, int b) {
    return rnd() % (b - a + 1) + a;
}




/*-----------------------------------冒泡排序-----------------------------------*/
void bubble_sort(vector<int>& a) {
    for (int i = 1; i <= a.size() - 1; i++) {
        for (int j = a.size() - 1; j >= i; j--) {
            if (a[j] < a[j - 1]) {
                swap(a[j], a[j - 1]);
            }
        }
    }
}

/*-----------------------------------插入排序-----------------------------------*/
void insert_sort(vector<int>& a) {
    for (int i = 1; i <= a.size() - 1; i++) {
        int k = a[i];
        int j = i;
        while (j >= 1 && k < a[j - 1]) {
            a[j] = a[j - 1];
            j--;
        }
        a[j] = k;
    }
}

/*-----------------------------------选择排序-----------------------------------*/
void select_sort(vector<int>& a) {
    for (int i = 1; i < a.size(); i++) {
        int k = i;
        for (int j = i + 1; j < a.size(); j++) {
            if (a[j] < a[k]) {
                k = j;
            }
        }
        swap(a[i], a[k]);
    }
}

/*-----------------------------------快速排序-----------------------------------*/
void quick_sort(vector<int>& a, int begin, int end) {
    if (begin >= end)
        return;
    vector<int> b;
    for (int i = begin; i <= end; i++) {
        b.push_back(a[i]);
    }
    // int key = b[0];
    int random_index = r(begin, end);
    int key = a[random_index];
    int t = 0;
    int count = 0;
    for (int i = begin; i <= end; i++) {
        if (a[i] < key) {
            b[t] = a[i];
            t++;
        } else if (a[i] == key)
            count++;
    }
    int left = begin + t - 1;
    for (int i = 1; i <= count; i++) {
        b[t] = key;
        t++;
    }
    int right = begin + t;
    for (int i = begin; i <= end; i++) {
        if (a[i] > key) {
            b[t] = a[i];
            t++;
        }
    }
    for (int i = begin; i <= end; i++) {
        a[i] = b[i - begin];
    }
    quick_sort(a, begin, left);
    quick_sort(a, right, end);
}

/*-----------------------------------归并排序-----------------------------------*/
void merge(vector<int>& b, int left, int right, int middle) {
    vector<int> L(middle - left + 1);
    vector<int> R(right - middle);
    for (int i = left; i <= middle; i++) {
        L[i - left] = b[i];
    }
    for (int i = middle + 1; i <= right; i++) {
        R[i - middle - 1] = b[i];
    }
    int t = left;
    int j = 0, k = 0;
    while (j < middle - left + 1 && k < right - middle) {
        if (L[j] <= R[k]) {
            b[t] = L[j];
            j++;
            t++;
        } else {
            b[t] = R[k];
            k++;
            t++;
        }
    }
    while (j < middle - left + 1) {
        b[t] = L[j];
        j++;
        t++;
    }
    while (k < right - middle) {
        b[t] = R[k];
        k++;
        t++;
    }
}
void merge_sort(vector<int>& b, int left, int right) {
    if (left == right)
        return;
    int middle = (left + right) / 2;
    merge_sort(b, left, middle);
    merge_sort(b, middle + 1, right);
    merge(b, left, right, middle);
}

/*-----------------------------------堆排序-----------------------------------*/
void modiup(vector<int>& a, int p) {
    while (p > 1 && a[p] > a[p / 2]) { 
        swap(a[p], a[p / 2]);
        p /= 2;
    }
}

void modidown(vector<int>& a, int p, int n) {
    int l = p * 2;
    while (l <= n) {
        int best = (l + 1 <= n && a[l + 1] > a[l]) ? l + 1 : l; 
        best = a[best] > a[p] ? best : p;
        if (best == p) {
            break;
        }
        swap(a[best], a[p]);
        p = best;
        l = p * 2;
    }
}
// 从底到顶建立大根堆，O(n)
// 依次弹出堆内最大值并排好序，O(n * logn)
// 整体时间复杂度O(n * logn)
void heapify(vector<int>& a, int n) {
    for (int i = n / 2; i >= 1; i--) { 
        modidown(a, i, n);
    }
}

void heap_sort(vector<int>& a) {
    int n = a.size() - 1;
    heapify(a, n);
    for (int i = n; i > 1; --i) {
        swap(a[1], a[i]);
        n--;
        modidown(a, 1, n);
    }
}

/*-----------------------------------排序测试-----------------------------------*/
//下标从1开始
//升序
int main() {
    const int number_count = 100000; // 要生成的随机数个数
    const int max_value = 1000000;   // 随机数的最大值

    vector<int> rd(number_count), mysort(number_count);
    for (int i = 1; i <= rd.size() - 1; i++)
        rd[i] = mysort[i] = r(1, max_value);
    
    sort(rd.begin() + 1, rd.end());
    auto start = chrono::high_resolution_clock::now();
    // bubble_sort(mysort);
    //insert_sort(mysort);
    //select_sort(mysort);
    //heap_sort(mysort);
    //quick_sort(mysort,1,mysort.size()-1);
    //merge_sort(mysort,1,mysort.size()-1);
    auto end = chrono::high_resolution_clock::now();
    chrono::duration<double> elapsed = end - start;

    bool f = 1;
    for (int i = 1; i <= rd.size() - 1; i++) {
        if (rd[i] != mysort[i]) {
            f = 0;
            break;
        }
    }
    if (f)
        cout << "排序结果正确！";
    else
        cout << "排序结果错误！";
    cout << endl;
    cout << "Time elapsed: " << elapsed.count() << " seconds" << endl;

    return 0;
}
