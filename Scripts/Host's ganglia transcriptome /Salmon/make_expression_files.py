import pandas as pd
import os

def read_data(file_type, folder):
    data_table = pd.DataFrame(columns=['Name'])
    for file in os.listdir(folder):
        if file.endswith(file_type):
            file_dir = os.path.join(folder, file)
            new_df = pd.read_table(file_dir, delimiter='\t')
            new_df = new_df[['Name', 'TPM']]
            new_df.rename(columns={'TPM': file.replace('.sf', '')}, inplace=True)
            data_table = pd.merge(data_table, new_df, how='right')
    return data_table

file_type = '.sf'
folder = '/home/golofeevad/PycharmProjects/IB_Project'
data = read_data(file_type, folder)
data.to_csv('expression_data.csv', index=False)
infected_fem = data[['quant_3', 'quant_11']].mean(axis=1)
healthy_male = data[['quant_2', 'quant_10']].mean(axis=1)
infected_male = data[['quant_4', 'quant_12']].mean(axis=1)
new_data = pd.concat([data[['Name', 'quant_1']], infected_fem, healthy_male, infected_male], axis=1)
new_data.columns = ['Name', 'healthy_fem', 'infected_fem', 'healthy_male', 'infected_male']
new_data.to_csv('mean_expression_data.csv', index=False)
