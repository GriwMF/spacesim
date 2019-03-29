import { connect } from 'react-redux'
import { handleReceivedHistory } from '../actions'
import History from '../components/history'

const getVisibleHistories = (histories, filter) => {
  // switch (filter) {
  //   case 'SHOW_COMPLETED':
  //     return todos.filter(t => t.completed)
  //   case 'SHOW_ACTIVE':
  //     return todos.filter(t => !t.completed)
  //   case 'SHOW_ALL':
  //   default:
  //     return todos
  // }

  return histories.filter(h => filter === 'All' || h.object_type === filter)
}

const mapStateToProps = (state) => {
  return {
    histories: getVisibleHistories(state.history.histories, state.history.currentFilter),
  }
}

const mapDispatchToProps = dispatch => ({
  handleReceivedHistory: history => dispatch(handleReceivedHistory(history))
})

const HistoryContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(History)

export default HistoryContainer
