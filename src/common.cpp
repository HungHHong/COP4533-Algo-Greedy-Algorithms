// Author: Hong

#include <vector>
#include <istream>

void read_input(std::istream& in, int& k, std::vector<int>& req) {
    int m;
    in >> k >> m;

    req.reserve(m);

    for (int i = 0; i < m; ++i) {
        int x;
        in >> x;
        req.push_back(x);
    }
}