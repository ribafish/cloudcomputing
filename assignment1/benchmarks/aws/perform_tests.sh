
CAPTURE_DATE=$(date +%Y-%m-%d:%H:%M:%S)

echo "Performing CPU Benchmark ..."
./linpack \
| tail -1 \
| awk '{print $6}' \
> "cpu_benchmark_${CAPTURE_DATE}.out"

echo "Performing Memory Benchmark ..."
(./memsweep || true) \
| awk '{print $5}' \
> "memory_benchmark_${CAPTURE_DATE}.out"

echo "Performing Disk Benchmark ..."

echo "  - seq read"
DISK_OPERATION="read"
fio --name=$DISK_OPERATION --iodepth=1 --rw=$DISK_OPERATION \
--bs=4k --direct=0 --size=64M --numjobs=4 --runtime=240 \
--group_reporting \
> "disk_benchmark_${DISK_OPERATION}_${CAPTURE_DATE}.out"

rm "${DISK_OPERATION}."*


echo "  - seq write"
DISK_OPERATION="write"
fio --name=$DISK_OPERATION --iodepth=1 --rw=$DISK_OPERATION \
--bs=4k --direct=0 --size=64M --numjobs=4 --runtime=240 \
--group_reporting \
> "disk_benchmark_${DISK_OPERATION}_${CAPTURE_DATE}.out"

rm "${DISK_OPERATION}."*

echo "  - seq read & write"
DISK_OPERATION="readwrite"
fio --name=$DISK_OPERATION --iodepth=1 --rw=$DISK_OPERATION \
--bs=4k --direct=0 --size=64M --numjobs=4 --runtime=240 \
--group_reporting \
> "disk_benchmark_${DISK_OPERATION}_${CAPTURE_DATE}.out"

rm "${DISK_OPERATION}."*


echo "  - rand read"
DISK_OPERATION="randread"
fio --name=$DISK_OPERATION --iodepth=1 --rw=$DISK_OPERATION \
--bs=4k --direct=0 --size=64M --numjobs=4 --runtime=240 \
--group_reporting \
> "disk_benchmark_${DISK_OPERATION}_${CAPTURE_DATE}.out"

rm "${DISK_OPERATION}."*


echo "  - rand write"
DISK_OPERATION="randwrite"
fio --name=$DISK_OPERATION --iodepth=1 --rw=$DISK_OPERATION \
--bs=4k --direct=0 --size=64M --numjobs=4 --runtime=240 \
--group_reporting \
> "disk_benchmark_${DISK_OPERATION}_${CAPTURE_DATE}.out"

rm "${DISK_OPERATION}."*


echo "  - rand read & write"
DISK_OPERATION="randrw"
fio --name=$DISK_OPERATION --iodepth=1 --rw=$DISK_OPERATION \
--bs=4k --direct=0 --size=64M --numjobs=4 --runtime=240 \
--group_reporting \
> "disk_benchmark_${DISK_OPERATION}_${CAPTURE_DATE}.out"

rm "${DISK_OPERATION}."*











