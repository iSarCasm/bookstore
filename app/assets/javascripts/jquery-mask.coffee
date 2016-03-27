###*
# jquery.mask.js
# @version: v1.7.7
# @author: Igor Escobar
#
# Created by Igor Escobar on 2012-03-10. Please report any bug at http://blog.igorescobar.com
#
# Copyright (c) 2012 Igor Escobar http://blog.igorescobar.com
#
# The MIT License (http://www.opensource.org/licenses/mit-license.php)
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
###

###jshint laxbreak: true ###

### global define ###

# UMD (Universal Module Definition) patterns for JavaScript modules that work everywhere.
# https://github.com/umdjs/umd/blob/master/jqueryPlugin.js
((factory) ->
  if typeof define == 'function' and define.amd
    # AMD. Register as an anonymous module.
    define [ 'jquery' ], factory
  else
    # Browser globals
    factory window.jQuery or window.Zepto
  return
) ($) ->
  'use strict'

  Mask = (el, mask, options) ->
    jMask = this
    old_value = undefined
    regexMask = undefined
    el = $(el)
    mask = if typeof mask == 'function' then mask(el.val(), undefined, el, options) else mask
    p =
      getCaret: ->
        try
          sel = undefined
          pos = 0
          ctrl = el.get(0)
          dSel = document.selection
          cSelStart = ctrl.selectionStart
          # IE Support
          if dSel and ! ~navigator.appVersion.indexOf('MSIE 10')
            sel = dSel.createRange()
            sel.moveStart 'character', if el.is('input') then -el.val().length else -el.text().length
            pos = sel.text.length
          else if cSelStart or cSelStart == '0'
            pos = cSelStart
          return pos
        catch e
        return
      setCaret: (pos) ->
        try
          if el.is(':focus')
            range = undefined
            ctrl = el.get(0)
            if ctrl.setSelectionRange
              ctrl.setSelectionRange pos, pos
            else if ctrl.createTextRange
              range = ctrl.createTextRange()
              range.collapse true
              range.moveEnd 'character', pos
              range.moveStart 'character', pos
              range.select()
        catch e
        return
      events: ->
        el.on('keydown.mask', ->
          old_value = p.val()
          return
        ).on('keyup.mask', p.behaviour).on('paste.mask drop.mask', ->
          setTimeout (->
            el.keydown().keyup()
            return
          ), 100
          return
        ).on('change.mask', ->
          el.data 'changed', true
          return
        ).on('blur.mask', ->
          if old_value != el.val() and !el.data('changed')
            el.trigger 'change'
          el.data 'changed', false
          return
        ).on 'focusout.mask', ->
          if options.clearIfNotMatch and !regexMask.test(p.val())
            p.val ''
          return
        return
      getRegexMask: ->
        maskChunks = []
        translation = undefined
        pattern = undefined
        optional = undefined
        recursive = undefined
        oRecursive = undefined
        r = undefined
        i = 0
        while i < mask.length
          translation = jMask.translation[mask[i]]
          if translation
            pattern = translation.pattern.toString().replace(/.{1}$|^.{1}/g, '')
            optional = translation.optional
            recursive = translation.recursive
            if recursive
              maskChunks.push mask[i]
              oRecursive =
                digit: mask[i]
                pattern: pattern
            else
              maskChunks.push if !optional and !recursive then pattern else pattern + '?'
          else
            maskChunks.push mask[i].replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&')
          i++
        r = maskChunks.join('')
        if oRecursive
          r = r.replace(new RegExp('(' + oRecursive.digit + '(.*' + oRecursive.digit + ')?)'), '($1)?').replace(new RegExp(oRecursive.digit, 'g'), oRecursive.pattern)
        new RegExp(r)
      destroyEvents: ->
        el.off([
          'keydown'
          'keyup'
          'paste'
          'drop'
          'change'
          'blur'
          'focusout'
          'DOMNodeInserted'
          ''
        ].join('.mask ')).removeData 'changeCalled'
        return
      val: (v) ->
        isInput = el.is('input')
        if arguments.length > 0 then (if isInput then el.val(v) else el.text(v)) else if isInput then el.val() else el.text()
      getMCharsBeforeCount: (index, onCleanVal) ->
        count = 0
        i = 0
        maskL = mask.length
        while i < maskL and i < index
          if !jMask.translation[mask.charAt(i)]
            index = if onCleanVal then index + 1 else index
            count++
          i++
        count
      caretPos: (originalCaretPos, oldLength, newLength, maskDif) ->
        translation = jMask.translation[mask.charAt(Math.min(originalCaretPos - 1, mask.length - 1))]
        if !translation then p.caretPos(originalCaretPos + 1, oldLength, newLength, maskDif) else Math.min(originalCaretPos + newLength - oldLength - maskDif, newLength)
      behaviour: (e) ->
        e = e or window.event
        keyCode = e.keyCode or e.which
        if $.inArray(keyCode, jMask.byPassKeys) == -1
          caretPos = p.getCaret()
          currVal = p.val()
          currValL = currVal.length
          changeCaret = caretPos < currValL
          newVal = p.getMasked()
          newValL = newVal.length
          maskDif = p.getMCharsBeforeCount(newValL - 1) - p.getMCharsBeforeCount(currValL - 1)
          if newVal != currVal
            p.val newVal
          # change caret but avoid CTRL+A
          if changeCaret and !(keyCode == 65 and e.ctrlKey)
            # Avoid adjusting caret on backspace or delete
            if !(keyCode == 8 or keyCode == 46)
              caretPos = p.caretPos(caretPos, currValL, newValL, maskDif)
            p.setCaret caretPos
          return p.callbacks(e)
        return
      getMasked: (skipMaskChars) ->
        buf = []
        value = p.val()
        m = 0
        maskLen = mask.length
        v = 0
        valLen = value.length
        offset = 1
        addMethod = 'push'
        resetPos = -1
        lastMaskChar = undefined
        check = undefined
        if options.reverse
          addMethod = 'unshift'
          offset = -1
          lastMaskChar = 0
          m = maskLen - 1
          v = valLen - 1

          check = ->
            m > -1 and v > -1

        else
          lastMaskChar = maskLen - 1

          check = ->
            m < maskLen and v < valLen

        while check()
          maskDigit = mask.charAt(m)
          valDigit = value.charAt(v)
          translation = jMask.translation[maskDigit]
          if translation
            if valDigit.match(translation.pattern)
              buf[addMethod] valDigit
              if translation.recursive
                if resetPos == -1
                  resetPos = m
                else if m == lastMaskChar
                  m = resetPos - offset
                if lastMaskChar == resetPos
                  m -= offset
              m += offset
            else if translation.optional
              m += offset
              v -= offset
            v += offset
          else
            if !skipMaskChars
              buf[addMethod] maskDigit
            if valDigit == maskDigit
              v += offset
            m += offset
        lastMaskCharDigit = mask.charAt(lastMaskChar)
        if maskLen == valLen + 1 and !jMask.translation[lastMaskCharDigit]
          buf.push lastMaskCharDigit
        buf.join ''
      callbacks: (e) ->
        val = p.val()
        changed = val != old_value
        if changed == true
          if typeof options.onChange == 'function'
            options.onChange val, e, el, options
        if changed == true and typeof options.onKeyPress == 'function'
          options.onKeyPress val, e, el, options
        if typeof options.onComplete == 'function' and val.length == mask.length
          options.onComplete val, e, el, options
        return
    # public methods
    jMask.mask = mask
    jMask.options = options

    jMask.remove = ->
      caret = undefined
      p.destroyEvents()
      p.val(jMask.getCleanVal()).removeAttr 'maxlength'
      caret = p.getCaret()
      p.setCaret caret - p.getMCharsBeforeCount(caret)
      el

    # get value without mask

    jMask.getCleanVal = ->
      p.getMasked true

    jMask.init = do ->
      options = options or {}
      jMask.byPassKeys = [
        9
        16
        17
        18
        36
        37
        38
        39
        40
        91
      ]
      jMask.translation =
        '0': pattern: /\d/
        '9':
          pattern: /\d/
          optional: true
        '#':
          pattern: /\d/
          recursive: true
        'A': pattern: /[a-zA-Z0-9]/
        'S': pattern: /[a-zA-Z]/
      jMask.translation = $.extend({}, jMask.translation, options.translation)
      jMask = $.extend(true, {}, jMask, options)
      regexMask = p.getRegexMask()
      if options.maxlength != false
        el.attr 'maxlength', mask.length
      if options.placeholder
        el.attr 'placeholder', options.placeholder
      el.attr 'autocomplete', 'off'
      p.destroyEvents()
      p.events()
      caret = p.getCaret()
      p.val p.getMasked()
      p.setCaret caret + p.getMCharsBeforeCount(caret, true)
      return
    return

  watchers = {}
  live = 'DOMNodeInserted.mask'

  HTMLAttributes = ->
    input = $(this)
    options = {}
    prefix = 'data-mask-'
    if input.attr(prefix + 'reverse')
      options.reverse = true
    if input.attr(prefix + 'maxlength') == 'false'
      options.maxlength = false
    if input.attr(prefix + 'clearifnotmatch')
      options.clearIfNotMatch = true
    input.mask input.attr('data-mask'), options
    return

  $.fn.mask = (mask, options) ->
    selector = @selector

    maskFunction = ->
      maskObject = $(this).data('mask')
      stringify = JSON.stringify
      if typeof maskObject != 'object' or stringify(maskObject.options) != stringify(options) or maskObject.mask != mask
        return $(this).data('mask', new Mask(this, mask, options))
      return

    @each maskFunction
    if selector and !watchers[selector]
      # dynamically added elements.
      watchers[selector] = true
      setTimeout (->
        $(document).on live, selector, maskFunction
        return
      ), 500
    return

  $.fn.unmask = ->
    try
      return @each(->
        $(this).data('mask').remove().removeData 'mask'
        return
      )
    catch e
    return

  $.fn.cleanVal = ->
    @data('mask').getCleanVal()

  # looking for inputs with data-mask attribute
  $('*[data-mask]').each HTMLAttributes
  # dynamically added elements with data-mask html notation.
  $(document).on live, '*[data-mask]', HTMLAttributes
  return

# ---
# generated by js2coffee 2.1.0
