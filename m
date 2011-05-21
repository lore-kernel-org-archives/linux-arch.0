From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Software prefetching considered harmful
Date: Sat, 21 May 2011 14:18:55 +1000
Message-ID: <1305951535.7481.198.camel@pasglop>
References: <BANLkTim5MaJBYSuTnXfmOjgPNVOyZSgQuQ@mail.gmail.com>
	 <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
	 <20110519192842.GA7421@elte.hu>  <4DD73384.6080407@orcon.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41666 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926Ab1EUET3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 21 May 2011 00:19:29 -0400
In-Reply-To: <4DD73384.6080407@orcon.net.nz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Cree <mcree@orcon.net.nz>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, Russell King <rmk@arm.linux.org.uk>

On Sat, 2011-05-21 at 15:37 +1200, Michael Cree wrote:
> While this is not a concern to the kernel (it obviously has access to
> location 0) 

Not that obvious... dunno how you do your memory map on alpha but on
most architectures, 0 is userspace even when you're in the kernel and is
typically not mapped.

Cheers,
Ben.

> I can imagine some neophyte thinking (as I have done myself)
> "I'll look to see how the kernel implements lists and use that because
> it will be both clever and well tested code" without realising that the
> prefetch of a NULL is very inefficient for userspace!
> 
> 
