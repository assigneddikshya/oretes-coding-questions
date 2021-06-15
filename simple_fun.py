import bonobo

def extract():
    for i in range(42):
        yield i


def transform(n):
    if n%2:
        yield n

def load(n):
    print(n)

graph = bonobo.Graph(
    extract,
    transform,
    load,
)

if __name__ == '__main__':
    bonobo.run(graph)