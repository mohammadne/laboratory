"""A small, realistic class design you can read from top to bottom.

Run: python3 order_system.py

This file deliberately uses common patterns found in application codebases.
Read the companion README after (or while) running it.
"""

from __future__ import annotations

from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from decimal import Decimal
from functools import wraps
from typing import Callable, Protocol


def log_call(method: Callable) -> Callable:
    """A decorator that adds behavior *around* an existing method.

    ``@log_call`` is shorthand for ``method = log_call(method)``.  ``wraps``
    preserves the original method's name and docstring for debuggers/tools.
    """

    @wraps(method)
    def wrapper(*args, **kwargs):
        print(f"-> calling {method.__qualname__}")
        return method(*args, **kwargs)

    return wrapper


@dataclass(frozen=True)
class Product:
    """A value object: data with a few rules, rather than much behavior.

    ``@dataclass`` generates __init__, __repr__, and __eq__ for us.
    ``frozen=True`` makes instances immutable after construction.
    """

    name: str
    unit_price: Decimal

    def __post_init__(self) -> None:
        # Dataclasses call this after their generated __init__.
        if self.unit_price < 0:
            raise ValueError("A price cannot be negative")


@dataclass
class LineItem:
    """One product and its quantity in an order."""

    product: Product
    quantity: int

    def __post_init__(self) -> None:
        if self.quantity <= 0:
            raise ValueError("Quantity must be positive")

    @property
    def total(self) -> Decimal:
        # A property lets callers use item.total rather than item.total().
        # It is computed each time and is read-only because there is no setter.
        return self.product.unit_price * self.quantity


class Discount(ABC):
    """An abstract base class: a contract for all discount implementations."""

    @abstractmethod
    def amount_for(self, subtotal: Decimal) -> Decimal:
        """Return how much to subtract from a subtotal."""
        # No implementation: subclasses must provide one.


class PercentageDiscount(Discount):
    """A concrete subclass that satisfies the Discount contract."""

    def __init__(self, percentage: Decimal) -> None:
        if not Decimal("0") <= percentage <= Decimal("100"):
            raise ValueError("Percentage must be between 0 and 100")
        self.percentage = percentage  # An instance attribute.

    def amount_for(self, subtotal: Decimal) -> Decimal:
        return subtotal * self.percentage / Decimal("100")


class PaymentGateway(Protocol):
    """A structural interface used for dependency injection.

    Anything with a matching ``charge`` method is acceptable. It need not
    inherit from PaymentGateway. This keeps OrderService loosely coupled.
    """

    def charge(self, amount: Decimal) -> str: ...


class FakePaymentGateway:
    """A concrete dependency; production code might call Stripe instead."""

    def charge(self, amount: Decimal) -> str:
        return f"payment-{amount}"


class Order:
    """An entity: it has an identity and changes state over its lifetime."""

    # Class attribute: shared default/configuration, accessed as Order.tax_rate.
    tax_rate = Decimal("0.09")

    def __init__(self, order_id: str, items: list[LineItem]) -> None:
        self.order_id = order_id
        self.items = list(items)  # Copy so later caller list changes do not leak in.
        self._paid = False  # Leading underscore means "internal API" by convention.

    @property
    def is_paid(self) -> bool:
        """Expose internal state safely as read-only public data."""
        return self._paid

    @property
    def subtotal(self) -> Decimal:
        return sum((item.total for item in self.items), start=Decimal("0"))

    def total_after(self, discount: Discount | None = None) -> Decimal:
        """Use behavior supplied by another object (composition)."""
        discount_amount = discount.amount_for(self.subtotal) if discount else Decimal("0")
        taxable = self.subtotal - discount_amount
        return taxable * (Decimal("1") + self.tax_rate)

    @classmethod
    def empty(cls, order_id: str) -> Order:
        """Alternative constructor. ``cls`` means the class that called it."""
        return cls(order_id, [])

    @staticmethod
    def is_valid_order_id(order_id: str) -> bool:
        """A related helper; it needs neither an instance nor the class."""
        return order_id.startswith("ORD-") and len(order_id) > 4

    def __repr__(self) -> str:
        # Useful representations make logs and debuggers much easier to read.
        return f"Order(order_id={self.order_id!r}, items={len(self.items)}, paid={self._paid})"


class OrderService:
    """Coordinates objects instead of putting every concern in Order.

    This is an example of dependency injection: callers supply a gateway,
    making this service testable without a real network payment provider.
    """

    def __init__(self, gateway: PaymentGateway) -> None:
        self.gateway = gateway

    @log_call
    def pay(self, order: Order, discount: Discount | None = None) -> str:
        if order.is_paid:
            raise ValueError("Order was already paid")

        receipt = self.gateway.charge(order.total_after(discount))
        order._paid = True  # This service is trusted to change Order's internal state.
        return receipt


def main() -> None:
    keyboard = Product("Keyboard", Decimal("80.00"))
    cable = Product("USB cable", Decimal("10.00"))
    order = Order("ORD-100", [LineItem(keyboard, 1), LineItem(cable, 2)])

    print(order)  # Calls Order.__repr__ automatically.
    print("subtotal:", order.subtotal)
    print("total with 10% discount:", order.total_after(PercentageDiscount(Decimal("10"))))
    print("valid ID:", Order.is_valid_order_id(order.order_id))

    service = OrderService(FakePaymentGateway())
    print("receipt:", service.pay(order))
    print("paid:", order.is_paid)


if __name__ == "__main__":
    main()
