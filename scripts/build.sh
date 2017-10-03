if [ -z "$(docker image ls | grep ${IMAGE_NAME})" ] ; then
	(
        cp -Rf dotfiles ./dockerfiles/${IMAGE_NAME} \
        && docker build -t $IMAGE_NAME -f ./dockerfiles/${IMAGE_NAME}/Dockerfile ./ \
        && rm -rf ./dockerfiles/${IMAGE_NAME}/dotfiles
    )
fi
