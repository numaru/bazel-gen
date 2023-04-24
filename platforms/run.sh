docker run -u 1000:1000 -v $(dirname $0)/cache:/data \
	-p 9090:8080 -p 9092:9092 buchgr/bazel-remote-cache