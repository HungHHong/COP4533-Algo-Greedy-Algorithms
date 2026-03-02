// Author: Hong

#include <iostream>
#include <fstream>
#include <vector>
#include <exception>

// Function prototypes
void read_input(std::istream& in, int& k, std::vector<int>& req);
int simulate_fifo(int k, const std::vector<int>& req);
int simulate_lru(int k, const std::vector<int>& req);
int simulate_optff(int k, const std::vector<int>& req);

static void usage(const char* prog) {
    std::cerr << "Usage:\n"
              << "  " << prog << " <input_file>\n"
              << "  " << prog << " < input_file\n";
}

// main loop
int main(int argc, char** argv) {
    std::ios::sync_with_stdio(false);
    std::cin.tie(nullptr);

    try {
        int k;
        std::vector<int> req;

        if (argc == 2) {
            std::ifstream fin(argv[1]);
            if (!fin) {
                std::cerr << "Error: cannot open input file: " << argv[1] << "\n";
                return 1;
            }
            read_input(fin, k, req);
        } else if (argc == 1) {
            read_input(std::cin, k, req);
        } else {
            usage(argv[0]);
            return 1;
        }

        const int fifo_misses  = simulate_fifo(k, req);
        const int lru_misses   = simulate_lru(k, req);
        const int optff_misses = simulate_optff(k, req);

        std::cout << "FIFO : "  << fifo_misses  << "\n";
        std::cout << "LRU : "   << lru_misses   << "\n";
        std::cout << "OPTFF : " << optff_misses << "\n";

        return 0;

    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << "\n";
        return 1;
    }
}