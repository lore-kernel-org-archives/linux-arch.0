Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S270580AbUJUGGZ@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44200 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S270460AbUJUGF5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Oct 2004 02:05:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id i9L65ABG023839
	for <linux-arch@vger.kernel.org>; Thu, 21 Oct 2004 01:05:10 -0500
Subject: Interrupts & total mess
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1098338732.3939.20.camel@gaston>
Mime-Version: 1.0
Date: Thu, 21 Oct 2004 16:05:32 +1000
Content-Transfer-Encoding: 7bit
To: Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Ok so my simple project of adding NO_IRQ definitions all over the place
is turning into a nightmare for various reasons (the probe_irq_* stuff
beeing one of them, as it currently prevents using -1, so I'm leaning
toward defining NO_IRQ as beeing INT_MIN, nothing against that ?)

However, while trying to do that in a simple way, that is with a
 #ifndef NO_IRQ
 #define NO_IRQ		(INT_MIN)
 #endif

Somewhere in some generic piece of include after we has some asm/* stuff
included to let the arch a chance to override it, I figured that, first,
there are a number of places where "irq" is defined as beeing unsigned
long... So neither INT_MIN nor -1 are appropriate. Then I noticed while
looking for the right files to add this stuff that we have, at least:

include/linux/interrupts.h
include/linux/irq.h
include/linux/hardirq.h
include/asm-*/irq.h
include/asm-*/hw_irq.h
include/asm-*/hardirq.h

Which is seriously starting to make no sense, especially when you don't
really know who is including who, with also the strange rule of never
including linux/irq.h directly from a driver since the arch may not use
the definitions in there, etc... it's a complete can of worms...

So basically, linux/irq.h should be asm-generic/irq.h right ?

Then, all of the CONFIG_HARDIRQS_GENERIC stuff in linux/interrupts.h
should be moved there as well, since that's pretty much what the things
in linux/irq.h already define.

So our path should be:

toplevel include
	linux/interrupts.h (or rename it to linux/irq.h)
	  asm/irq.h (the arch implementation)
	    [asm-generic/irq.h] (optionally using the common defs)

but I'm not sure what to do with the various hardirq.h & hw_irq.h
thingies, at least one of the 2 arch ones should die.

I'm ready to start the (painful) work of cleaning that up, though
that will probably end up in a giga-patch touching hundreds of files
(just to change a #include directive most of the time) though I won't
fix all archs, I prefer not mucking aroudn with things I don't
understand.

But I'm not sure what we want to do here, so let's discuss it a bit.

Ben.
