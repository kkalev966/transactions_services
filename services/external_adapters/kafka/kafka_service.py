from kafka import KafkaProducer, KafkaConsumer
from kafka.errors import KafkaError
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

class KafkaService:

    producer: KafkaProducer
    consumer: KafkaProducer
    __consumed_msgs: list = []
    bootstrap_server: str

    def __init__ (self, bootstrap_server: str) -> "KafkaService":
        self.bootstrap_server = bootstrap_server
    
    @property
    def consumed_msgs(self) -> list:
        return self.__consumed_msgs

    def create_producer(self) -> "KafkaService":
        self.producer = KafkaProducer(bootstrap_servers=self.bootstrap_server, api_version=(2, 5, 0))
        return self
    
    def create_consumer(self, topic: str) -> "KafkaService":
        self.consumer = KafkaConsumer(
                                    topic,
                                    bootstrap_servers=self.bootstrap_server,
                                    auto_offset_reset='earliest',
                                    enable_auto_commit=False
                                )
        return self
        
    def produce_message(self, topic: str, msg: str) -> None:
        try:
            future = self.producer.send(topic, value=msg.encode('utf-8'))
            result = future.get(timeout=1)
            logger.info(f"Produced message: {msg} to topic: {topic} with result: {result}")
        except KafkaError as e:
            logger.error(f"Failed to produce message: {e}")
    
    def consume_messages(self) -> None:
        try:
            for message in self.consumer:
                logger.info(f"Consumed message: {message.value.decode('utf-8')}")
                self.__consumed_msgs.append(message)
        except KeyboardInterrupt:
            logger.error("Stopping consumer...")
        finally:
            self.consumer.close()



