import React from 'react';
import { Eye } from 'lucide-react';
import { filterData } from './utils';

const ReportsView = ({ mockReports, searchTerm }) => {
  const filteredReports = filterData(mockReports, searchTerm);
  
  return (
    <div className="table-container">
      <div className="table-header">
        <h2 className="table-title">Report Management</h2>
      </div>
      
      <div className="table-content">
        <table className="table">
          <thead>
            <tr className="table-header-row">
              <th className="table-header-cell">Report Type</th>
              <th className="table-header-cell">Recipe ID</th>
              <th className="table-header-cell">Reported By</th>
              <th className="table-header-cell">Date</th>
              <th className="table-header-cell">Status</th>
              <th className="table-header-cell">Actions</th>
            </tr>
          </thead>
          <tbody>
            {filteredReports.map(report => (
              <tr key={report.id} className="table-row">
                <td className="table-cell">{report.reportType}</td>
                <td className="table-cell">{report.recipeId}</td>
                <td className="table-cell">{report.reportedBy}</td>
                <td className="table-cell">{report.date}</td>
                <td className="table-cell">
                  <span className={`status-badge ${
                    report.status === 'Resolved' ? 'status-active' :
                    report.status === 'Under Review' ? 'status-pending' :
                    'status-flagged'
                  }`}>
                    {report.status}
                  </span>
                </td>
                <td className="table-cell">
                  <div className="actions-container">
                    <button className="action-button-view" title="Visualizar">
                      <Eye size={16} />
                    </button>
                    <button className="action-button-resolve">
                      Resolve
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

export default ReportsView; 