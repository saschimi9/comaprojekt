import numpy as np

def read_points(filename: str):
    """Liest den Input einer Datei ein"""
    pass

def compute_line(w, b):
    """Bestimmt fuer eine gegeben Geradengleichung zwei Punkte, um die Gerade darstellen zu koennen."""
    if w[0] != 0 and w[1] != 0:
        x = np.linspace(0,5, 2)
        y = (b - w[0]*x)/w[1]
    elif w[0] != 0:
        y = np.linspace(0,5, 2)
        x = (b - w[1]*y)/w[0]
    elif w[1] != 0:
        x = np.linspace(0,5, 2)
        y = (b - w[0]*x)/w[1]
    else:
        raise Exception("Zero vector!")
    return x, y

if __name__ == "__main__":
    w = np.array([1,0])
    b = 0
    print(compute_line(w, b))

    w = np.array([0,1])
    b = 1
    print(compute_line(w, b))

    w = np.array([-1,1])
    b = 0
    print(compute_line(w, b))