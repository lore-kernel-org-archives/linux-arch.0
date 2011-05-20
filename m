From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Software prefetching considered harmful
Date: Fri, 20 May 2011 19:13:28 +1000
Message-ID: <1305882808.7481.163.camel@pasglop>
References: <BANLkTim5MaJBYSuTnXfmOjgPNVOyZSgQuQ@mail.gmail.com>
	 <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
	 <1305855769.7481.114.camel@pasglop>  <20110520083442.GB22802@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:46324 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935447Ab1ETJNu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 May 2011 05:13:50 -0400
In-Reply-To: <20110520083442.GB22802@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, Russell King <rmk@arm.linux.org.uk>


> Yeah, over the past 10 years we have been suffering from an increasing level of 
> blindness in the area of x86 performance analysis. Our old tools gradually 
> deteriorated, the hardware got smarter and more parallel and it was harder and 
> harder to see what happens. The 32-bit/64-bit split did not help us stay 
> focused either. I think i warned about this 4-5 years ago at a KS.
> 
> This has improved meanwhile, we now have better tools (*wink* :) and have a 
> good performance monitoring model (*wink* :) and people are again looking at 
> the fine details and i think we now have a good chance to speed up the kernel 
> again and keep it fast - and not just on PowerPC which has its envied Olympus 
> of performance gods! :-)

Hehe, right. I agree completely.

> Watching out for performance is a fundamentally critical mass thing: for a long 
> time it seems a Sisyphean task with little progress, then it just happens very 
> quickly.

I used to pay a lot more attention to performance myself than I do
nowadays, and that is definitely not a good thing. Mostly blame being
swamped with other things but still something I need to remedy in the
near future.

Cheers,
Ben.
