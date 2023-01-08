#!/bin/bash
echo "$(date): executed script" >> /var/log/cron.log 2>&1
/usr/local/knime_4.4.4/knime --launcher.suppressErrors -nosave -reset -nosplash -application org.knime.product.KNIME_BATCH_APPLICATION -workflowFile=/root/knime-workspace/pycaret-demo.zip