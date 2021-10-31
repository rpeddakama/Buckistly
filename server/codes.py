def writeCodes():
    new = open("codes.txt", "a")
    with open("airportcodes.txt") as airportcodes:
        for line in airportcodes:
            new.write(line[0 : 4]+'\n')

def writeLocations():
    new = open("locations.txt", "a")
    with open("airportcodes.txt") as airportcodes:
        for line in airportcodes:
            # print(line)
            # x=line[5:40]
            # y=line[5:40].strip()
            # print(x, len(x))
            # print(y, len(y))
            new.write(line[5 : 40].strip()+'\n')
            # break

writeLocations()
