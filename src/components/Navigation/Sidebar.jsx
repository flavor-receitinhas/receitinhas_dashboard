import React from 'react';
import SidebarHeader from './SidebarHeader';
import NavigationTabs from './NavigationTabs';
import './Sidebar.css';

const Sidebar = ({ 
  sidebarOpen, 
  completelyHidden, 
  toggleSidebar, 
  activeSection, 
  handleSectionChange 
}) => {
  return (
    <div className={`sidebar ${sidebarOpen ? 'sidebar-open' : 'sidebar-closed'} ${completelyHidden ? 'sidebar-completely-hidden' : ''}`}>
      <SidebarHeader 
        sidebarOpen={sidebarOpen} 
        toggleSidebar={toggleSidebar} 
      />
      <NavigationTabs 
        activeSection={activeSection} 
        sidebarOpen={sidebarOpen} 
        handleSectionChange={handleSectionChange} 
      />
    </div>
  );
};

export default Sidebar; 