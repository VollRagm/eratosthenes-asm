#include <iostream>
#include <Windows.h>

extern "C" bool* get_primes(int end);

extern "C" void* mem_alloc(size_t size)
{
    auto mem = VirtualAlloc(NULL, size, MEM_COMMIT, PAGE_READWRITE);
    if (!mem) return 0;
    memset(mem, 0, size);
    return mem;
}

int main()
{
    int end = 1000;

    bool* primeArray = get_primes(end);

    for (int i = 2; i < end - 1; i++)
    {
        if (!primeArray[i])
            std::cout << i << std::endl;
    }

    Sleep(INFINITE);
}