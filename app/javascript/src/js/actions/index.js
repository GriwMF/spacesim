/*
 * action types
 */

export const SELECT_FILTER = 'SELECT_FILTER'
export const SELECT_OBJECT = 'SELECT_OBJECT'
export const HANDLE_RECEIVED_HISTORY = 'HANDLE_RECEIVED_HISTORY'

/*
 * action creators
 */

export function handleReceivedHistory(history) {
  return { type: HANDLE_RECEIVED_HISTORY, history }
}

export function selectFilter(filter) {
  return { type: SELECT_FILTER, filter }
}

export function selectObject(objectId) {
  return { type: SELECT_OBJECT, objectId }
}
