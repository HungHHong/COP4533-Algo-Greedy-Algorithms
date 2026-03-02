# Author: Hong

CXX      := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -O2
TARGET   := cache_sim

SRC := src/main.cpp src/common.cpp src/fifo.cpp src/lru.cpp src/optff.cpp
OBJ := $(SRC:.cpp=.o)

# Default input file (can override: make run FILE=data/seq2.txt)
FILE ?= data/seq1.txt

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CXX) $(CXXFLAGS) $(OBJ) -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

run: $(TARGET)
	./$(TARGET) $(FILE)

# Compare outputs against expected files:
# expects pairs like data/seq1.txt and data/seq1_expected.txt
test: $(TARGET)
	@set -e; \
	for in_file in data/seq*.txt; do \
	  exp_file=$${in_file%.txt}_expected.txt; \
	  if [ ! -f "$$exp_file" ]; then \
	    echo "Missing expected file: $$exp_file"; \
	    exit 1; \
	  fi; \
	  echo "Testing $$in_file"; \
	  ./$(TARGET) "$$in_file" > /tmp/cache_sim_out.txt; \
	  diff -u "$$exp_file" /tmp/cache_sim_out.txt; \
	done; \
	echo "All tests passed."

clean:
	rm -f $(TARGET) $(OBJ)