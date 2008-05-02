From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/10] Add generic helpers for arch IPI function calls
Date: Fri, 2 May 2008 06:09:22 -0700
Message-ID: <20080502130922.GC15522@linux.vnet.ibm.com>
References: <20080502122955.GB15522@linux.vnet.ibm.com> <27854.1209732644@ocs10w>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:32981 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493AbYEBNJ0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 2 May 2008 09:09:26 -0400
Content-Disposition: inline
In-Reply-To: <27854.1209732644@ocs10w>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: Nick Piggin <npiggin@suse.de>, Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org, peterz@infradead.org, linux-arch@vger.kernel.org, jeremy@goop.org, mingo@elte.hu

On Fri, May 02, 2008 at 10:50:44PM +1000, Keith Owens wrote:
> "Paul E. McKenney" (on Fri, 2 May 2008 05:29:55 -0700) wrote:
> >OK -- for some reason, I was thinking that it was illegal to
> >invoke smp_call_function() with irqs disabled...
> >
> >Ah, I see it -- smp_call_function_mask() says:
> >
> > * You must not call this function with disabled interrupts or from a
> > * hardware interrupt handler or from a bottom half handler.
> >
> >So we have no problem with smp_call_function, then.
> >
> >OK, so smp_call_function() -can- be invoked with irqs disabled?
> >Hmmm...  I will give this some thought.
> 
> Doing any smp_call_function with interrupts disabled is a potential
> deadlock.  See http://lkml.org/lkml/2004/5/2/116.

OK, cool, thank you for the confirmation!

Therefore, when you call smp_call_function(), you may get calls from
other CPUs showing up, and therefore my polling approach does not
introduce any new strands of spaghetti.  ;-)

						Thanx, Paul
