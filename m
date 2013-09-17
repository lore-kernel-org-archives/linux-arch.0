From: David Miller <davem@davemloft.net>
Subject: Re: [patch 5/6] sparc: Use preempt_schedule_irq
Date: Tue, 17 Sep 2013 18:54:28 -0400 (EDT)
Message-ID: <20130917.185428.2155214782234196428.davem@davemloft.net>
References: <20130917082838.218329307@infradead.org>
	<20130917182350.449685712@linutronix.de>
	<20130917183628.966769884@linutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:43156 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab3IQWyf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Sep 2013 18:54:35 -0400
In-Reply-To: <20130917183628.966769884@linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, ak@linux.intel.com, hpa@zytor.com, bitbucket@online.de, arjan@linux.intel.com, fweisbec@gmail.com

From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 17 Sep 2013 18:53:08 -0000

>  		bne,pn			%xcc, kern_fpucheck
> -		 sethi			%hi(PREEMPT_ACTIVE), %l6
> -		stw			%l6, [%g6 + TI_PRE_COUNT]
> -		call			schedule
> +		call			preempt_schedule_irq
>  		 nop

You've put the function call into the delay slot of the branch,
which you don't want to do.

That's, btw, why we indent instructions with an extra space like
that, to emphasize that it's a delay slot of the preceeding
branch.
