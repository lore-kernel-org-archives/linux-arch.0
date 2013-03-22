Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:37323 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423310Ab3CVVak (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 22 Mar 2013 17:30:40 -0400
Received: by mail-pa0-f49.google.com with SMTP id kp6so67853pab.8
        for <linux-arch@vger.kernel.org>; Fri, 22 Mar 2013 14:30:39 -0700 (PDT)
From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [patch 08/34] arm: Use generic idle loop
References: <20130321214930.752934102@linutronix.de>
	<20130321215233.826238797@linutronix.de>
Date: Fri, 22 Mar 2013 14:24:53 -0700
In-Reply-To: <20130321215233.826238797@linutronix.de> (Thomas Gleixner's
	message of "Thu, 21 Mar 2013 21:53:02 -0000")
Message-ID: <87zjxv9lga.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@arm.linux.org.uk>
Message-ID: <20130322212453.grkY1PkD8FvdPOgQhPDkqgnWogGs2fhZeuSYxYT6RYY@z>

Hi Thomas,

Thomas Gleixner <tglx@linutronix.de> writes:

> Use the generic idle loop and replace enable/disable_hlt with the
> respective core functions.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Russell King <linux@arm.linux.org.uk>

I gave patches 1-5 + this a quick spin on ARM (specifially some OMAP3 and
OMAP4 platforms, with and without CPUidle enabled.)

The OMAP stuff needed a couple minor compile fixes (below), but
otherwise it passes the quick "seems to work" test.

So at least for ARM/OMAP:

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin


diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 23c653a..db37f49 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -43,6 +43,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/atomic.h>
+#include <linux/cpu.h>
 
 #include <asm/fncpy.h>
 #include <asm/system_misc.h>
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3a6c6b8..2f17f95 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -138,6 +138,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/bootmem.h>
+#include <linux/cpu.h>
 
 #include <asm/system_misc.h>
