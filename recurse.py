n = input()
k = input()

def C(n, k):
    if n == k:
        print(n, k)
        return 1
    elif n > 0 and k == 0:
        print (n, k)
        return 1
    else:
        return C(n - 1, k-1) + C(n - 1, k)

print C(n, k)