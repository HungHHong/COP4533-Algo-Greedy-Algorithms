# Author: Hong

CXX      := g++
CXXFLAGS := -std=c++17 -Wall -Wextra -O2 -Isrc
TARGET   := cache_sim

SRC := src/main.cpp src/common.cpp src/fifo.cpp src/lru.cpp src/optff.cpp
OBJ := $(SRC:.cpp=.o)

# Default input file (override: make run FILE=data/seq2.txt)
FILE ?= data/seq1.txt

# Used by tests
OUTDIR := out

.PHONY: all run test test-one clean

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CXX) $(CXXFLAGS) $(OBJ) -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

## manual test & give output
run: $(TARGET)
	./$(TARGET) $(FILE)

## Run test again expected output
# Run a single test case:
# make test-one FILE=data/seq3.txt
test-one: $(TARGET)
	@mkdir -p $(OUTDIR)
	@exp_file=$(FILE:.txt=_expected.txt); \
	if [ ! -f "$$exp_file" ]; then \
	  echo "Missing expected file: $$exp_file"; \
	  exit 1; \
	fi; \
	echo "Testing $(FILE)"; \
	./$(TARGET) "$(FILE)" > $(OUTDIR)/cache_sim_out.txt; \
	diff -u "$$exp_file" $(OUTDIR)/cache_sim_out.txt

# Run all seq*.txt tests
test: $(TARGET)
	@mkdir -p $(OUTDIR)
	@set -e; \
	for in_file in data/seq*.txt; do \
	  case "$$in_file" in *_expected.txt) continue ;; esac; \
	  exp_file=$${in_file%.txt}_expected.txt; \
	  if [ ! -f "$$exp_file" ]; then \
	    echo "Missing expected file: $$exp_file"; \
	    exit 1; \
	  fi; \
	  echo "Testing $$in_file"; \
	  ./$(TARGET) "$$in_file" > $(OUTDIR)/cache_sim_out.txt; \
	  diff -u "$$exp_file" $(OUTDIR)/cache_sim_out.txt; \
	done; \
	echo "All tests passed."

clean:
	rm -f $(TARGET) $(OBJ)
	rm -rf $(OUTDIR)