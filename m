From: Mark Lord <lkml@rtr.ca>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Thu, 05 Mar 2009 10:40:44 -0500
Message-ID: <49AFF27C.1020001@rtr.ca>
References: <1235996477.5330.174.camel@laptop> <alpine.LFD.2.00.0903020852220.3111@localhost.localdomain> <200903021045.20723.vlobanov@speakeasy.net> <alpine.LFD.2.00.0903021048570.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rtr.ca ([76.10.145.34]:46243 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754886AbZCEPks (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 5 Mar 2009 10:40:48 -0500
In-Reply-To: <alpine.LFD.2.00.0903021048570.3111@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Linus Torvalds wrote:
>
> Although it porbably does mean that the problem tends to be more in the 
> really bad mode0 case (600ns -> 150us/sector -> milliseconds for 
> multi-sector transfers).
..

Heh.. it's worse that that: even with commonplace mode4 (120ns) transfers,
each PCI bus transaction from start to finish often takes about 1us,
so for a 16-sector multi-sector read, that means 4ms+ with interrupts off.

> I forget what our multi-sector limit is, I think it tends to be 16. So 
> you'll never get _really_ long irq-off times, but "several ms" is still 
> pretty damn bad. 
..

It's a device limit, usually 8 or 16 sectors for nearly all drives now.

Cheers
