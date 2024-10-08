import sys


def main():
    n = int(input())
    for i in range(n):
        name = sys.stdin.readline().rstrip('\n')
        print('Hello %s!' % name)


if __name__ == '__main__':
    main()
