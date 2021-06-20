FROM ubuntu:20.04

RUN apt-get update
RUN apt-get install -y default-jre curl

ENV DOWNLOAD_URL https://download.knime.org/analytics-platform/linux/knime_4.2.5.linux.gtk.x86_64.tar.gz
ENV INSTALLATION_DIR /usr/local
ENV KNIME_DIR $INSTALLATION_DIR/knime_4.2.5
ENV HOME_DIR /home/knime
ENV WORKSPACE=/root/knime-workspace
ENV KNIME_PLUGINS_URL https://update.knime.com/analytics-platform/4.2

RUN curl -L "$DOWNLOAD_URL" | tar vxz -C $INSTALLATION_DIR
RUN  $KNIME_DIR/knime -application org.eclipse.equinox.p2.director \
     -i org.knime.features.base.feature.group -r $KNIME_PLUGINS_URL

RUN mkdir $WORKSPACE

COPY ./test-docker.zip $WORKSPACE

CMD $KNIME_DIR/knime --launcher.suppressErrors -nosave -reset -nosplash \
         -application org.knime.product.KNIME_BATCH_APPLICATION \
         -workflowFile=$WORKSPACE/test-docker.zip