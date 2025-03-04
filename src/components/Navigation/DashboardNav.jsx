import React from 'react';
import { LayoutGrid } from 'lucide-react';
import NavItem from './NavItem';
import './NavigationTabs.css';

// Item do Dashboard
const dashboardLink = { 
  name: 'Dashboard', 
  icon: <LayoutGrid size={20} />, 
  section: 'dashboard', 
  initial: 'D' 
};

const DashboardNav = ({ activeSection, sidebarOpen, handleSectionChange }) => {
  return (
    <NavItem 
      link={dashboardLink}
      activeSection={activeSection}
      sidebarOpen={sidebarOpen}
      handleSectionChange={handleSectionChange}
    />
  );
};

export default DashboardNav; 