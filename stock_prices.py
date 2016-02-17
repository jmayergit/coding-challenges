# stock_prices_yesterday = [10, 7, 5, 8, 11, 9]
#
# get_max_profit(stock_prices_yesterday)
# returns 6 (buying for $5 and selling for $11)


import time


# quadratic complexity
# average of 10 time trials on an array of length 500
# 0.06772269010543823
def max_profit(stock_prices_yesterday):
    max_profit = None

    for i in range(len(stock_prices_yesterday) -1):
        buy = stock_prices_yesterday[i]
        j = i +1

        while j < len(stock_prices_yesterday):
            sell = stock_prices_yesterday[j]
            profit = sell - buy
            if (max_profit is None) or (max_profit < profit):
                max_profit = profit

            j +=1

    return max_profit

# linear complexity
# average of 10 time trials on an array of length 500
# 0.00039359331130981443
def max_profit_2(stock_prices_yesterday):
    buy = None

    max_profit = None

    for stock in stock_prices_yesterday:
        if buy is None:
            buy = stock
        elif max_profit is None:
            max_profit = stock - buy
        else:
            profit = stock - buy
            max_profit = max(max_profit, profit)

            buy = min(stock, buy)

    return max_profit


def timer(function, parameter):
    start = time.time()
    function(parameter)
    return time.time() - start

def time_trials(n, function, parameter):
    average = None
    for i in range(n):
        time = timer(function, parameter)
        if average is None:
            average = time
        else:
            average += time

    if average is None:
        return average
    else:
        return average / n
