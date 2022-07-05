#!/bin/python3
import numpy as np
import matplotlib.pyplot as plt


def read_points(filename: str):
    """Liest den Input einer Datei ein"""
    return np.loadtxt(filename, delimiter=" ")


def read_svm(filename: str):
    """Liest den Vektor und Offset der SVM ein."""
    try:
        with open(filename) as f:
            w = np.array(np.mat(f.readline())).flatten()
            b = float(f.readline().strip())
        return w, b
    except FileNotFoundError:
        print("Seems like the params file does not exist!")


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


def create_plots(filename: str):
    """Erstelle den Vektor der SVM und plotte die Punktwolke und die trennende Gerade."""
    w, b = read_svm(f"./params_{filename}")
    line_data = compute_line(w, b)
    data = read_points(f"./{filename}")
    plot_point_cloud(data, line_data)


if __name__ == "__main__":
    import sys
    if len(sys.argv) < 1:
        raise Exception("No file name passed!")
    filename = sys.argv[1]
    create_plots(filename)
    plt.savefig("plot_" + filename.split('.')[0] + ".png")
