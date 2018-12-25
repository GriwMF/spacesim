import React from 'react'
import { connect } from 'react-redux'
import PropTypes from 'prop-types'
import { selectFilter } from '../actions/actions'

class SimpleMenuBar extends React.Component {
  render () {
    return (
      <div>
        <a href="#" onClick={() => {fetch("http://localhost:3000/bc")}}>Go!</a>
        <ul>
          {this.props.filters.map(this.renderFilter)}
        </ul>
      </div>
    )
  }

  renderFilter = (filter) => {
    return (
      <li key={filter} onClick={() => this.props.onFilterClick(filter)}>
        {filter}
      </li>
    );
  }
}

const getFilters = (histories) => (
  ['All', ...new Set(histories.map(history => { return history.object_type }))]
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
)(SimpleMenuBar)

export default MenuBar;
