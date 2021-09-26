# import os
# import re
# import shutil

import itertools
from prettytable import PrettyTable
import re


class Gob(object):
    pass


class Truths(object):
    def __init__(self, base=None, phrases=None, ints=True):
        if not base:
            raise Exception('Base items are required')
        self.base = base
        self.phrases = phrases or []
        self.ints = ints

        # generate the sets of booleans for the bases
        self.base_conditions = list(itertools.product([False, True],
                                                      repeat=len(base)))

        # regex to match whole words defined in self.bases
        # used to add object context to variables in self.phrases
        self.p = re.compile(r'(?<!\w)(' + '|'.join(self.base) + ')(?!\w)')

    def calculate(self, *args):
        # store bases in an object context
        g = Gob()
        for a, b in zip(self.base, args):
            setattr(g, a, b)

        # add object context to any base variables in self.phrases
        # then evaluate each
        eval_phrases = []
        for item in self.phrases:
            item = self.p.sub(r'g.\1', item)
            eval_phrases.append(eval(item))

        # add the bases and evaluated phrases to create a single row
        row = [getattr(g, b) for b in self.base] + eval_phrases
        if self.ints:
            return [int(item) for item in row]
        else:
            return row

    def __str__(self):
        print(self.phrases)
        old = self.phrases[:]
        # self.phrases = ['Z = (X or V)', 'W = (Y or V)']
        # self.phrases = ['Z = (X or V)']
        self.phrases = ['W = (Y or V)']
        t = PrettyTable(self.base + self.phrases)
        self.phrases = old[:]
        for conditions_set in self.base_conditions:
            t.add_row(self.calculate(*conditions_set))
        return str(t)


# print(Truths(['X', 'Y', 'V'],['(X or V)', '(Y or V)']))
# print(Truths(['X', 'Y', 'V'],['(X or V)']))
print(Truths(['X', 'Y', 'V'],['(Y or V)']))


"""
Consider the following truth table where each row represents an event with probability 0.125 or 1/8: 

+---+---+---+--------------+--------------+
| X | Y | V | Z = (X or V) | W = (Y or V) |
+---+---+---+--------------+--------------+
| 0 | 0 | 0 |      0       |      0       |
| 0 | 1 | 0 |      0       |      1       |
| 0 | 1 | 1 |      1       |      1       |
| 1 | 0 | 0 |      1       |      0       |
| 0 | 0 | 1 |      1       |      1       |
| 1 | 0 | 1 |      1       |      1       |
| 1 | 1 | 0 |      1       |      1       |
| 1 | 1 | 1 |      1       |      1       |
+---+---+---+--------------+--------------+

First let's see if (X ⊥ Y | Z):

We have the truth table with only Z below

+---+---+---+--------------+
| X | Y | V | Z = (X or V) |
+---+---+---+--------------+
| 0 | 0 | 0 |      0       |
| 0 | 0 | 1 |      1       |
| 0 | 1 | 0 |      0       |
| 0 | 1 | 1 |      1       |
| 1 | 0 | 0 |      1       |
| 1 | 0 | 1 |      1       |
| 1 | 1 | 0 |      1       |
| 1 | 1 | 1 |      1       |
+---+---+---+--------------+

And the truth table with Z = 0

+---+---+---+------------------+
| X | Y | V | Z = (X or V) = 0 |
+---+---+---+------------------+
| 0 | 0 | 0 |        0         |
| 0 | 1 | 0 |        0         |
+---+---+---+------------------+

In the table above it is clear that Z=0 implies X=0 so clearly we have (X ⊥ Y | Z=0):

For the case where Z = 1, we see that when Y=0 we have same possible outcomes for X as when Y=1, as well as the same probabilities, it is 0.125 for each event in the table. 

So we can conclude that (X ⊥ Y | Z)

+---+---+---+--------------+
| X | Y | V | Z = (X or V) |
+---+---+---+--------------+
| 0 | 0 | 1 |      1       |
| 1 | 0 | 0 |      1       |
| 1 | 0 | 1 |      1       |
| 0 | 1 | 1 |      1       |
| 1 | 1 | 0 |      1       |
| 1 | 1 | 1 |      1       |
+---+---+---+--------------+

The argument for showing that (X ⊥ Y | W) is analogous to the one presented above for (X ⊥ Y | Z), just replace Z with W and Y with X where needed.

I have included the truth table for it below just in case you want to take a look:

+---+---+---+--------------+
| X | Y | V | W = (Y or V) |
+---+---+---+--------------+
| 0 | 0 | 0 |      0       |
| 0 | 0 | 1 |      1       |
| 0 | 1 | 0 |      1       |
| 0 | 1 | 1 |      1       |
| 1 | 0 | 0 |      0       |
| 1 | 0 | 1 |      1       |
| 1 | 1 | 0 |      1       |
| 1 | 1 | 1 |      1       |
+---+---+---+--------------+

Now back to the original full truth table, I am only showing the rows where (Z,W)=(1,1)

+---+---+---+--------------+--------------+
| X | Y | V | Z = (X or V) | W = (Y or V) |
+---+---+---+--------------+--------------+
| 0 | 0 | 1 |      1       |      1       |
| 1 | 0 | 1 |      1       |      1       |
| 1 | 1 | 0 |      1       |      1       |
| 1 | 1 | 1 |      1       |      1       |
+---+---+---+--------------+--------------+

We can see that P(X=1|Z,W=1)=0.75 but if we learn that Y=0 then our probability changes, we now have P(X=1|Y=0 and Z,W=1)=0.5
Therefore it does not hold that (X ⊥ Y | Z,W)


"""