From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/27] asm-generic: add legacy I/O header files
Date: Fri, 1 May 2009 14:44:20 +0100
Message-ID: <20090501144420.5a3e9c6e@lxorguk.ukuu.org.uk>
References: <cover.1241105648.git.arnd@arndb.de>
	<20090501123728.GC27799@flint.arm.linux.org.uk>
	<20090501140904.69f44406@lxorguk.ukuu.org.uk>
	<200905011529.04774.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:53311 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756194AbZEANng (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 09:43:36 -0400
In-Reply-To: <200905011529.04774.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Michal Simek <monstr@monstr.eu>, linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

> /*
>  * CLOCK_TICK_RATE is traditionally the base frequency using the PC-style
>  * i8253 "PIT" timer. Architecture independent device drivers should not
>  * rely on this value.
>  * Any architecture that either has a real PC-style PIT, or does not have a
>  * fixed timer interval at all and just needs to provide some value here
>  * should just fall back to this default.
>  */

They shouldn't define it - we want those invalid cases to error. Stick
CLOCK_TICK_RATE in the depths of the x86 arch includes and then we can
fix the other cases properly. Either the device has an independant clock
of the same frequency (some watchdogs do this), it relies upon a
motherboard timer in which case the platform can define CLOCK_TICK_RATE
(or a better name for it), or it doesn't have any meaning in which case
we *want* it not to compile.
