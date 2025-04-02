from sympy import *
m = Matrix([
        [.85, -.15, -.7, 0, 0],
        [-.15, .8, -.4, -.25, 0],
        [-.1, -.1, .45, -.25, 0],
        [-.25, -.1, -.4, .75, 0]])
M_rref = m.rref()
print("The Row echelon form of matrix M and the pivot columns : {}".format(M_rref))
