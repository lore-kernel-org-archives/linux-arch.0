From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] sparc: Use generic idle loop
Date: Mon, 08 Apr 2013 15:24:49 -0400 (EDT)
Message-ID: <20130408.152449.169732563685022388.davem@davemloft.net>
References: <20130401090620.GA24861@merkur.ravnborg.org>
	<5162B92E.6020703@linux.vnet.ibm.com>
	<20130408171035.GA27264@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:51942 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761523Ab3DHTYy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 8 Apr 2013 15:24:54 -0400
In-Reply-To: <20130408171035.GA27264@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: sam@ravnborg.org
Cc: srivatsa.bhat@linux.vnet.ibm.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, rusty@rustcorp.com.au, paulmck@linux.vnet.ibm.com, mingo@elte.hu, peterz@infradead.org, magnus.damm@gmail.com

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 8 Apr 2013 19:10:35 +0200

> I think not.
> local_irq_disable writes 0 to the PIL register,
> whereas the above code set the IE (Interrupt enable) bit to 0.
> 
> So the implementations differs - and I think there is a good
> reason for being so.
> 
> But this is the part where I refer to that I am fooling around
> in code that I do not understand.
> I re-checked the SPARC V9 manual - but I did not within a few minutes
> reading understand what is the difference between the twoo.

Device interrupts arrive first as high-priority interrupt packets
that are serviced by traps which are enabled only if PSTATE.IE is
set.

These trap handlers reschedule the interrupt quickly into a PIL
levelled interrupt, whose delivery is covered by (%pil & PSTATE.IE)

The sun4v sleeping code requires that we have PSTATE.IE clear over
the cpu sleep hypervisor call.
