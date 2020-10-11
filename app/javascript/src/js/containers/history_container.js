import { connect } from 'react-redux'
import { handleReceivedHistory } from '../actions'
import History from '../components/history'

const filterByObjectId = (histories, objectId) => {
  if (objectId) {
    histories = histories.filter(h => h.object_id === objectId);
  }

  return histories;
}

const mapStateToProps = (state) => {
  return {
    histories: filterByObjectId(state.history.filteredHistories, state.history.currentObject)
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
