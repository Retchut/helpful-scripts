'''
	To use this, replace the array appends with whatever your sleeves/decks are (name on the first element of the tuple, and amount on the 2nd)
	The program will find the optimal way to sleeve your cards (fully spending as many sleeves from each category as possible)
	Some trial and error with changing the order in which the appends are performed might lead to better final results
'''

sleeves = []
sleeves.append(("Old matte blue", 49))
sleeves.append(("White", 52))
sleeves.append(("Green", 57))
sleeves.append(("Turquoise", 63))
sleeves.append(("Red", 118))
sleeves.append(("Good matte", 128))
sleeves.append(("Blue Non-matte", 147))

decks = []
decks.append(("Fluffal", 9))
decks.append(("T.G", 24))
decks.append(("U.A", 28))
decks.append(("Metaphys", 30))
decks.append(("Zefra", 39))
decks.append(("Sylvan", 40))
decks.append(("Metalfoes", 40))
decks.append(("Vendread", 42))
decks.append(("Infernity", 63))

def getCombinations(sleeves, decks):
    combinations = []    #where we're saving our compositions at the end
    minSleevesLeft = 9999
    
    #iterate through each sleeve
    for s in sleeves:
        #iterate through each deck
        minPossibilities = []
        for d in decks:
            #if there are more cards in this deck than there are sleeves of this type
            if(d[1] > s[1]):
                continue
            else:
                #check if we get a new minimum
                testMinimum = s[1]-d[1]
                #if there's more than one minimum
                if testMinimum == minSleevesLeft:
                    #append new possibility object
                    minPossibilities.append((s[0], d[0], testMinimum))
                #if we find a new minimum which leaves us with less cards
                elif testMinimum < minSleevesLeft:
                    #set new minimum
                    minSleevesLeft = testMinimum
                    #reinitialize the minimum possibilities array
                    minPossibilities = []
                    #append this new minimum
                    minPossibilities.append((s[0], d[0], testMinimum))
        
        #save this sleeve's possibilities
        for p in minPossibilities:
            combinations.append(p)

    #check the possibilities calculated and only keep the most minimized ones
    minimum = 99999
    for c in combinations:
        if c[2] < minimum:
            minimum = c[2]
    
    returning = []

    for c in combinations:
        if c[2] == minimum:
            returning.append(c)

    return returning

combinations = getCombinations(sleeves, decks)
for c in combinations:
    print("{}/{} - {} left".format(c[0], c[1], c[2]))
