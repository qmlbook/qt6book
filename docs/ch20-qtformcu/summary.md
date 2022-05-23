# Summary

In this chapter we've scratched the surface of Qt for MCUs and Qt Quick Ultralite. These technologies bring Qt to much smaller platforms and make it truly embeddable. Through-out this chapter, we've used the virtual desktop target, which allows for quick prototyping. Targeting a specific board is just as easy, but requires access to hardware and the associated tools.

Key take-aways from using Qt Quick Ultralite is that there are fewer built in elements, and that some APIs are slightly more restricted. But given the intended target systems, this is usually not a hindrance. Qt Quick Ultralite also turns QML into a compiled language, which actually is nice. It allows you to catch more errors during compile time, instead of having to test more during run time.
