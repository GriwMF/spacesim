import React from 'react'
import { connect } from 'react-redux'
import PropTypes from 'prop-types'
import { selectFilter } from '../actions/actions'

const simpleMenuBar = props => (
  <div>
    <a href="#" onClick={()=>{fetch("http://localhost:3000/bc")}}>Go!</a>
    <ul>
      { props.filters.map(renderFilter) }
    </ul>
  </div>
)

const getFilters = (histories) => (
  [...new Set(histories.map(history => { return history.object_type })), 'All']
)

const mapStateToProps = (state) => {
  return {
    filters: getFilters(state.histories),
    currentFilter: state.currentFilter
  }
}

const mapDispatchToProps = dispatch => {
  return {
    onFilterClick: id => {
      dispatch(selectFilter(id))
    }
  }
}

const MenuBar = connect(
  mapStateToProps,
  mapDispatchToProps
)(simpleMenuBar)

export default MenuBar;

const renderFilter = (filter) => {
  return (
    <li key={filter} onClick={() => this.props.onFilterClick(filter)}>
      {filter}
    </li>
  );
};
