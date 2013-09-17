From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 5/6] sparc: Use preempt_schedule_irq
Date: Wed, 18 Sep 2013 01:23:58 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1309180120570.4089@ionos.tec.linutronix.de>
References: <20130917082838.218329307@infradead.org> <20130917182350.449685712@linutronix.de> <20130917183628.966769884@linutronix.de> <20130917.185428.2155214782234196428.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55552 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab3IQXYC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Sep 2013 19:24:02 -0400
In-Reply-To: <20130917.185428.2155214782234196428.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, ak@linux.intel.com, hpa@zytor.com, bitbucket@online.de, arjan@linux.intel.com, fweisbec@gmail.com

On Tue, 17 Sep 2013, David Miller wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Tue, 17 Sep 2013 18:53:08 -0000
> 
> >  		bne,pn			%xcc, kern_fpucheck
> > -		 sethi			%hi(PREEMPT_ACTIVE), %l6
> > -		stw			%l6, [%g6 + TI_PRE_COUNT]
> > -		call			schedule
> > +		call			preempt_schedule_irq
> >  		 nop
> 
> You've put the function call into the delay slot of the branch,
> which you don't want to do.
> 
> That's, btw, why we indent instructions with an extra space like
> that, to emphasize that it's a delay slot of the preceeding
> branch.

I knew that I'd get it wrong :) So is adding another nop the right
thing to do ?

 		bne,pn			%xcc, kern_fpucheck
-		 sethi			%hi(PREEMPT_ACTIVE), %l6
-		stw			%l6, [%g6 + TI_PRE_COUNT]
-		call			schedule
+  		 nop
+		call			preempt_schedule_irq
  		 nop
 
Thanks,

	tglx
