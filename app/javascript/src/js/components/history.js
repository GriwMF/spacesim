import React from 'react'
import PropTypes from 'prop-types'

class History extends React.Component {
  state = {
    history: [],
  };

  handleReceivedHistory = response => {
    console.log(response);
    const { history } = response;
    this.setState({
      history: [...this.state.history, response]
    });
  };

  componentDidMount = () => {
    this.props.cable.subscriptions.create('HistoryChannel', {
      received: this.handleReceivedHistory
    });
    // fetch(`${API_ROOT}/conversations`)
    //   .then(res => res.json())
    //   .then(conversations => this.setState({ conversations }));
  };

  render() {
    const { history } = this.state;

    return (
      <ul>
        {mapHistory(history, ()=> {})}
      </ul>
    )
  }
}

export default History;

const mapHistory = (history, handleClick) => {
  console.log(history)
  return history.map(h => {
    return (
      <li key={h.id} onClick={() => handleClick(h.id)}>
        {h.object}
      </li>
    );
  });
};
