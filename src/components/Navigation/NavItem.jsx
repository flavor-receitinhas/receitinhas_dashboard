import React from 'react';
import './NavigationTabs.css';

const NavItem = ({ link, activeSection, sidebarOpen, handleSectionChange }) => {
  return (
    <li key={link.section}>
      <button
        onClick={() => handleSectionChange(link.section)}
        className={`sidebar-nav-item ${activeSection === link.section ? 'sidebar-nav-item-active' : 'sidebar-nav-item-inactive'}`}
        title={link.name}
      >
        <span className="sidebar-nav-icon">{link.icon}</span>
        {sidebarOpen ? (
          <span className="sidebar-nav-text">{link.name}</span>
        ) : (
          <span className="sidebar-nav-initial">{link.initial}</span>
        )}
        {activeSection === link.section && <span className="sidebar-nav-indicator"></span>}
      </button>
    </li>
  );
};

export default NavItem; 