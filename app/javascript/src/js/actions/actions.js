/*
 * action types
 */

export const SELECT_FILTER = 'SELECT_FILTER'

/*
 * action creators
 */

export function selectFilter(filter) {
  return { type: SELECT_FILTER, filter }
}
