import React from 'react';
import { Plus, Edit, Trash2 } from 'lucide-react';
import { filterData } from './utils';

const IngredientsView = ({ mockIngredients, searchTerm }) => {
  const filteredIngredients = filterData(mockIngredients, searchTerm);
  
  return (
    <div className="table-container">
      <div className="table-header">
        <h2 className="table-title">Ingredient Management</h2>
        <button className="add-button">
          <Plus size={18} className="add-button-icon" /> Add Ingredient
        </button>
      </div>
      
      <div className="table-content">
        <table className="table">
          <thead>
            <tr className="table-header-row">
              <th className="table-header-cell">Name</th>
              <th className="table-header-cell">Category</th>
              <th className="table-header-cell">Usage Count</th>
              <th className="table-header-cell">Last Updated</th>
              <th className="table-header-cell">Actions</th>
            </tr>
          </thead>
          <tbody>
            {filteredIngredients.map(ingredient => (
              <tr key={ingredient.id} className="table-row">
                <td className="table-cell">{ingredient.name}</td>
                <td className="table-cell">{ingredient.category}</td>
                <td className="table-cell">{ingredient.usageCount}</td>
                <td className="table-cell">{ingredient.lastUpdated}</td>
                <td className="table-cell">
                  <div className="actions-container">
                    <button className="action-button-edit" title="Editar">
                      <Edit size={16} />
                    </button>
                    <button className="action-button-delete" title="Excluir">
                      <Trash2 size={16} />
                    </button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default IngredientsView; 