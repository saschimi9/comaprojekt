#!/bin/python3

if __name__ == "__main__":
    import sys
    import matplotlib.pyplot as plt
    import visualize
    if len(sys.argv) < 1:
        raise Exception("No file name passed!")
    filename = sys.argv[1]

    visualize.create_plots(filename)
    plt.savefig("plot_" + filename.split('.')[0] + ".png")
