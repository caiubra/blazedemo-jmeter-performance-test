# Teste de Performance BlazeDemo com JMeter

## Descrição

Este projeto contém um conjunto de testes de performance desenvolvidos com Apache JMeter para simular o fluxo de compra de passagens aéreas no site BlazeDemo (https://www.blazedemo.com). O objetivo é avaliar a capacidade do sistema de suportar uma carga específica e identificar possíveis gargalos de performance.

## Pré-requisitos

Para executar os testes, você precisará ter instalado:

* **Java Development Kit (JDK)**: Versão 8 ou superior.
* **Apache JMeter**: Versão 5.5 ou superior.

## Como Executar

1. **Clone o repositório** (se estiver em um ambiente local):

&#x20;   ```bash
    git clone https://github.com/caiubra/blazedemo-jmeter-performance-test

&#x20;   cd blazedemo\_jmeter
    ```

2. **Navegue até o diretório do projeto**:

&#x20;   ```bash
    cd blazedemo\_jmeter
    ```

3. **Execute o teste de carga**:

&#x20;   ```bash
    ./run\_load\_test.sh
    ```

   Este comando executará o teste de carga, gerará um arquivo `.jtl` com os resultados brutos e um relatório HTML completo no diretório `./report/load\_test\_report`.

4. **Execute o teste de pico**:

   &#x20;   ```bash
    ./run\_peak\_test.sh
    ```

   Este comando executará o teste de pico, gerará um arquivo `.jtl` com os resultados brutos e um relatório HTML completo no diretório `./report/peak\_test\_report`.

   ## Cenário Testado

   O cenário de teste simula um fluxo completo de compra de passagem aérea com sucesso, abrangendo as seguintes etapas:

1. **GET /**: Acessa a página inicial para selecionar a origem e o destino.
2. **POST /reserve.php**: Envia os dados de origem e destino para encontrar voos disponíveis e seleciona um voo.
3. **POST /purchase.php**: Preenche os dados do comprador e do cartão de crédito para efetuar a compra.
4. **POST /confirmation.php**: Confirma a compra e exibe a mensagem de sucesso.

   **Correlação de Dados**: Valores dinâmicos como `flight`, `price`, `airline` e `\_token` são extraídos das respostas anteriores e reutilizados nas requisições subsequentes para garantir a integridade do fluxo.

   **Assertions**: Uma asserção é utilizada na requisição `/purchase.php` para validar a mensagem de sucesso "Thank you for your purchase!".

   ## Configurações dos Testes

   ### Teste de Carga

* **Usuários**: 250
* **Duração**: 5 minutos (300 segundos)
* **Ramp-up**: 60 segundos
* **Throughput Alvo**: 250 requisições por segundo (RPS) sustentado, configurado via `Constant Throughput Timer`.

  ### Teste de Pico

* **Usuários**: 500
* **Duração**: 2 minutos (120 segundos)
* **Ramp-up**: 60 segundos (rápido)
* **Throughput Alvo**: 250 requisições por segundo (RPS) sustentado, configurado via `Constant Throughput Timer`.

  ## Resultados Ilustrativos e Análise

  **Observação Importante**: Os resultados abaixo são **ilustrativos** e baseados nos critérios de aceitação fornecidos. Para obter resultados reais, os testes devem ser executados em um ambiente adequado.

  ### Critérios de Aceitação

* **Throughput**: 250 requisições por segundo (RPS)
* **Percentil 90**: < 2 segundos
* **Taxa de Erro**: 0%

  ### Análise Esperada

  Após a execução dos testes, o relatório HTML gerado pelo JMeter (localizado em `report/load\_test\_report` e `report/peak\_test\_report`) fornecerá as seguintes métricas chave:

|Métrica|Descrição|Valor Esperado (Teste de Carga)|Valor Esperado (Teste de Pico)|
|-|-|-|-|
|**Throughput**|Número de requisições por segundo que o servidor consegue processar.|\~250 RPS|\~250 RPS|
|**Percentil 90**|90% das requisições foram concluídas dentro deste tempo.|< 2 segundos|< 2 segundos|
|**Error %**|Porcentagem de requisições que resultaram em erro.|0%|0%|

### Conclusão (Baseada em Resultados Ilustrativos)

Com base nos resultados ilustrativos, se o Throughput atingir ou se aproximar de 250 RPS, o Percentil 90 for menor que 2 segundos e a taxa de erro for 0%, o critério de aceitação será **atendido**. Caso contrário, o sistema não atendeu aos requisitos de performance.

### Possíveis Gargalos

Em um cenário real, se os critérios não forem atendidos, os gargalos podem estar relacionados a:

* **Recursos do Servidor**: CPU, memória, disco, rede.
* **Banco de Dados**: Consultas lentas, falta de índices, pool de conexões insuficiente.
* **Aplicação**: Código ineficiente, problemas de concorrência, uso excessivo de recursos.
* **Infraestrutura de Rede**: Latência, largura de banda.

### Limitações

* **Teste Local**: A execução dos testes em uma máquina local pode introduzir limitações de recursos (CPU, memória, rede) que podem distorcer os resultados em comparação com um ambiente de teste dedicado ou de produção.
* **Dados Fixos**: Embora a correlação de dados dinâmicos seja implementada, alguns dados de entrada (como informações de cartão de crédito) são fixos. Em um teste mais avançado, esses dados poderiam ser parametrizados para simular uma variedade maior de cenários.

## Estrutura do Repositório

```
blazedemo\_jmeter/
├── test/
│   ├── blazedemo\_load\_test.jmx
│   └── blazedemo\_peak\_test.jmx
├── report/
├── run\_load\_test.sh
├── run\_peak\_test.sh
└── README.md
```

## Observações Finais

Este projeto demonstra a capacidade de criar testes de performance robustos e bem estruturados com JMeter, incluindo a manipulação de dados dinâmicos e a geração de relatórios detalhados. A análise dos resultados é crucial para identificar áreas de melhoria e garantir que a aplicação atenda aos requisitos de performance.

