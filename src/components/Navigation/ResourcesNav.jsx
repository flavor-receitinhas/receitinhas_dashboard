import React from 'react';
import { ChefHat, ShoppingBasket, AlertTriangle, Users } from 'lucide-react';
import NavItem from './NavItem';
import './NavigationTabs.css';

// Array de recursos
const resourceLinks = [
  { name: 'Recipes', icon: <ChefHat size={20} />, section: 'recipes', initial: 'R' },
  { name: 'Ingredients', icon: <ShoppingBasket size={20} />, section: 'ingredients', initial: 'I' },
  { name: 'Reports', icon: <AlertTriangle size={20} />, section: 'reports', initial: 'R' },
  { name: 'Users', icon: <Users size={20} />, section: 'users', initial: 'U' }
];

const ResourcesNav = ({ activeSection, sidebarOpen, handleSectionChange }) => {
  return (
    <>
      {/* Divisor para os recursos */}
      {sidebarOpen && <li className="sidebar-nav-divider">Recursos</li>}
      
      {/* Itens de recursos */}
      {resourceLinks.map(link => (
        <NavItem 
          key={link.section}
          link={link}
          activeSection={activeSection}
          sidebarOpen={sidebarOpen}
          handleSectionChange={handleSectionChange}
        />
      ))}
    </>
  );
};

export default ResourcesNav; 