new = open("codes.txt", "a")
with open("airportcodes.txt") as airportcodes:
    for line in airportcodes:
        new.write(line[0 : 4]+'\n')
