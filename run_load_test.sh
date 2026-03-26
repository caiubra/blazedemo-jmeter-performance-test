#!/bin/bash

echo "Iniciando Teste de Carga..."
jmeter -n -t /home/ubuntu/blazedemo_jmeter/test/blazedemo_load_test.jmx -l /home/ubuntu/blazedemo_jmeter/report/load_test_results.jtl -e -o /home/ubuntu/blazedemo_jmeter/report/load_test_report

echo "Teste de Carga Concluído. Relatório gerado em /home/ubuntu/blazedemo_jmeter/report/load_test_report"
