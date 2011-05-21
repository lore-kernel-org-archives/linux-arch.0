From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Software prefetching considered harmful
Date: Sat, 21 May 2011 12:42:09 +0200
Message-ID: <20110521104209.GB26447@elte.hu>
References: <BANLkTim5MaJBYSuTnXfmOjgPNVOyZSgQuQ@mail.gmail.com>
 <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
 <20110519192842.GA7421@elte.hu>
 <4DD73384.6080407@orcon.net.nz>
 <1305951535.7481.198.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:36447 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115Ab1EUKm2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 21 May 2011 06:42:28 -0400
Content-Disposition: inline
In-Reply-To: <1305951535.7481.198.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Cree <mcree@orcon.net.nz>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, Russell King <rmk@arm.linux.org.uk>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2011-05-21 at 15:37 +1200, Michael Cree wrote:
> > While this is not a concern to the kernel (it obviously has access to
> > location 0) 
> 
> Not that obvious... dunno how you do your memory map on alpha but on
> most architectures, 0 is userspace even when you're in the kernel and is
> typically not mapped.

Correct, it's like that on x86 as well.

Filtering out NULLs in the prefetch primitives or making sure NULL never gets 
prefetched looks like to be a generally good idea.

Thanks,

	Ingo
