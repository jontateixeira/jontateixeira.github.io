<!--
.. title: Creating gantt plot using gnuplot
.. slug: gantt-plot-using-gnuplot
.. date: 2019-12-31 09:07:20 UTC-03:00
.. tags: gnuplot, schedule, gantt plot, plot
.. category: utilities
.. link: 
.. description: creating gantt plot using gnuplot
.. type: text
-->

At the beginning of the year, it is the period for writing the proposal (or for the master's thesis or doctoral dissertation), iin some programs, as like the [UFPE chemical engineering post-graduate](https://www.ufpe.br/ppgeq), there is a requirement to prepare a schedule of activities proposed to carry out the work. For this reason, I am writing this post, to help to generate something like a Gantt chart showing when a task has started and ended.

Gnuplot is a very versatile tool when we want to work with graphics generation. Doing a quick survey of how to generate a Gantt chart using Gnuplot, we find [some examples](http://gnuplot.sourceforge.net/demo_5.5/gantt.html) or in [Python](http://wiki.mn.wtb.tue.nl/wonham/gantt.py) and [Latex](https://fr.overleaf.com/latex/examples/gantt-charts-with-the-pgfgantt-package/jmkwfxrnfxnw).

Using some Gnuplot internal functions, we wrote [this script](/files/gantt-plot-using-gnuplot/schedule_gantt.plt) that produces a simple Gantt chart (a schedule of activities):

<img src="/files/gantt-plot-using-gnuplot/scheduleThesisGantt.png" width=500>

Feel free to use my script and modify it in any way you like!
