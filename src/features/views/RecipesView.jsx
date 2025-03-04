import React from 'react';
import { Plus, Edit, Trash2, Eye } from 'lucide-react';
import { filterData } from './utils';

const RecipesView = ({ mockRecipes, searchTerm }) => {
  const filteredRecipes = filterData(mockRecipes, searchTerm);
  
  return (
    <div className="table-container">
      <div className="table-header">
        <h2 className="table-title">Recipe Management</h2>
        <button className="add-button">
          <Plus size={18} className="add-button-icon" /> Add Recipe
        </button>
      </div>
      
      <div className="table-content">
        <table className="table">
          <thead>
            <tr className="table-header-row">
              <th className="table-header-cell">Name</th>
              <th className="table-header-cell">Author</th>
              <th className="table-header-cell">Category</th>
              <th className="table-header-cell">Likes</th>
              <th className="table-header-cell">Status</th>
              <th className="table-header-cell">Actions</th>
            </tr>
          </thead>
          <tbody>
            {filteredRecipes.map(recipe => (
              <tr key={recipe.id} className="table-row">
                <td className="table-cell">{recipe.name}</td>
                <td className="table-cell">{recipe.author}</td>
                <td className="table-cell">{recipe.category}</td>
                <td className="table-cell">{recipe.likes}</td>
                <td className="table-cell">
                  <span className={`status-badge ${
                    recipe.status === 'Active' ? 'status-active' :
                    recipe.status === 'Pending Review' ? 'status-pending' :
                    'status-flagged'
                  }`}>
                    {recipe.status}
                  </span>
                </td>
                <td className="table-cell">
                  <div className="actions-container">
                    <button className="action-button-view" title="Visualizar">
                      <Eye size={16} />
                    </button>
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

export default RecipesView; 