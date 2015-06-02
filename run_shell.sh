#! /bin/bash

[ -f run_common.sh ] && . run_common.sh

echo "Running shell inside image '$IMAGE_NAME'"
docker run $PARAMETERS "$IMAGE_NAME" /bin/bash

