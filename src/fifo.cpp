// Author: Hong

#include <vector>
#include <unordered_set>
#include <queue>

// Hong: fifo, should be alreeady fully implemented and vetted
// FIFO (First-In, First-Out) cache eviction.
// Uses an unordered_set for O(1) membership checks and a queue
// to evict the oldest inserted page when the cache is full.
// Time: O(m) average, Space: O(k).

int simulate_fifo(int k, const std::vector<int>& req) {
    //edge case
    if (k == 0) return req.size();

    // tracker
    std::unordered_set<int> cache;
    std::queue<int> order;

    int misses = 0;

    for (int page : req) {
        if (cache.find(page) != cache.end()) {
            // Cache hit: do nothing, and we didn't update our order since it fifo
            continue;
        }

        // Cache miss
        misses++;

        // If cache is full, evict the oldest inserted page
        if ((int)cache.size() == k) {
            int victim = order.front();
            order.pop();
            cache.erase(victim);
        }
        
        // Insert new page
        cache.insert(page);
        order.push(page);
    }

    return misses;
}

// FIFO using cache eviction
// Source: https://www.youtube.com/watch?v=P_UYI23DddU

// I choose using queue + unordered_set to implement FIFO, because it allows for O(1) membership checks and efficient eviction 
//of the oldest page. The queue maintains the order of page insertions, while the unordered_set provides fast lookups to determine 
//if a page is already in the cache. This combination ensures that we can efficiently manage the cache and count page misses without 
//needing to search through the entire cache on each request.

