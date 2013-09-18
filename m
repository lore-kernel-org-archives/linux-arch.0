From: David Miller <davem@davemloft.net>
Subject: Re: [patch 5/6] sparc: Use preempt_schedule_irq
Date: Tue, 17 Sep 2013 20:12:57 -0400 (EDT)
Message-ID: <20130917.201257.416297667094537063.davem@davemloft.net>
References: <20130917183628.966769884@linutronix.de>
	<20130917.185428.2155214782234196428.davem@davemloft.net>
	<alpine.DEB.2.02.1309180120570.4089@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:44804 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753853Ab3IRANC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 17 Sep 2013 20:13:02 -0400
In-Reply-To: <alpine.DEB.2.02.1309180120570.4089@ionos.tec.linutronix.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, ak@linux.intel.com, hpa@zytor.com, bitbucket@online.de, arjan@linux.intel.com, fweisbec@gmail.com

From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 18 Sep 2013 01:23:58 +0200 (CEST)

> I knew that I'd get it wrong :) So is adding another nop the right
> thing to do ?
> 
>  		bne,pn			%xcc, kern_fpucheck
> -		 sethi			%hi(PREEMPT_ACTIVE), %l6
> -		stw			%l6, [%g6 + TI_PRE_COUNT]
> -		call			schedule
> +  		 nop
> +		call			preempt_schedule_irq
>   		 nop

Yep, that's perfect:

Acked-by: David S. Miller <davem@davemloft.net>
