# Model-View-Delegate

As soon as the amount of data goes beyond the trivial, it is no longer feasible to keep a copy of the data with the presentation. This means that the presentation layer, what is seen by the user, needs to be separated by the data layer, the actual contents. In Qt Quick, data is separated from the presentation through a so called model-view separation. Qt Quick provides a set of premade views in which each data element is the visualization by a delegate. To utilize the system, one must understand these classes and know how to create appropriate delegates to get the right look and feel.

