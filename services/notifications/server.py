import sys
import os

project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.append(project_root)

from external_adapters.kafka.kafka_service import KafkaService

import asyncio


notifications_producer = KafkaService('4.210.33.181:9094').create_producer()
authentication_consumer = KafkaService('4.210.33.181:9094').create_consumer("authentication-dev")
transactions_consumer = KafkaService('4.210.33.181:9094').create_consumer("transactions-dev")





async def main():
    # queue = asyncio.Queue()
    # n = 10

    producer_task = asyncio.create_task()
    consumer_task = asyncio.create_task()

    await asyncio.gather(producer_task, consumer_task)

if __name__ == '__main__':
    asyncio.run(main())