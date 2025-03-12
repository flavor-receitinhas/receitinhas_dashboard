import React from 'react';
import { 
  BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer,
  LineChart, Line, PieChart, Pie, Cell
} from 'recharts';
import { ScrollText, ShoppingBasket, Users } from 'lucide-react';

const DashboardView = ({ mockRecipes, mockIngredients, mockUsers, mockAnalytics, COLORS }) => {
  return (
    <div className="dashboard-grid">
      <div className="card">
        <h3 className="card-title">Total Recipes</h3>
        <div className="card-content">
          <ScrollText className="card-icon card-icon-blue" size={24} />
          <span className="card-value">{mockRecipes.length}</span>
        </div>
      </div>
      
      <div className="card">
        <h3 className="card-title">Total Ingredients</h3>
        <div className="card-content">
          <ShoppingBasket className="card-icon card-icon-green" size={24} />
          <span className="card-value">{mockIngredients.length}</span>
        </div>
      </div>
      
      <div className="card">
        <h3 className="card-title">Active Users</h3>
        <div className="card-content">
          <Users className="card-icon card-icon-purple" size={24} />
          <span className="card-value">{mockUsers.filter(user => user.status === 'Active').length}</span>
        </div>
      </div>
      
      <div className="card card-span-3">
        <h3 className="card-title">User Growth</h3>
        <div className="chart-container">
          <ResponsiveContainer width="100%" height="100%">
            <LineChart data={mockAnalytics.userGrowth}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="month" />
              <YAxis />
              <Tooltip />
              <Legend />
              <Line type="monotone" dataKey="users" stroke="#8884d8" activeDot={{ r: 8 }} />
            </LineChart>
          </ResponsiveContainer>
        </div>
      </div>
      
      <div className="card card-span-2">
        <h3 className="card-title">Recipes by Category</h3>
        <div className="chart-container">
          <ResponsiveContainer width="100%" height="100%">
            <BarChart data={mockAnalytics.recipesByCategory}>
              <CartesianGrid strokeDasharray="3 3" />
              <XAxis dataKey="name" />
              <YAxis />
              <Tooltip />
              <Legend />
              <Bar dataKey="count" fill="#E4C626" />
            </BarChart>
          </ResponsiveContainer>
        </div>
      </div>
      
      <div className="card">
        <h3 className="card-title">Reports by Type</h3>
        <div className="chart-container">
          <ResponsiveContainer width="100%" height="100%">
            <PieChart>
              <Pie
                data={mockAnalytics.reportsByType}
                cx="50%"
                cy="50%"
                labelLine={false}
                outerRadius={80}
                fill="#8884d8"
                dataKey="value"
                label={({ name, percent }) => `${name}: ${(percent * 100).toFixed(0)}%`}
              >
                {mockAnalytics.reportsByType.map((entry, index) => (
                  <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                ))}
              </Pie>
              <Tooltip />
            </PieChart>
          </ResponsiveContainer>
        </div>
      </div>
    </div>
  );
};

export default DashboardView; 