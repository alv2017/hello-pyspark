# Hello Pyspark

## Project Goals
- Demonstrate how to run a PySpark application locally
- Run a sample application `hell-pyspark.py` inside the sandbox

## Running the PySpark Application on a Local Machine

In order to run the PySpark application on a local computer, 
you need to install `pyspark` package. After that you can run your 
code as a regular Python script. In our case:

```bash
    python app/hello-pyspark.py 
````

## Running the PySpark Application inside a Docker Container

The reference files for Docker setup are:
- `Dockerfile` - the file that contains instructions to build a Docker image
- `docker-compose.yml` - the file that contains instructions to run a Spark cluster inside a Docker container

In order to run the PySpark application inside a dockerized Spark cluster, take the following steps:
1) Start the Spark cluster (sandbox):

```bash
    docker compose up --build
```
or you can also start a Spark cluster with multiple worker nodes:
```bash
    docker compose up --build --scale spark-worker=3
```

2) Execute the PySpark application inside the master node:
```bash
    docker exec -it spark-master python /app/hello-pyspark.py 
```

Comment: the `Spark` dashboard is available at http://localhost:8080


## Emulating a Remote Spark Cluster using Docker (Experimental)

This an attempt to emulate a communication with a remote Spark cluster using Docker. :-)

The reference files for Docker setup are:
- `Dockerfile` - the file that contains instructions to build a Docker image
- `docker-compose-experimental.yml` - the file that contains instructions to run a Spark cluster and 
cluster network inside a Docker container.


## Start the PySpark Cluster (Sandbox)
1) Spark cluster with one master and one worker node:
```bash
    docker compose -f docker-compose-experimental.yml up --build
```
or you can also start a Spark cluster with multiple worker nodes:

```bash
    docker compose -f docker-compose-experimental.yml up --build --scale spark-worker=3
```

Now we can demonstrate how to run the PySpark application that connects to a remote Spark cluster:

```
export SPARK_MASTER_URL=spark://spark-master:7077 SPARK_LOCAL_IP=172.25.0.1
python app/hello-pyspark.py
```

We are running the code from the local machine. Our local machine serves as a driver in the Spark cluster.
1) In order to run our code we need to provide SPARK_MASTER_URL environment variable. This variable will
be passed into the application code app/hello-pyspark.py. So we can be sure that we are running the code
on a Spark Master node. Please note that this time we are running the code from our local machine, not
from inside the Docker container.

2) We also provide SPARK_LOCAL_IP environment variable. This variable is optional, if you don't provide it,
the application still will be able to run. By setting that variable we make sure that the driver (our computer) 
can communicate with the Spark cluster, and its IP address is in the same subnet as the Docker network.


Comment: the `Spark` dashboard is available at http://localhost:8080

#### Firewall

In some cases you may need to open firewall for the Docker network. 

For example, on Linux you can use the following commands (the firewall settings will be lost after a reboot):

```
sudo iptables -A INPUT -s 172.25.0.0/24 -j ACCEPT
sudo iptables -A OUTPUT -d 172.25.0.0/24 -j ACCEPT
```
