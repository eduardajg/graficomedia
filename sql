# ============================================================
# ATIVIDADE - ANÁLISE DE DADOS DE VENDAS
# SQLite + Pandas + Matplotlib + Seaborn
# ============================================================

# Importação das bibliotecas
import sqlite3
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# ============================================================
# PASSO 1 - CONEXÃO COM O BANCO DE DADOS
# ============================================================

# Cria uma conexão com o banco de dados SQLite
# Caso o arquivo não exista, ele será criado.
conexao = sqlite3.connect('dados_vendas.db')

# Cria o cursor para executar comandos SQL
cursor = conexao.cursor()

# Cria a tabela de vendas, caso ela ainda não exista
cursor.execute('''
CREATE TABLE IF NOT EXISTS vendas1 (
    id_venda INTEGER PRIMARY KEY AUTOINCREMENT,
    data_venda DATE,
    produto TEXT,
    categoria TEXT,
    valor_venda REAL
)
''')

# ============================================================
# INSERÇÃO DOS DADOS
# ============================================================

# Insere os dados de vendas na tabela
cursor.executemany('''
INSERT INTO vendas1
(data_venda, produto, categoria, valor_venda)
VALUES (?, ?, ?, ?)
''', [
    ('2023-01-01', 'Produto A', 'Eletrônicos', 1500.00),
    ('2023-01-05', 'Produto B', 'Roupas', 350.00),
    ('2023-02-10', 'Produto C', 'Eletrônicos', 1200.00),
    ('2023-03-15', 'Produto D', 'Livros', 200.00),
    ('2023-03-20', 'Produto E', 'Eletrônicos', 800.00),
    ('2023-04-02', 'Produto F', 'Roupas', 400.00),
    ('2023-05-05', 'Produto G', 'Livros', 150.00),
    ('2023-06-10', 'Produto H', 'Eletrônicos', 1000.00),
    ('2023-07-20', 'Produto I', 'Roupas', 600.00),
    ('2023-08-25', 'Produto J', 'Eletrônicos', 700.00),
    ('2023-09-30', 'Produto K', 'Livros', 300.00),
    ('2023-10-05', 'Produto L', 'Roupas', 450.00),
    ('2023-11-15', 'Produto M', 'Eletrônicos', 900.00),
    ('2023-12-20', 'Produto N', 'Livros', 250.00)
])

# Confirma as alterações no banco de dados
conexao.commit()

# ============================================================
# PASSO 2 - CARREGAR E PREPARAR OS DADOS
# ============================================================

# Utiliza uma consulta SQL para carregar os dados no Pandas
df_vendas = pd.read_sql_query(
    'SELECT * FROM vendas1',
    conexao
)

# Converte a coluna de data para o formato de data do Pandas
df_vendas['data_venda'] = pd.to_datetime(df_vendas['data_venda'])

# Exibe os primeiros registros
print("PRIMEIROS REGISTROS:")
print(df_vendas.head())

# ============================================================
# EXPLORAÇÃO DOS DADOS
# ============================================================

print("\nINFORMAÇÕES DOS DADOS:")
print(df_vendas.info())

print("\nESTATÍSTICAS DOS DADOS:")
print(df_vendas.describe())

# ============================================================
# PASSO 3 - ANÁLISE DOS DADOS
# ============================================================

# Calcula o total de vendas
total_vendas = df_vendas['valor_venda'].sum()

print("\nTOTAL DE VENDAS:")
print(f"R$ {total_vendas:.2f}")

# Calcula a média das vendas
media_vendas = df_vendas['valor_venda'].mean()

print("\nMÉDIA POR VENDA:")
print(f"R$ {media_vendas:.2f}")

# Soma das vendas por categoria
vendas_categoria = df_vendas.groupby('categoria')['valor_venda'].sum()

print("\nVENDAS POR CATEGORIA:")
print(vendas_categoria)

# Produto com maior valor de venda
maior_venda = df_vendas.loc[
    df_vendas['valor_venda'].idxmax()
]

print("\nMAIOR VENDA:")
print(maior_venda)

# Soma das vendas por mês
vendas_mes = df_vendas.groupby(
    df_vendas['data_venda'].dt.month
)['valor_venda'].sum()

print("\nVENDAS POR MÊS:")
print(vendas_mes)

# ============================================================
# PASSO 4 - VISUALIZAÇÃO DOS DADOS
# ============================================================

# Configuração visual do Seaborn
sns.set_theme()

# ------------------------------------------------------------
# GRÁFICO 1 - VENDAS POR CATEGORIA
# ------------------------------------------------------------

plt.figure(figsize=(8, 5))

sns.barplot(
    x=vendas_categoria.index,
    y=vendas_categoria.values
)

plt.title('Total de Vendas por Categoria')
plt.xlabel('Categoria')
plt.ylabel('Valor das Vendas (R$)')
plt.xticks(rotation=20)

plt.show()

# ------------------------------------------------------------
# GRÁFICO 2 - VENDAS AO LONGO DOS MESES
# ------------------------------------------------------------

plt.figure(figsize=(10, 5))

sns.lineplot(
    x=vendas_mes.index,
    y=vendas_mes.values,
    marker='o'
)

plt.title('Vendas ao Longo dos Meses')
plt.xlabel('Mês')
plt.ylabel('Valor das Vendas (R$)')

plt.show()

# ------------------------------------------------------------
# GRÁFICO 3 - VENDAS POR PRODUTO
# ------------------------------------------------------------

plt.figure(figsize=(12, 5))

sns.barplot(
    data=df_vendas,
    x='produto',
    y='valor_venda'
)

plt.title('Valor de Venda por Produto')
plt.xlabel('Produto')
plt.ylabel('Valor da Venda (R$)')

plt.show()

# ============================================================
# PASSO 5 - CONCLUSÃO E INSIGHTS
# ============================================================

print("========== CONCLUSÃO ==========")

print(f"O total vendido no período foi de R$ {total_vendas:.2f}.")
print(f"A média por venda foi de R$ {media_vendas:.2f}.")

categoria_maior = vendas_categoria.idxmax()
valor_categoria_maior = vendas_categoria.max()

print(
    f"A categoria com maior faturamento foi "
    f"{categoria_maior}, com R$ {valor_categoria_maior:.2f}."
)

print(
    f"A maior venda individual foi do "
    f"{maior_venda['produto']}, no valor de "
    f"R$ {maior_venda['valor_venda']:.2f}."
)

# Fecha a conexão com o banco de dados
conexao.close()# ============================================================
# ATIVIDADE - ANÁLISE DE DADOS DE VENDAS
# SQLite + Pandas + Matplotlib + Seaborn
# ============================================================

# Importação das bibliotecas
import sqlite3
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# ============================================================
# PASSO 1 - CONEXÃO COM O BANCO DE DADOS
# ============================================================

# Cria uma conexão com o banco de dados SQLite
# Caso o arquivo não exista, ele será criado.
conexao = sqlite3.connect('dados_vendas.db')

# Cria o cursor para executar comandos SQL
cursor = conexao.cursor()

# Cria a tabela de vendas, caso ela ainda não exista
cursor.execute('''
CREATE TABLE IF NOT EXISTS vendas1 (
    id_venda INTEGER PRIMARY KEY AUTOINCREMENT,
    data_venda DATE,
    produto TEXT,
    categoria TEXT,
    valor_venda REAL
)
''')

# ============================================================
# INSERÇÃO DOS DADOS
# ============================================================

# Insere os dados de vendas na tabela
cursor.executemany('''
INSERT INTO vendas1
(data_venda, produto, categoria, valor_venda)
VALUES (?, ?, ?, ?)
''', [
    ('2023-01-01', 'Produto A', 'Eletrônicos', 1500.00),
    ('2023-01-05', 'Produto B', 'Roupas', 350.00),
    ('2023-02-10', 'Produto C', 'Eletrônicos', 1200.00),
    ('2023-03-15', 'Produto D', 'Livros', 200.00),
    ('2023-03-20', 'Produto E', 'Eletrônicos', 800.00),
    ('2023-04-02', 'Produto F', 'Roupas', 400.00),
    ('2023-05-05', 'Produto G', 'Livros', 150.00),
    ('2023-06-10', 'Produto H', 'Eletrônicos', 1000.00),
    ('2023-07-20', 'Produto I', 'Roupas', 600.00),
    ('2023-08-25', 'Produto J', 'Eletrônicos', 700.00),
    ('2023-09-30', 'Produto K', 'Livros', 300.00),
    ('2023-10-05', 'Produto L', 'Roupas', 450.00),
    ('2023-11-15', 'Produto M', 'Eletrônicos', 900.00),
    ('2023-12-20', 'Produto N', 'Livros', 250.00)
])

# Confirma as alterações no banco de dados
conexao.commit()

# ============================================================
# PASSO 2 - CARREGAR E PREPARAR OS DADOS
# ============================================================

# Utiliza uma consulta SQL para carregar os dados no Pandas
df_vendas = pd.read_sql_query(
    'SELECT * FROM vendas1',
    conexao
)

# Converte a coluna de data para o formato de data do Pandas
df_vendas['data_venda'] = pd.to_datetime(df_vendas['data_venda'])

# Exibe os primeiros registros
print("PRIMEIROS REGISTROS:")
print(df_vendas.head())

# ============================================================
# EXPLORAÇÃO DOS DADOS
# ============================================================

print("\nINFORMAÇÕES DOS DADOS:")
print(df_vendas.info())

print("\nESTATÍSTICAS DOS DADOS:")
print(df_vendas.describe())

# ============================================================
# PASSO 3 - ANÁLISE DOS DADOS
# ============================================================

# Calcula o total de vendas
total_vendas = df_vendas['valor_venda'].sum()

print("\nTOTAL DE VENDAS:")
print(f"R$ {total_vendas:.2f}")

# Calcula a média das vendas
media_vendas = df_vendas['valor_venda'].mean()

print("\nMÉDIA POR VENDA:")
print(f"R$ {media_vendas:.2f}")

# Soma das vendas por categoria
vendas_categoria = df_vendas.groupby('categoria')['valor_venda'].sum()

print("\nVENDAS POR CATEGORIA:")
print(vendas_categoria)

# Produto com maior valor de venda
maior_venda = df_vendas.loc[
    df_vendas['valor_venda'].idxmax()
]

print("\nMAIOR VENDA:")
print(maior_venda)

# Soma das vendas por mês
vendas_mes = df_vendas.groupby(
    df_vendas['data_venda'].dt.month
)['valor_venda'].sum()

print("\nVENDAS POR MÊS:")
print(vendas_mes)

# ============================================================
# PASSO 4 - VISUALIZAÇÃO DOS DADOS
# ============================================================

# Configuração visual do Seaborn
sns.set_theme()

# ------------------------------------------------------------
# GRÁFICO 1 - VENDAS POR CATEGORIA
# ------------------------------------------------------------

plt.figure(figsize=(8, 5))

sns.barplot(
    x=vendas_categoria.index,
    y=vendas_categoria.values
)

plt.title('Total de Vendas por Categoria')
plt.xlabel('Categoria')
plt.ylabel('Valor das Vendas (R$)')
plt.xticks(rotation=20)

plt.show()

# ------------------------------------------------------------
# GRÁFICO 2 - VENDAS AO LONGO DOS MESES
# ------------------------------------------------------------

plt.figure(figsize=(10, 5))

sns.lineplot(
    x=vendas_mes.index,
    y=vendas_mes.values,
    marker='o'
)

plt.title('Vendas ao Longo dos Meses')
plt.xlabel('Mês')
plt.ylabel('Valor das Vendas (R$)')

plt.show()

# ------------------------------------------------------------
# GRÁFICO 3 - VENDAS POR PRODUTO
# ------------------------------------------------------------

plt.figure(figsize=(12, 5))

sns.barplot(
    data=df_vendas,
    x='produto',
    y='valor_venda'
)

plt.title('Valor de Venda por Produto')
plt.xlabel('Produto')
plt.ylabel('Valor da Venda (R$)')

plt.show()

# ============================================================
# PASSO 5 - CONCLUSÃO E INSIGHTS
# ============================================================

print("========== CONCLUSÃO ==========")

print(f"O total vendido no período foi de R$ {total_vendas:.2f}.")
print(f"A média por venda foi de R$ {media_vendas:.2f}.")

categoria_maior = vendas_categoria.idxmax()
valor_categoria_maior = vendas_categoria.max()

print(
    f"A categoria com maior faturamento foi "
    f"{categoria_maior}, com R$ {valor_categoria_maior:.2f}."
)

print(
    f"A maior venda individual foi do "
    f"{maior_venda['produto']}, no valor de "
    f"R$ {maior_venda['valor_venda']:.2f}."
)

# Fecha a conexão com o banco de dados
conexao.close()