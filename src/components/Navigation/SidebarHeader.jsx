import React from 'react';
import { Menu, X } from 'lucide-react';
import './SidebarHeader.css';

const SidebarHeader = ({ sidebarOpen, toggleSidebar }) => {
  return (
    <div className="sidebar-header">
      {sidebarOpen && <h1 className="sidebar-title">Flavor Dashboard</h1>}
      <button 
        onClick={toggleSidebar} 
        className="sidebar-toggle-button"
        aria-label={sidebarOpen ? "Fechar Menu" : "Abrir Menu"}
      >
        {sidebarOpen ? <X size={20} /> : <Menu size={20} />}
      </button>
    </div>
  );
};

export default SidebarHeader; 