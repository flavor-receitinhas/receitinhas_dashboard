import React from 'react';
import DashboardNav from './DashboardNav';
import ResourcesNav from './ResourcesNav';
import './NavigationTabs.css';

const NavigationTabs = ({ activeSection, sidebarOpen, handleSectionChange }) => {
  return (
    <nav className="sidebar-nav">
      <ul>
        {/* Componente de navegação do Dashboard */}
        <DashboardNav 
          activeSection={activeSection}
          sidebarOpen={sidebarOpen}
          handleSectionChange={handleSectionChange}
        />
        
        {/* Componente de navegação dos Recursos */}
        <ResourcesNav 
          activeSection={activeSection}
          sidebarOpen={sidebarOpen}
          handleSectionChange={handleSectionChange}
        />
      </ul>
    </nav>
  );
};

export default NavigationTabs; 