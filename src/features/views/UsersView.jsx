import React from 'react';
import { Plus, Edit, Trash2 } from 'lucide-react';
import { filterData } from './utils';

const UsersView = ({ mockUsers, searchTerm }) => {
  const filteredUsers = filterData(mockUsers, searchTerm);
  
  return (
    <div className="table-container">
      <div className="table-header">
        <h2 className="table-title">User Management</h2>
        <button className="add-button">
          <Plus size={18} className="add-button-icon" /> Add User
        </button>
      </div>
      
      <div className="table-content">
        <table className="table">
          <thead>
            <tr className="table-header-row">
              <th className="table-header-cell">Name</th>
              <th className="table-header-cell">Email</th>
              <th className="table-header-cell">Role</th>
              <th className="table-header-cell">Status</th>
              <th className="table-header-cell">Recipes</th>
              <th className="table-header-cell">Join Date</th>
              <th className="table-header-cell">Actions</th>
            </tr>
          </thead>
          <tbody>
            {filteredUsers.map(user => (
              <tr key={user.id} className="table-row">
                <td className="table-cell">{user.name}</td>
                <td className="table-cell">{user.email}</td>
                <td className="table-cell">{user.role}</td>
                <td className="table-cell">
                  <span className={`status-badge ${
                    user.status === 'Active' ? 'status-active' : 'status-flagged'
                  }`}>
                    {user.status}
                  </span>
                </td>
                <td className="table-cell">{user.recipes}</td>
                <td className="table-cell">{user.joinDate}</td>
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

export default UsersView; 