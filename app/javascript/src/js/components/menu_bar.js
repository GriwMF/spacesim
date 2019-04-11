import React from 'react'
import { connect } from 'react-redux'
import PropTypes from 'prop-types'
import { selectFilter, selectObject } from '../actions'
import MenuSelectObject from './menu_select_object'

class SimpleMenuBar extends React.Component {
  render () {
    let menuSelectObject = '';

    if (this.props.currentFilter !== 'All') {
      menuSelectObject =
        <MenuSelectObject click={this.props.onSelectObjectClick} items={this.props.objectIds}/>;
    }

    return (
      <div>
        <a href="#" onClick={() => {fetch("http://localhost:3000/bc")}}>Go!</a>
        <ul className="menu-bar">
          {this.props.filters.map(this.renderFilter)}
        </ul>
        {menuSelectObject}
      </div>
    )
  }

  renderFilter = (filter) => {
    return (
      <li className={filter === this.props.currentFilter ? 'selected' : ''} key={filter} onClick={() => this.props.onFilterClick(filter)}>
        {filter}
      </li>
    );
  }
}

const getFilters = (histories) => (
  ['All', ...new Set(histories.map(history => { return history.object_type }))]
)

const getObjectIds = (histories) => (
  [...new Set(histories.map((h) => h.object_id))]
)

const mapStateToProps = (state) => {
  return {
    filters: getFilters(state.history.histories),
    objectIds: getObjectIds(state.history.filteredHistories),
    currentFilter: state.history.currentFilter,
    currentObject: state.history.currentObject
  }
}

const mapDispatchToProps = dispatch => {
  return {
    onFilterClick: id => {
      dispatch(selectFilter(id))
    },
    onSelectObjectClick: id => {
      dispatch(selectObject(id))
    }
  }
}

const MenuBar = connect(
  mapStateToProps,
  mapDispatchToProps
)(SimpleMenuBar)

export default MenuBar;
