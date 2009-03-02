From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH] irq: remove IRQF_DISABLED
Date: Mon, 2 Mar 2009 15:43:03 +0100
Message-ID: <20090302144303.GA30136@elte.hu>
References: <1235996477.5330.174.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:48288 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979AbZCBOnW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Mar 2009 09:43:22 -0500
Content-Disposition: inline
In-Reply-To: <1235996477.5330.174.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>


* Peter Zijlstra <peterz@infradead.org> wrote:

> Hi Linus,
> 
> Would you be willing to take such a patch?
> 
> Its a rather big one, but if you think its a good idea, I can 
> generate one against whatever tree is needed.
> 
> Provided I didn't break any !genirq stuff.. then again, that 
> might be a nice incentive to fix up those last few archs.

look good IMO. If there are no objections, and given that it 
modifies half a thousand of files i'd suggest we do this near 
the end of the merge window and not carry it in the genirq tree 
- while trivial it will still generate quite a bit of conflicts. 
Would that work with you?

	Ingo
