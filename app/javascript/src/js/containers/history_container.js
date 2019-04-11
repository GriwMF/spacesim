import { connect } from 'react-redux'
import { handleReceivedHistory } from '../actions'
import History from '../components/history'

const mapStateToProps = (state) => {
  return {
    histories: state.history.filteredHistories,
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
