// experiments/l0-vector-add-cuda/main.cu
//

#include <iostream>
#include <cuda_runtime.h>

// 辅助错误处理由 Codex 补充，学习时先关注 main 中的数据流。
bool check_cuda(cudaError_t status, const char *operation)
{
    if (status == cudaSuccess)
        return true;
    std::cerr << operation << " 失败：" << cudaGetErrorString(status) << std::endl;
    return false;
}

// 尝试释放全部已分配的缓冲区，不让后续成功覆盖之前的失败。
bool release_buffers(int *d_A, int *d_B, int *d_C)
{
    int *buffers[] = {d_A, d_B, d_C};
    const char *operations[] = {"cudaFree(d_A)", "cudaFree(d_B)", "cudaFree(d_C)"};
    bool success = true;
    for (int i = 0; i < 3; ++i)
    {
        if (buffers[i] != nullptr)
        {
            if (!check_cuda(cudaFree(buffers[i]), operations[i]))
                success = false;
        }
    }
    return success;
}

__global__ void vector_add(const int *A, const int *B, int *C, int N)
{
    int i = blockIdx.x * blockDim.x + threadIdx.x;
    if (i < N)
        C[i] = A[i] + B[i];
}

int main()
{
    const int N = 6;

    int h_A[] = {1, 2, 3, 4, 5, 6};
    int h_B[] = {10, 20, 30, 40, 50, 60};
    int h_C[N];
    size_t bytes = N * sizeof(int);

    int *d_A = nullptr, *d_B = nullptr, *d_C = nullptr;

    cudaError_t status_malloc_A = cudaMalloc(&d_A, bytes);
    if (!check_cuda(status_malloc_A, "cudaMalloc(d_A)"))
    {
        return 1;
    }
    cudaError_t status_malloc_B = cudaMalloc(&d_B, bytes);
    if (!check_cuda(status_malloc_B, "cudaMalloc(d_B)"))
    {
        release_buffers(d_A, nullptr, nullptr);
        return 1;
    }
    cudaError_t status_malloc_C = cudaMalloc(&d_C, bytes);
    if (!check_cuda(status_malloc_C, "cudaMalloc(d_C)"))
    {
        release_buffers(d_A, d_B, nullptr);
        return 1;
    }

    cudaError_t status_copy_A = cudaMemcpy(d_A, h_A, bytes, cudaMemcpyHostToDevice);
    if (!check_cuda(status_copy_A, "cudaMemcpy(h_A -> d_A)"))
    {
        release_buffers(d_A, d_B, d_C);
        return 1;
    }
    cudaError_t status_copy_B = cudaMemcpy(d_B, h_B, bytes, cudaMemcpyHostToDevice);
    if (!check_cuda(status_copy_B, "cudaMemcpy(h_B -> d_B)"))
    {
        release_buffers(d_A, d_B, d_C);
        return 1;
    }

    vector_add<<<2, 4>>>(d_A, d_B, d_C, N);
    if (!check_cuda(cudaGetLastError(), "vector_add 启动"))
    {
        release_buffers(d_A, d_B, d_C);
        return 1;
    }
    if (!check_cuda(cudaDeviceSynchronize(), "vector_add 执行"))
    {
        release_buffers(d_A, d_B, d_C);
        return 1;
    }
    cudaError_t status_copy_C = cudaMemcpy(h_C, d_C, bytes, cudaMemcpyDeviceToHost);
    if (!check_cuda(status_copy_C, "cudaMemcpy(d_C -> h_C)"))
    {
        release_buffers(d_A, d_B, d_C);
        return 1;
    }
    for (int i = 0; i < N; i++)
        std::cout << "C[" << i << "]: " << h_C[i] << std::endl;

    return release_buffers(d_A, d_B, d_C) ? 0 : 1;
}
