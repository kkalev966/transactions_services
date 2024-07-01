from external_adapters.kafka.kafka_service import KafkaService

transaction_service = KafkaService('4.210.33.181:9094').create_producer()

    