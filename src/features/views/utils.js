/**
 * Filtra um array de dados com base em um termo de pesquisa
 * @param {Array} data - Os dados a serem filtrados
 * @param {string} term - O termo de pesquisa
 * @returns {Array} - Os dados filtrados
 */
export const filterData = (data, term) => {
  if (!term || term === '') return data;
  
  return data.filter(item => {
    return Object.values(item).some(value => 
      value && value.toString().toLowerCase().includes(term.toLowerCase())
    );
  });
}; 