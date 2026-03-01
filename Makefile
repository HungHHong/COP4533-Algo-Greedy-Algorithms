## Author: Hong

CXX = g++
CXXFLAGS = -std=c++17 -Wall

SRC = src/main.cpp src/fifo.cpp src/lru.cpp src/optff.cpp src/common.cpp
TARGET = cache_sim

all: $(TARGET)

$(TARGET):
	$(CXX) $(CXXFLAGS) $(SRC) -o $(TARGET)

run:
	./$(TARGET) < data/testdata

clean:
	rm -f $(TARGET)