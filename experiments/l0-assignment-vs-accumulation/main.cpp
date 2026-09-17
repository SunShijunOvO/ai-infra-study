// experiments/l0-assignment-vs-accumulation/main.cpp
// output: C is [11, 22, 33, 44], D is [111, 122, 133, 144]

#include <iostream>

int main()
{
    int A[] = {1, 2, 3, 4};
    int B[] = {10, 20, 30, 40};

    int C[] = {100, 100, 100, 100};
    int D[] = {100, 100, 100, 100};

    for (int i = 0; i < 4; i++)
    {
        C[i] = A[i] + B[i];
        D[i] += A[i] + B[i];
    }

    for (int i = 0; i < 4; i++)
    {
        std::cout << C[i] << ", " << D[i] << std::endl;
    }
}