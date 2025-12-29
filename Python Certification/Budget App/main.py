class Category:
    
    def __init__(self, name):
        self.name = name
        self.ledger = []
        
    def deposit(self, amount, description = ""):
        if amount < 0:
            return False
        else:
            obj_deposit = {'amount': amount, 'description': description}
            self.ledger.append(obj_deposit)
    
    def withdraw(self, amount, description = ""):
        if not self.check_funds(amount):
            return False
        else:
            obj_deposit = {'amount': -amount, 'description': description}
            self.ledger.append(obj_deposit)
            return True
    
    def get_balance(self):
        balance = 0
        for transaction in self.ledger:
            balance += transaction['amount']
        
        return balance
    
    def transfer(self, amount, obj_cat):
        if not self.check_funds(amount):
            return False
        else:
            self.withdraw(amount, f"Transfer to {obj_cat.name}")
            obj_cat.deposit(amount, f"Transfer from {self.name}")
            return True
    
    def check_funds(self, amount):
        if not amount > self.get_balance():
            return True
        else:
            return False
        
    def __str__(self):
        title = self.name.center(30, "*")

        items = ""
        for entry in self.ledger:
            desc = f"{entry['description'][:23]:23}"
            amt = f"{entry['amount']:>7.2f}"
            items += f"{desc}{amt}\n"

        total = f"Total: {self.get_balance():.2f}"

        return f"{title}\n{items}{total}"
        
    
def create_spend_chart(categories):
    # 1. Calculate totals and percentages
    spending = []
    for cat in categories:
        spent = sum(item['amount']
                    for item in cat.ledger if item['amount'] < 0)
        spending.append(abs(spent))

    total_spent = sum(spending)
    # Avoid division by zero if nothing was spent
    if total_spent == 0:
        percentages = [0] * len(spending)
    else:
        # Calculate percentage and round down to nearest 10
        percentages = [(s / total_spent * 100) // 10 * 10 for s in spending]

    # 2. Build the chart (Top-Down)
    res = "Percentage spent by category\n"

    for i in range(100, -1, -10):
        res += f"{str(i).rjust(3)}| "
        for p in percentages:
            res += "o  " if p >= i else "   "
        res += "\n"

    # 3. Horizontal line
    res += "    " + "-" * (len(categories) * 3 + 1) + "\n"

    # 4. Vertical names
    names = [cat.name for cat in categories]
    max_len = max(len(name) for name in names)

    for i in range(max_len):
        res += "     "
        for name in names:
            if i < len(name):
                res += f"{name[i]}  "
            else:
                res += "   "
        if i < max_len - 1:
            res += "\n"

    return res
