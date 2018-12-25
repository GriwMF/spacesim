import React, { Component } from 'react';
import PropTypes from 'prop-types'

class History extends Component {
  // handleReceivedHistory = history => {
  //   this.setState({
  //     histories: [...this.state.histories, JSON.parse(history)]
  //   });
  // };
  //
  // componentDidMount = () => {
  //   this.props.cable.subscriptions.create('HistoryChannel', {
  //     received: this.handleReceivedHistory
  //   });
  // };

  render() {
    const { histories } = this.props;

    return (
      <ul>
        {this.mapHistory(histories, ()=> {})}
      </ul>
    )
  }

  mapHistory = (histories, handleClick) => {
    return histories.slice(0).reverse().map(history => {
      return (
        <li key={history.id} onClick={() => handleClick(history.id)}>
          {JSON.stringify(history, replacer)}
        </li>
      );
    });
  };
}

export default History;

function replacer(key, value) {
  // Фільтрація властивостей
  if (key === 'updated_at' || key === 'created_at') {
    return undefined;
  }
  return value;
}

