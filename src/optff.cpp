// Author: Nicholas

// TEMP STUB
// todo 
# include <limits.h>
#include <vector>
#include <unordered_set>
#include <unordered_map>
#include <queue>

using namespace std;

int simulate_optff(int k, const vector<int>& req) {

    if(k==0){
        return 0;
    }

    int n = req.size();

    int ans =0;

    unordered_set<int> cache;

    // Keeps track of numbers and future positions it has
    unordered_map<int,queue<int>> mp;

    // Calculating the future positions each number has
    for(int i=0; i<n; i++){
        mp[req[i]].push(i);
    }

    for(int page: req){
        
        mp[page].pop();

        if(cache.find(page)!= cache.end()){
            // Cache hit, continue to next page
            continue;
        }

        // Otherwise we have a cache miss
        ans++;

        // If cache full, we need to check for the longest time in cache
        if(cache.size()==k){
            int top = -1;
            int oldNum=-1;

            // For each number in the cahce, find the one with longest wait time, or infinity
            for(int num: cache){
                int nextUseOfNum=0;

                if(mp[num].empty()){
                    nextUseOfNum= INT_MAX; // never used again
                }
                else{
                    nextUseOfNum = mp[num].front();
                }

                if(nextUseOfNum>top){
                    top=nextUseOfNum;
                    oldNum=num;
                }

            }

            cache.erase(oldNum);

        }

        // We can now insert the page safely
        cache.insert(page);

    }

    return ans; // Number of misses
}