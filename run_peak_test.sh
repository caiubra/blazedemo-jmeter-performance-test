#!/bin/bash

echo "Iniciando Teste de Pico..."
jmeter -n -t /home/ubuntu/blazedemo_jmeter/test/blazedemo_peak_test.jmx -l /home/ubuntu/blazedemo_jmeter/report/peak_test_results.jtl -e -o /home/ubuntu/blazedemo_jmeter/report/peak_test_report

echo "Teste de Pico Concluído. Relatório gerado em /home/ubuntu/blazedemo_jmeter/report/peak_test_report"
