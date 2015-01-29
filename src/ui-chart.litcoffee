#ui-chart
Render a chart with simple numerical data series. This makes charts a
declarative markup activity.

    Rickshaw = require 'rickshaw'

    Polymer 'ui-chart',

##Events

##Attributes and Change Handlers

##Methods
###render
Turn the data in series into visual graphs. OK -- so why on Earth is series
both the plural and the singular. Serii?

This carries along styling from the `<series>` in the overall markup, so color
things there.

      render: ->
        allSeries = @querySelectorAll 'series'
          .array()
          .map (series) ->
            if series.value
              data = series.value.map (datum, i) -> {x: i, y: datum}
            else
              data = series.innerText.split(' ').map (datum, i) -> {x: i, y: Number(datum)}
            console.log data
            data: data
            color: window.getComputedStyle(series).getPropertyValue('color')
        @graph = new Rickshaw.Graph
          renderer: @type
          element: @$.display
          series: allSeries
        if @querySelector 'xaxis[grid]'
          @xaxis = new Rickshaw.Graph.Axis.X
            graph: @graph
            orientation: 'bottom'
            element: @$.xaxis
            tickFormat: -> ''
        if @querySelector 'yaxis[grid]'
          @yaxis = new Rickshaw.Graph.Axis.Y
            graph: @graph
            tickFormat: (y) ->
              y if y

        bounds = @$.display.  getBoundingClientRect()
        @graph.setSize
          width: bounds.right - bounds.left
          height: bounds.bottom - bounds.top
        @graph.render()
        @onMutation @, @render

##Event Handlers

##Polymer Lifecycle

      created: ->

      ready: ->

      attached: ->
        @render()
        window.addEventListener 'resize', =>
          @$.display.removeChild @shadowRoot.querySelector 'svg'
          @render()

      domReady: ->

      detached: ->
