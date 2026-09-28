# Classes in Python: prepare to read a real codebase

Start by running the example:

```bash
cd /Users/mohammadne/Workspace/personal/laboratory/python/classes_lesson
python3 order_system.py
```

Then read [`order_system.py`](order_system.py) from top to bottom. It models an order checkout without distracting framework code.

## The core model

A **class** is a blueprint; an **instance** (or object) is a particular value made from it.

```python
order = Order("ORD-100", [])  # calls Order.__init__
order.order_id                 # instance attribute
order.total_after()            # instance method; Python passes order as self
```

`self` is the object on which a method was called. `Order.total_after(order)` and `order.total_after()` are effectively the same call; use the second form.

Attributes may live on an instance (`order.order_id`) or the class (`Order.tax_rate`). Do not put mutable values such as `[]` or `{}` in a class attribute unless you intentionally want all instances to share it.

## How to recognize common class forms

| Pattern | What it means | Example in the lesson |
|---|---|---|
| Plain class | State plus behavior | `Order`, `OrderService` |
| Dataclass | Mostly data; boilerplate methods generated | `Product`, `LineItem` |
| Value object | Often immutable and compared by contents | `Product` |
| Entity | Has identity and state over time | `Order` |
| Service | Coordinates other objects | `OrderService` |
| Abstract base class | Explicit contract subclasses must implement | `Discount` |
| Protocol | Contract based on methods, no inheritance required | `PaymentGateway` |

## Methods and decorators

Every `def` inside a class becomes a method, but its first parameter tells you what kind.

```python
def method(self): ...          # needs one specific object
@classmethod
def build(cls): ...            # needs the class; often an alternative constructor
@staticmethod
def validate(value): ...       # related helper; needs neither
@property
def total(self): ...           # read like data: object.total, not object.total()
```

A decorator starts with `@` and transforms the definition below it. Read `@decorator` as `thing = decorator(thing)`. In `OrderService.pay`, `@log_call` wraps the method to print before its original code runs. `@wraps` is important in production decorators because it preserves names, documentation, and debugging metadata.

`@dataclass` is also a decorator. It generates routine methods such as `__init__`, `__repr__`, and (normally) `__eq__`. The `__post_init__` method is where validation can run after the generated initializer. `frozen=True` prevents later attribute assignment.

## Encapsulation and properties

Python uses a convention, not enforced privacy: a leading underscore (`_paid`) means “internal; do not depend on this from unrelated code.” A `property` provides a stable public API around internals:

```python
@property
def is_paid(self) -> bool:
    return self._paid
```

Callers write `order.is_paid`. Later, its implementation can change without changing callers. A property can also define a setter with `@name.setter` when assignment needs validation.

## Relationships between classes

**Inheritance** means “is a”: `PercentageDiscount` is a `Discount`. It overrides `amount_for`, the behavior promised by the abstract base class. If overriding while retaining parent behavior, call `super()`.

**Composition** means “has/uses a”: an `Order` has `LineItem` instances and uses a `Discount`; `OrderService` uses a `PaymentGateway`. Prefer composition for most application behavior because the collaborators can be replaced in tests or configuration.

**Dependency injection** is simply passing a dependency in, as `OrderService(FakePaymentGateway())` does. It avoids hard-coding a database, API, or queue inside the service.

## Special (“dunder”) methods

Names with double underscores integrate a class with Python syntax:

- `__init__`: initialize a new instance
- `__repr__`: developer-friendly representation used by `print` here
- `__eq__`: equality (`==`); dataclasses generate it
- `__iter__`: enables `for x in object`
- `__len__`: enables `len(object)`
- `__enter__` / `__exit__`: enables `with object:`

Do not write these just because they exist. Implement one when its corresponding syntax makes the class genuinely clearer.

## A practical codebase-reading workflow

1. Find object creation sites (`ClassName(`) and inspect `__init__`; that reveals required dependencies and state.
2. Read the public methods first (those without `_`), their type hints, and their callers. Treat them as the class’s API.
3. Trace collaborators: constructor parameters and attributes such as `self.gateway` tell you which other classes matter next.
4. Check base classes and decorators. A framework may add major behavior there—routes, validation, serialization, ORM fields, retrying, or caching.
5. Identify state changes: assignments to `self.*`, calls to external systems, and exception paths. Those are usually the important logic.
6. Use tests as executable examples. They show normal use, edge cases, and which behavior is intentional.

## Things that often confuse newcomers

- Type hints describe intent and help tools, but Python does not enforce most of them at runtime.
- A method with no `self` is not automatically static; it must use `@staticmethod` (or accept `self`).
- `isinstance(value, BaseClass)` only works for inheritance-style contracts; a `Protocol` is usually for type checkers.
- Mutable default arguments are dangerous: use `None`, then create the list/dict inside `__init__`.
- Avoid deep inheritance trees. When behavior comes from several mixins, always inspect the method resolution order (`Class.mro()`).
