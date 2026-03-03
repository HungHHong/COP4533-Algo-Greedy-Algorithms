// Author: Hong


#include <vector>
#include <list>
#include <unordered_map>

// LRU implemented with list + unordered_map.
// The list maintains usage order (front = most recent, back = least recent).
// The unordered_map enables O(1) lookup and access to list iterators.
int simulate_lru(int k, const std::vector<int>& req) {

    // If cache capacity is 0, every request is a miss
    if (k == 0) return req.size();

    std::list<int> order;  // Tracks recency of use
    std::unordered_map<int, std::list<int>::iterator> pos;  // Page -> position in list

    int misses = 0;

    for (int page : req) {

        // Cache hit: move page to front (most recently used)
        auto it = pos.find(page);
        if (it != pos.end()) {
            order.splice(order.begin(), order, it->second);
            continue;
        }

        // Cache miss
        misses++;

        // If cache is full, evict least recently used page (back of list)
        if ((int)pos.size() == k) {
            int victim = order.back();
            order.pop_back();
            pos.erase(victim);
        }

        // Insert new page as most recently used
        order.push_front(page);
        pos[page] = order.begin();
    }

    return misses;
}




















// // TEMP respond 
// // Todo
// #include <vector>

// int simulate_lru(int k, const std::vector<int>& req) {
//     (void)k;
//     (void)req;
//     return -1; // not implemented yet
// }



