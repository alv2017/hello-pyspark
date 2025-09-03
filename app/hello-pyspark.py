import os
from pyspark.sql import SparkSession


def main():
    master_url = os.getenv("SPARK_MASTER_URL", default="local[*]")
    print("Spark Master URL:", master_url)

    spark = SparkSession.builder \
        .appName("HelloWorld") \
        .master(master_url) \
        .getOrCreate()

    numbers_rdd = spark.sparkContext.parallelize(range(1, 1000))
    count = numbers_rdd.count()
    print(f"Count of numbers from 1 to 1000 is: {count}")

    spark.stop()


if __name__ == "__main__":
    main()
