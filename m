From: David Miller <davem@davemloft.net>
Subject: Re: [RFC][PATCH] sched_clock_cpu()
Date: Sat, 03 May 2008 21:16:46 -0700 (PDT)
Message-ID: <20080503.211646.250661233.davem@davemloft.net>
References: <1209832169.6929.42.camel@lappy>
	<20080503165511.GA21967@elte.hu>
	<20080503173023.GA2394@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38539
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750711AbYEDEQy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 00:16:54 -0400
In-Reply-To: <20080503173023.GA2394@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dhaval@linux.vnet.ibm.com
Cc: mingo@elte.hu, a.p.zijlstra@chello.nl, tglx@linutronix.de, guichaz@gmail.com, andi@firstfloor.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, efault@gmx.de

From: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Date: Sat, 3 May 2008 23:00:23 +0530

> On Sat, May 03, 2008 at 06:55:11PM +0200, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > 
> > > it _DOESN'T_ boot ;-/ [...]
> > 
> > FYI, the merged version against sched-devel.git does boot fine here and 
> > the clock does seem to advance as expected.
> > 
> 
> boots here against linus as well.

If you tested on powerpc (just guessing), did you set
HAVE_STABLE_CLOCK in arch/powerpc/Kconfig?  That's
what you'll need to do to take advantage of the
new code.
