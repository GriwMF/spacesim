import React, { Component } from 'react';
import PropTypes from 'prop-types'

class History extends Component {
  state = {
    histories: this.props.initialState,
  };

  handleReceivedHistory = history => {
    this.setState({
      histories: [...this.state.histories, JSON.parse(history)]
    });
  };

  componentDidMount = () => {
    this.props.cable.subscriptions.create('HistoryChannel', {
      received: this.handleReceivedHistory
    });
  };

  render() {
    const { histories } = this.state;

    return (
      <ul>
        {mapHistory(histories, ()=> {})}
      </ul>
    )
  }
}

export default History;

const mapHistory = (histories, handleClick) => {
  return histories.slice(0).reverse().map(history => {
    return (
      <li key={history.id} onClick={() => handleClick(history.id)}>
        {JSON.stringify(history)}
      </li>
    );
  });
};
