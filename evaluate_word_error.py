
import sys


lines = sys.stdin.readlines()

symbol_count = 0
symbol_errors = 0
word_count = 0
word_errors = 0
for line in lines:
    symbol_errors_in_word = 0
    line = line.strip()
    #print(line)
    fields = line.split(" ")
    focus = fields[3]
    correct = fields[10]
    predicted = fields[11]
    nextchar = fields[4]

    if not correct == predicted:
        #print("%s" % line)
        symbol_errors_in_word += 1
        symbol_errors += 1

    symbol_count += 1

    if nextchar == "-":
        if symbol_errors_in_word > 0:
            word_errors += 1
        word_count += 1
        symbol_errors_in_word = 0


symbol_err_rate = (symbol_errors/float(symbol_count))*100
print("SYMBOL COUNT: %d\nERRORS: %d\nRATE: %.2f\n" % (symbol_count, symbol_errors, symbol_err_rate))

word_err_rate = (word_errors/float(word_count))*100.0
print("WORD COUNT: %d\nERRORS: %d\nRATE: %.2f" % (word_count, word_errors, word_err_rate))
