import React from 'react'
import PropTypes from 'prop-types'

class MenuSelectObject extends React.Component {
  render () {
    return (
      <div>
        <ul className="menu-bar">
          {this.props.items.map(this.renderItem)}
        </ul>
      </div>
    )
  }

  renderItem = (id, index) => {
    return (
      <li className={id === this.props.currentFilter ? 'selected' : ''} key={index}
          onClick={() => this.props.click(id)}>
        {id}
      </li>
    );
  }
}

export default MenuSelectObject;
