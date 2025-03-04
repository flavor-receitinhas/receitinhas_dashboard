import React, { useState, useEffect } from 'react';
import {  
  Menu, X, Search, Bell, Settings, Filter
} from 'lucide-react';
import './styles/dashboard.css';
import Sidebar from '../components/Navigation/Sidebar';

// Importar os novos componentes de view
import DashboardView from './views/DashboardView';
import RecipesView from './views/RecipesView';
import IngredientsView from './views/IngredientsView';
import ReportsView from './views/ReportsView';
import UsersView from './views/UsersView';

// Mock data permanece o mesmo...

// Dashboard component
const RecipeDashboard = () => {
  const [isMobile, setIsMobile] = useState(window.innerWidth < 768);
  const [sidebarOpen, setSidebarOpen] = useState(window.innerWidth >= 768);
  const [completelyHidden, setCompletelyHidden] = useState(false);
  const [activeSection, setActiveSection] = useState('dashboard');
  const [searchTerm, setSearchTerm] = useState('');
  const [filterOpen, setFilterOpen] = useState(false);

  const mockAnalytics = {
    recipesByCategory: [
      { name: 'Main Dishes', count: 120 },
      { name: 'Desserts', count: 80 },
      { name: 'Appetizers', count: 50 },
      { name: 'Beverages', count: 40 },
      { name: 'Breakfast', count: 60 },
      { name: 'Salads', count: 35 }
    ],
    userGrowth: [
      { month: 'Jan', users: 550 },
      { month: 'Feb', users: 620 },
      { month: 'Mar', users: 700 },
      { month: 'Apr', users: 750 },
      { month: 'May', users: 830 },
      { month: 'Jun', users: 920 }
    ],
    popularIngredients: [
      { name: 'Chicken', count: 250 },
      { name: 'Rice', count: 200 },
      { name: 'Tomatoes', count: 180 },
      { name: 'Cheese', count: 160 },
      { name: 'Pasta', count: 140 }
    ],
    reportsByType: [
      { name: 'Inappropriate Content', value: 12 },
      { name: 'Copyright Issues', value: 5 },
      { name: 'Incorrect Information', value: 8 },
      { name: 'Other', value: 4 }
    ]
  };
  
  const mockRecipes = [
    { id: 1, name: 'Pasta Carbonara', author: 'Julia Santos', category: 'Main Dishes', likes: 342, status: 'Active' },
    { id: 2, name: 'Chocolate Cake', author: 'Carlos Oliveira', category: 'Desserts', likes: 289, status: 'Active' },
    { id: 3, name: 'Guacamole', author: 'Ana Pereira', category: 'Appetizers', likes: 156, status: 'Pending Review' },
    { id: 4, name: 'Caesar Salad', author: 'Ricardo Silva', category: 'Salads', likes: 203, status: 'Active' },
    { id: 5, name: 'Fruit Smoothie', author: 'Mariana Costa', category: 'Beverages', likes: 175, status: 'Active' },
    { id: 6, name: 'French Toast', author: 'Pedro Almeida', category: 'Breakfast', likes: 220, status: 'Active' },
    { id: 7, name: 'Sushi Rolls', author: 'Juliana Tanaka', category: 'Main Dishes', likes: 310, status: 'Flagged' },
    { id: 8, name: 'Carrot Cake', author: 'Gabriel Martins', category: 'Desserts', likes: 267, status: 'Active' }
  ];
  
  const mockIngredients = [
    { id: 1, name: 'Chicken Breast', category: 'Meat', usageCount: 178, lastUpdated: '2023-12-10' },
    { id: 2, name: 'All-Purpose Flour', category: 'Baking', usageCount: 156, lastUpdated: '2023-12-15' },
    { id: 3, name: 'Olive Oil', category: 'Oils', usageCount: 234, lastUpdated: '2023-12-05' },
    { id: 4, name: 'Tomatoes', category: 'Vegetables', usageCount: 189, lastUpdated: '2023-12-12' },
    { id: 5, name: 'Parmesan Cheese', category: 'Dairy', usageCount: 132, lastUpdated: '2023-12-08' },
    { id: 6, name: 'Basil', category: 'Herbs', usageCount: 95, lastUpdated: '2023-12-18' }
  ];
  
  const mockReports = [
    { id: 1, reportType: 'Inappropriate Content', recipeId: 15, reportedBy: 'user123', date: '2023-12-01', status: 'Pending' },
    { id: 2, reportType: 'Copyright Issues', recipeId: 23, reportedBy: 'user456', date: '2023-12-03', status: 'Resolved' },
    { id: 3, reportType: 'Incorrect Information', recipeId: 7, reportedBy: 'user789', date: '2023-12-05', status: 'Under Review' },
    { id: 4, reportType: 'Inappropriate Content', recipeId: 42, reportedBy: 'user321', date: '2023-12-07', status: 'Pending' },
    { id: 5, reportType: 'Other', recipeId: 31, reportedBy: 'user654', date: '2023-12-10', status: 'Resolved' }
  ];
  
  const mockUsers = [
    { id: 1, name: 'Ana Silva', email: 'ana.silva@example.com', role: 'User', status: 'Active', recipes: 12, joinDate: '2023-01-15' },
    { id: 2, name: 'Carlos Santos', email: 'carlos.santos@example.com', role: 'Editor', status: 'Active', recipes: 28, joinDate: '2022-11-23' },
    { id: 3, name: 'Marina Oliveira', email: 'marina.oliveira@example.com', role: 'User', status: 'Inactive', recipes: 5, joinDate: '2023-03-08' },
    { id: 4, name: 'Rafael Costa', email: 'rafael.costa@example.com', role: 'User', status: 'Active', recipes: 9, joinDate: '2023-02-19' },
    { id: 5, name: 'Juliana Almeida', email: 'juliana.almeida@example.com', role: 'Admin', status: 'Active', recipes: 17, joinDate: '2022-10-05' }
  ];

  // COLORS
  const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#8884D8', '#E4C626'];

  useEffect(() => {
    const handleResize = () => {
      const mobile = window.innerWidth < 768;
      setIsMobile(mobile);
      
      if (!completelyHidden) {
        if (mobile) {
          setSidebarOpen(false);
        } else {
          setSidebarOpen(true);
        }
      }
    };

    window.addEventListener('resize', handleResize);
    handleResize();
    
    return () => window.removeEventListener('resize', handleResize);
  }, [completelyHidden]);

  const toggleSidebar = () => {
    if (!isMobile && sidebarOpen) {
      setCompletelyHidden(true);
    } else if (!sidebarOpen) {
      setCompletelyHidden(false);
    }
    setSidebarOpen(!sidebarOpen);
  };


  // Função para mudar de seção e fechar o sidebar em dispositivos móveis
  const handleSectionChange = (section) => {
    setActiveSection(section);
    if (isMobile) {
      setSidebarOpen(false);
    }
  };

  // Render the appropriate content based on active section
  const renderContent = () => {
    switch (activeSection) {
      case 'dashboard':
        return <DashboardView 
                 mockRecipes={mockRecipes} 
                 mockIngredients={mockIngredients} 
                 mockUsers={mockUsers} 
                 mockAnalytics={mockAnalytics} 
                 COLORS={COLORS} 
               />;
      case 'recipes':
        return <RecipesView mockRecipes={mockRecipes} searchTerm={searchTerm} />;
      case 'ingredients':
        return <IngredientsView mockIngredients={mockIngredients} searchTerm={searchTerm} />;
      case 'reports':
        return <ReportsView mockReports={mockReports} searchTerm={searchTerm} />;
      case 'users':
        return <UsersView mockUsers={mockUsers} searchTerm={searchTerm} />;
      default:
        return <DashboardView 
                 mockRecipes={mockRecipes} 
                 mockIngredients={mockIngredients} 
                 mockUsers={mockUsers} 
                 mockAnalytics={mockAnalytics} 
                 COLORS={COLORS} 
               />;
    }
  };
 
  return (
    <div className="dashboard-container">
      {/* Sidebar Component */}
      <Sidebar 
        sidebarOpen={sidebarOpen}
        completelyHidden={completelyHidden}
        toggleSidebar={toggleSidebar}
        activeSection={activeSection}
        handleSectionChange={handleSectionChange}
      />

      {/* Main Content */}
      <div className={`main-content ${sidebarOpen ? 'main-content-sidebar-open' : 'main-content-sidebar-closed'} ${completelyHidden ? 'main-content-full' : ''}`}>
        {/* Header */}
        <header className="header">
          <div className="header-left">
            <button 
              onClick={toggleSidebar} 
              className="header-toggle-button"
            >
              <Menu size={20} />
            </button>
          </div>
          
          <div className="search-container">
            <div className="search-input-container">
              <input 
                type="text" 
                placeholder="Search..." 
                className="search-input"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
              />
              <Search className="search-icon" size={18} />
              {searchTerm && (
                <button 
                  className="search-clear-button"
                  onClick={() => setSearchTerm('')}
                >
                  <X size={18} />
                </button>
              )}
            </div>
            
            <div className="filter-button-container">
              <button 
                className="filter-button"
                onClick={() => setFilterOpen(!filterOpen)}
              >
                <Filter size={20} />
              </button>
            </div>
          </div>
          
          <div className="header-actions">
            <button className="notification-button">
              <Bell size={20} />
              <span className="notification-indicator"></span>
            </button>
            <button className="settings-button">
              <Settings size={20} />
            </button>
            <div className="user-profile">
              <img 
                src="/api/placeholder/32/32" 
                alt="User" 
                className="user-avatar"
              />
              <div className="user-info">
                <p className="user-name">Admin User</p>
              </div>
            </div>
          </div>
        </header>

        {/* Main content */}
        <main className="main">
          <div className="section-header">
            <h1 className="section-title">{activeSection}</h1>
            {activeSection !== 'dashboard' && (
              <div className="breadcrumb">
                <span>Home</span> / <span className="capitalize">{activeSection}</span>
              </div>
            )}
          </div>
          
          {renderContent()}
        </main>
      </div>
    </div>
  );
};

export default RecipeDashboard;