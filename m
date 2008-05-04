From: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH] sched_clock_cpu()
Date: Sun, 4 May 2008 10:39:19 +0530
Message-ID: <20080504050919.GC21789@linux.vnet.ibm.com>
References: <1209832169.6929.42.camel@lappy> <20080503170130.GB21967@elte.hu> <20080503.212607.157994166.davem@davemloft.net>
Reply-To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from E23SMTP02.au.ibm.com ([202.81.18.163]:43274 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbYEDFJf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 01:09:35 -0400
Content-Disposition: inline
In-Reply-To: <20080503.212607.157994166.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: mingo@elte.hu, a.p.zijlstra@chello.nl, tglx@linutronix.de, guichaz@gmail.com, andi@firstfloor.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, efault@gmx.de

On Sat, May 03, 2008 at 09:26:07PM -0700, David Miller wrote:
> From: Ingo Molnar <mingo@elte.hu>
> Date: Sat, 3 May 2008 19:01:30 +0200
> 
> > 
> > * Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> > 
> > > it _DOESN'T_ boot ;-/ and I seem to have caught a flu that makes my
> > > whole body hurt like hell, so I'm not getting anything done.
> > 
> > i think i see where your boot problem comes from:
> > 
> > > +struct sched_clock_data {
> > > +	spinlock_t lock;
> > 
> > that wont work very well when sched_clock() is called from within 
> > CONFIG_LOCK_STAT instrumentation. Does the patch below solve the boot 
> > problems for you?
> 
> Also, no platform can set HAVE_STABLE_CLOCK until we instantiate it in
> a Kconfig somewhere.  I've choosen to do it in kernel/Kconfig.hz and
> here are the sparc/sparc64 bits as well, I've booted this up with
> Peter's patch on my 64-cpu niagara2 box and done some basic testing.
> 
> It would be nice if a powerpc person could test the trivial
> powerpc Kconfig patch.
> 

On it. Let me get hold of a powerpc box here, and try it out.
-- 
regards,
Dhaval
