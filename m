From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Mon, 2 Mar 2009 10:54:35 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0903021048570.3111@localhost.localdomain>
References: <1235996477.5330.174.camel@laptop> <alpine.LFD.2.00.0903020852220.3111@localhost.localdomain> <200903021045.20723.vlobanov@speakeasy.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45343 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758572AbZCBSza (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2009 13:55:30 -0500
In-Reply-To: <200903021045.20723.vlobanov@speakeasy.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>



On Mon, 2 Mar 2009, Vadim Lobanov wrote:

> On Monday 02 March 2009 09:11:54 Linus Torvalds wrote:
> > The thing is, with PIO, a 512-byte disk read ends up doing 256 16-bit word
> > reads from the controller, each potentially up to 600ns long (PIO0
> > timings). That's 150ms - for a single sector!
> 
> Out of curiosity, the peanut gallery wishes to ask:
> Is the above supposed to be 600us (*1000), or 150us (/1000)? Probably the 
> latter.

Sorry, I was off by a lot. Yes. /1000. The end result ends up being lots 
better (and I should have realized I did my conversion wrong, because the 
times ended up being _so_ big), but not better enough - we've had dropped 
timer interrupts etc on those kinds of machines unless you use "hdparm -u1".

Although it porbably does mean that the problem tends to be more in the 
really bad mode0 case (600ns -> 150us/sector -> milliseconds for 
multi-sector transfers).

I forget what our multi-sector limit is, I think it tends to be 16. So 
you'll never get _really_ long irq-off times, but "several ms" is still 
pretty damn bad. 

			Linus
