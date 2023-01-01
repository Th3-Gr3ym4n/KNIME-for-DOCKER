FROM ubuntu:20.04

RUN apt-get update && apt-get install -y --no-install-recommends default-jre curl python3 python3-pip
ENV DOWNLOAD_URL https://download.knime.org/analytics-platform/linux/knime_4.5.2.linux.gtk.x86_64.tar.gz
ENV KNIME_PLUGINS_URL https://update.knime.com/analytics-platform/4.5
ENV INSTALLATION_DIR /usr/local
ENV KNIME_DIR $INSTALLATION_DIR/knime_4.5.2
ENV HOME_DIR /home/knime
ENV PYCARET /home/pycaret
ENV WORKSPACE=/root/knime-workspace
RUN curl -L "$DOWNLOAD_URL" | tar vxz -C $INSTALLATION_DIR
RUN mkdir $WORKSPACE && mhdir $PYCARET
COPY ./requirements.txt ./ubuntu-pref.epf $WORKSPACE
RUN $KNIME_DIR/knime -application org.eclipse.equinox.p2.director \ 
-i org.knime.features.base.feature.group -r $KNIME_PLUGINS_URL
RUN pip3 install -r /root/knime-workspace/requirements.txt
COPY ./pycaret.zip $WORKSPACE

CMD $KNIME_DIR/knime --launcher.suppressErrors -nosave -reset -nosplash \ 
-application org.knime.product.KNIME_BATCH_APPLICATION \ 
-workflowFile=$WORKSPACE/pycaret.zip