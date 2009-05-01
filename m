From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/27] asm-generic: add legacy I/O header files
Date: Fri, 1 May 2009 14:09:04 +0100
Message-ID: <20090501140904.69f44406@lxorguk.ukuu.org.uk>
References: <cover.1241105648.git.arnd@arndb.de>
	<10b3a32656e5552458db7412ef9ff8530d5f92aa.1241105648.git.arnd@arndb.de>
	<c1a198be0904302309w4154f97dqddd0b2df1924a821@mail.gmail.com>
	<200905011422.29753.arnd@arndb.de>
	<49FAEA2A.50504@monstr.eu>
	<20090501123728.GC27799@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38036 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754194AbZEANIX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 09:08:23 -0400
In-Reply-To: <20090501123728.GC27799@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Michal Simek <monstr@monstr.eu>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Fri, 1 May 2009 13:37:28 +0100
Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Fri, May 01, 2009 at 02:25:14PM +0200, Michal Simek wrote:
> > Arnd Bergmann wrote:
> > > On Friday 01 May 2009, Michal Simek wrote:
> > >>> +/*
> > >>> + * CLOCK_TICK_RATE is highly PC-specific and should not
> > >>> + * be used in portable code. 1193182 is the value for the
> > >>> + * original i8253 PIC.
> > >>> + */
> > >>> +#ifndef CLOCK_TICK_RATE
> > >>> +#define CLOCK_TICK_RATE                1193182
> > >>> +#endif
> > >>
> > >> Why is this in generic code?
> > > 
> > > CLOCK_TICK_RATE is only used in a few places:

Joining in late but its not at all highly PC specific. The same frequency
is used for a whole pile of setups (Alpha etc). It's not well named but
there are good sound reasons the PC chose 1193182 and while those reasons
have long lapsed its a good frequency for other reasons nowdays.

The clock isn't for the PIC either - its for the PIT (although its used
to clock various other things).

We actually have a define of PIT_TICK_RATE internal to the x86 port for
those x86 cases that can use it.





Alan
