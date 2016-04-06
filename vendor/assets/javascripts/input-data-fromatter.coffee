###
# Copyright (c) 2014, Yahoo! Inc. All rights reserved.
# Copyrights licensed under the New BSD License.
# See the accompanying LICENSE file for terms.
###

'use strict'
((s) ->
  _isAutoFormatEnabled = undefined
  _isModifierKey = undefined
  _format = undefined
  _formatHandler = undefined
  _getSepatarorIndex = undefined
  _getSepatarorPattern = undefined
  _enableFormatting = undefined
  _getFormattedValue = undefined

  _isAutoFormatEnabled = (e) ->
    keyCode = e.keyCode
    #debugger;
    if !keyCode
      return true
    else if keyCode >= 48 and keyCode <= 90 or keyCode >= 96 and keyCode <= 105
      return true
    false

  _isModifierKey = (e) ->
    keyCode = e.keyCode
    if keyCode >= 8 and keyCode <= 46
      return true
    false

  _format = (value, separator, separatorIndex, separatorPattern, caretIndex, lastCharTypedIsSeparator) ->
    valueLength = value.length
    unFormattedValue = value.replace(separatorPattern, '')
    expectedValueArray = unFormattedValue.split('')
    if lastCharTypedIsSeparator
      caretIndex -= 1
    i = 0
    l = separatorIndex.length
    while i < l
      if expectedValueArray.length >= separatorIndex[i]
        expectedValueArray.splice separatorIndex[i], 0, separator[i]
        if lastCharTypedIsSeparator
                    i += 1
          continue
        if caretIndex >= valueLength
          caretIndex += 1
        if caretIndex == separatorIndex[i] + 1
          caretIndex += 1
      i += 1
    {
      value: expectedValueArray.join('')
      caretIndex: caretIndex
    }

  _formatHandler = (separator, separatorIndex, separatorPattern, formatLength, e) ->
    caretIndex = @selectionStart
    value = @value
    lastCharTyped = value.charAt(caretIndex - 1)
    lastCharTypedIsSeparator = if separator.indexOf(lastCharTyped) != -1 then 1 else 0
    if lastCharTypedIsSeparator and !_isModifierKey(e) or _isAutoFormatEnabled(e)
      result = _format(value, separator, separatorIndex, separatorPattern, caretIndex, lastCharTypedIsSeparator)
      @value = result.value.substr(0, formatLength)
      if e.type
        @selectionStart = result.caretIndex
        @selectionEnd = result.caretIndex
    return

  _getSepatarorIndex = (separator, format) ->
    separatorIndex = []
    currentSeparatorIndex = -1
    i = 0
    l = separator.length
    while i < l
      currentSeparatorIndex = format.indexOf(separator[i], currentSeparatorIndex + 1)
      separatorIndex.push currentSeparatorIndex
      i += 1
    separatorIndex

  _getSepatarorPattern = (separator) ->
    separatorPattern = '('
    index = 0
    length = separator.length
    while index < length
      if index > 0
        separatorPattern = separatorPattern + '|'
      separatorPattern = separatorPattern + '\\' + separator[index]
      index += 1
    separatorPattern = separatorPattern + ')'
    new RegExp(separatorPattern, 'g')

  _enableFormatting = (target) ->
    value = target.value
    format = target.data('format')
    formatLength = format.length
    separator = format.match(/[^X]/g) or []
    separatorIndex = undefined
    separatorPattern = undefined
    target.removeEventListener 'keyup', _formatHandler
    if formatLength
      target.setAttribute 'maxLength', formatLength
      separatorIndex = _getSepatarorIndex(separator, format)
      separatorPattern = _getSepatarorPattern(separator)
      target.addEventListener 'keyup', _formatHandler.bind(target, separator, separatorIndex, separatorPattern, formatLength)
      if value != ''
        _formatHandler.call target, separator, separatorIndex, separatorPattern, formatLength, {}
    return

  _getFormattedValue = (value, format) ->
    formatLength = if format then format.length else 0
    separator = if format then format.match(/[^X]/g) else []
    separatorIndex = undefined
    separatorPattern = undefined
    if formatLength and value != ''
      separatorIndex = _getSepatarorIndex(separator, format)
      separatorPattern = _getSepatarorPattern(separator)
      return _format(value, separator, separatorIndex, separatorPattern).value
    value

  s.inputFormatter =
    enableFormatting: _enableFormatting
    getFormattedValue: _getFormattedValue
  return
) window

### global window ###

#window.inputFormatter.enableFormatting(document.querySelector('#mobile-number'));

# ---
# generated by js2coffee 2.1.0