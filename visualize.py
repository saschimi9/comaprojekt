import readline
import numpy as np
import matplotlib.pyplot as plt
from itertools import islice


def read_points(filename: str):
    """Liest den Input einer Datei ein"""
    return np.loadtxt(filename, delimiter=" ")


def read_svm(filename: str):
    """Liest den Vektor und Offset der SVM ein."""
    with open(filename) as f:
        w = np.array(np.mat(f.readline())).flatten()
        b = float(f.readline().strip())
    return w, b


def plot_point_cloud(data, line_data):
    """Erstellt einen Plot basierend auf den eingelesen Daten `data` und den zwei Punkten, die die SVM darstellen."""
    x_1 = data[:, 0]
    x_2 = data[:, 1]
    y = data[:, 2].astype(int).flatten()
    colors = ['b', 'r', 'g']
    colors_y = [colors[i] for i in y]

    plt.scatter(x_1, x_2, color=colors_y)
    plt.plot(line_data[0], line_data[1])
    plt.xlabel('$x_1$')
    plt.ylabel('$x_2$')
    plt.legend(['Data', 'Separator'])
    plt.show()


def compute_line(w, b):
    """Bestimmt fuer eine gegeben Geradengleichung zwei Punkte, um die Gerade darstellen zu koennen."""
    if w[0] != 0 and w[1] != 0:
        x = np.linspace(0, 5, 2)
        y = (-b - w[0]*x)/w[1]
    elif w[0] != 0:
        y = np.linspace(0, 5, 2)
        x = (-b - w[1]*y)/w[0]
    elif w[1] != 0:
        x = np.linspace(0, 5, 2)
        y = (-b - w[0]*x)/w[1]
    else:
        raise Exception("Zero vector!")
    return x, y


if __name__ == "__main__":
    # print(read_points("./Beispiel_1.txt"))

    # w = np.array([1, 0])
    # b = 0
    # print(compute_line(w, b))

    # w = np.array([0, 1])
    # b = 1
    # print(compute_line(w, b))

    # w = np.array([-1, 1])
    # b = 0
    # print(compute_line(w, b))

    filename = "./params_Beispiel_2.txt"
    read_svm(filename)