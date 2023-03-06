"""Example application."""

# Standard library imports
# n/a

# Third party imports
from fastapi import FastAPI

# Local application imports
from .data.metadata import success


# Create an application
the_app = FastAPI()


@the_app.get("/")
def welcome() -> dict:
    """Welcome.

    Returns:
        dict: Welcome message
    """
    return {"message": "Your application works, congratulations!"}


@the_app.get("/check")
def check() -> dict:
    """Welcome.

    Returns:
        dict: Welcome message
    """
    return {"success": success}


if __name__ == "__main__":

    import uvicorn

    uvicorn.run(the_app, host="0.0.0.0", port=8000)
