"""The smallest possible API test."""

from fastapi.testclient import TestClient


def test_health_check(client: TestClient) -> None:
    # Arrange is handled by the fixture; Act by making an HTTP-style request.
    response = client.get("/health")

    # Assert both the HTTP contract and the decoded JSON response body.
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}

