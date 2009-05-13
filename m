From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm: rename CLOCK_TICK_RATE to ARM_TICK_RATE
Date: Wed, 13 May 2009 19:11:22 +0200
Message-ID: <200905131911.23473.arnd@arndb.de>
References: <20090511222702.352192505@arndb.de> <20090511222702.352192505@arndb.de>> <200905112243.10011.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:52963 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbZEMRLb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2009 13:11:31 -0400
In-Reply-To: <200905112243.10011.arnd@arndb.de>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Tuesday 12 May 2009, Arnd Bergmann wrote:
> Most of the users of CLOCK_TICK_RATE in the kernel outside
> of ARM assume that it refers to the i8253 base frequency
> of 1.193182 Mhz, while in ARM it actually is the clock
> frequency of the timer.
> 
> By renaming it to ARM_TICK_RATE for all arm specific
> device drivers, we can hopefully reduce the amount
> of confusion slightly.

My patch was missing one important change to make this
a nonintrusive change:

--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -14,6 +14,8 @@
 
 #include <mach/timex.h>
 
+#define CLOCK_TICK_RATE ARM_TICK_RATE
+
 typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles (void)

	Arnd <><
