From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 08/34] arm: Use generic idle loop
Date: Mon, 25 Mar 2013 15:02:39 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303251501520.22263@ionos>
References: <20130321214930.752934102@linutronix.de> <20130321215233.826238797@linutronix.de> <87zjxv9lga.fsf@linaro.org> <alpine.LFD.2.02.1303251230440.22263@ionos> <20130325114808.GQ4977@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48232 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757738Ab3CYOCo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Mar 2013 10:02:44 -0400
In-Reply-To: <20130325114808.GQ4977@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kevin Hilman <khilman@linaro.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Magnus Damm <magnus.damm@gmail.com>

On Mon, 25 Mar 2013, Russell King - ARM Linux wrote:

> On Mon, Mar 25, 2013 at 12:31:20PM +0100, Thomas Gleixner wrote:
> > On Fri, 22 Mar 2013, Kevin Hilman wrote:
> > 
> > > Hi Thomas,
> > > 
> > > Thomas Gleixner <tglx@linutronix.de> writes:
> > > 
> > > > Use the generic idle loop and replace enable/disable_hlt with the
> > > > respective core functions.
> > > >
> > > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Russell King <linux@arm.linux.org.uk>
> > > 
> > > I gave patches 1-5 + this a quick spin on ARM (specifially some OMAP3 and
> > > OMAP4 platforms, with and without CPUidle enabled.)
> > > 
> > > The OMAP stuff needed a couple minor compile fixes (below), but
> > > otherwise it passes the quick "seems to work" test.
> > 
> > Yeah, that's needed for the other arch/arm conversions as well.
> 
> So, the only patch I got was this one, which is useless to test on its
> own...

I'm testing V2 now and will post an git URL with a testing branch
later tonight.

Thanks,

	tglx
