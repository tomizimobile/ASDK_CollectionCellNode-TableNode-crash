# ASDK_CollectionCellNode-TableNode-crash

This project demonstrates an issue when adding an `ASTableNode` to an `ASCellNode` in an `ASCollectionView`. When the view controller is dealloced, the following crash occurs:

```
*** Assertion failure in -[ASCollectionView dealloc], /SourceCache/UIKit/UIKit-3347.44.2/UICollectionView.m:690
*** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'UICollectionView (<ASCollectionView: 0x156013400; baseClass = UICollectionView; frame = (0 0; 414 736); clipsToBounds = YES; gestureRecognizers = <NSArray: 0x170051af0>; layer = <CALayer: 0x170035420>; contentOffset: {0, -64}; contentSize: {414, 63}> collection view layout: <UICollectionViewFlowLayout: 0x155d08b90>) was deallocated while an update was in flight'
```
```
* thread #1: tid = 0xed4c2, 0x00000001971840a8 libobjc.A.dylib`objc_exception_throw, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
    frame #0: 0x00000001971840a8 libobjc.A.dylib`objc_exception_throw
    frame #1: 0x00000001854b0198 CoreFoundation`+[NSException raise:format:arguments:] + 116
    frame #2: 0x0000000186364ed4 Foundation`-[NSAssertionHandler handleFailureInMethod:object:file:lineNumber:description:] + 112
    frame #3: 0x000000018a0adc64 UIKit`-[UICollectionView dealloc] + 1104
  * frame #4: 0x00000001000ba7ac AsyncDisplayKit`-[ASCollectionView dealloc](self=0x000000015e05e000, _cmd="dealloc") + 156 at ASCollectionView.mm:259
    frame #5: 0x000000018538d458 CoreFoundation`CFRelease + 524
    frame #6: 0x0000000185399a18 CoreFoundation`-[__NSArrayM dealloc] + 152
    frame #7: 0x000000019719d724 libobjc.A.dylib`(anonymous namespace)::AutoreleasePoolPage::pop(void*) + 564
    frame #8: 0x0000000185391074 CoreFoundation`_CFAutoreleasePoolPop + 28
    frame #9: 0x00000001854658a8 CoreFoundation`__CFRunLoopRun + 1500
    frame #10: 0x00000001853912d4 CoreFoundation`CFRunLoopRunSpecific + 396
    frame #11: 0x000000018ede76fc GraphicsServices`GSEventRunModal + 168
    frame #12: 0x0000000189f8ef40 UIKit`UIApplicationMain + 1488
    frame #13: 0x00000001000274e8 ASDK_CollectionCellNode-TableNode-crash`main + 136 at AppDelegate.swift:12
    frame #14: 0x000000019782ea08 libdyld.dylib`start + 4
```
