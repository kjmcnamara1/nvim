import time
from dataclasses import dataclass


@dataclass
class Project:
    name: str
    language: str
    stars: int

    def is_popular(self):
        return self.stars > 1000


repo = Project("neovim", "C/Lua", 75000)
print(repo)  # Project(name='neovim', language='C/Lua', stars=75000)

# Create a list of squares for even numbers only
numbers = range(10)
squares = [x**2 for x in numbers if x % 2 == 0]

# Modern string formatting (f-strings)
name = "Gemini"
print(f"Hello, {name}!")
print(f"Calculated squares: {squares}")

user_counts = {"admin": 5, "editor": 12, "guest": 104}

for role, count in user_counts.items():
    if count > 50:
        status = "High Traffic"
    else:
        status = "Normal"
    print(f"Role: {role:8} | Status: {status}")


def fibonacci_gen(limit):
    a, b = 0, 1
    while a < limit:
        yield a
        a, b = b, a + b


# This computes values one by one, saving memory
for num in fibonacci_gen(100):
    print(num, end=" ")


def timer(func):
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()
        print(f"Execution time: {end - start:.4f}s")
        return result

    return wrapper


@timer
def heavy_computation():
    return sum(i**2 for i in range(10**6))


heavy_computation()
