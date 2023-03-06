# See the list of official Docker base images for python: https://hub.docker.com/_/python
ARG BASE_IMAGE=python:3.10-slim-buster

FROM $BASE_IMAGE

# Set the directory where commands such as COPY will run from
WORKDIR /user

# Copy: ./requirements.txt (in your project)
# To: /user/requirements.txt (in the Docker image)
# This is then cached and only rebuilt if the requirements.txt changes
COPY requirements.txt requirements.txt

# Install the requirements.txt from the working directory
RUN pip install -r requirements.txt

# Copy everything from app directory (excluding subdirectories and files in .dockerignore) to /user/app in the Docker image
COPY app app

# Run the application
CMD ["python", "-m", "app.main"]

# The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime. 
# EXPOSE does not make the ports of the container accessible to the host.
EXPOSE 8000
