# Build, Deploy, and Automate a Go App with Docker, Kubernetes, and CI/CD for Cronjobs

This repository illustrates how to create a simple Go application, containerize it using Docker, schedule it as a Kubernetes CronJob, and set up a CI/CD pipeline for automated deployment.

## Project Overview

- **Application**: A simple Go application that logs a message.
- **Containerization**: Uses Docker to build and manage the application image.
- **Orchestration**: Schedules the app using Kubernetes CronJob.
- **CI/CD Pipeline**: Automates building and deploying the application using GitHub Actions.

## Prerequisites

1.	Docker installed and configured.
2.	Kubernetes cluster with kubectl configured.

## Steps to Run Locally

1.	Build and Run the Go Application

```bash
go run cron_app.go
```

2.	Build the Docker Image

```bash
docker build -t <your-dockerhub-username>/go-cronjob:latest .
````

3.	Push the Docker Image

```bash
docker push <your-dockerhub-username>/go-cronjob:latest
````

4.	Deploy the Kubernetes CronJob

```bash
kubectl apply -f chart/cronjob.yaml
```

## Dockerfile

The Dockerfile is crucial for containerizing the Go application, ensuring it runs consistently across various environments. It uses a minimal Go image as the base, optimizing the container size. The application is built and executed within the container, making deployment seamless and environment-independent. This approach eliminates compatibility issues, as the container bundles the application, dependencies, and runtime together. The containerization also simplifies scaling and orchestration when deployed to Kubernetes.

## Kubernetes CronJob

The Kubernetes CronJob is defined in `chart/cronjob.yaml`. It runs the app on the first day of every month at midnight.

To deploy the CronJob:

```bash
kubectl apply -f chart/cronjob.yaml
```

To verify the CronJob:

```bash
kubectl get cronjobs
```

This Kubernetes configuration file defines a CronJob, which automates the execution of the containerized application at scheduled intervals. In this demo, the job runs on the 1st of every month at midnight, ensuring time-sensitive tasks are executed without manual intervention. By leveraging Kubernetes, the job benefits from resource management, fault tolerance, and scalability. Specifying resource requests and limits ensures the job runs efficiently without overloading the cluster. The restart policy further enhances reliability by retrying failed tasks automatically.

## CI/CD Pipeline

Workflow Overview

1.	**Trigger**: Runs on a push to the specified branch.
2.	**Steps**:
	•	Build and push Docker image to Docker Hub.
	•	Configure and deploy to Kubernetes.

The CI/CD pipeline file (GitHub Actions workflow) automates the build and deployment processes, streamlining development workflows. It ensures that every code change triggers the pipeline, which builds the Docker image, pushes it to Docker Hub, and deploys the CronJob to a Kubernetes cluster. This automation minimizes human error, accelerates deployments, and guarantees consistency. The use of GitHub Actions allows developers to integrate these steps into the existing version control system, improving collaboration and productivity across teams.