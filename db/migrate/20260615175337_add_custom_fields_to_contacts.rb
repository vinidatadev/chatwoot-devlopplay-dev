class AddCustomFieldsToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :cpf_cnpj, :string
    add_column :contacts, :cod_cliente, :string
    
    # Adicionar índices para melhorar performance de busca
    add_index :contacts, :cpf_cnpj
    add_index :contacts, :cod_cliente
  end
end
