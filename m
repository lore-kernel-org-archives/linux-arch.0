From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC patch 15/15] LTTng timestamp x86
Date: Tue, 21 Oct 2008 12:10:58 -0600
Message-ID: <200810211211.00332.bjorn.helgaas@hp.com>
References: <20081016232729.699004293@polymtl.ca> <alpine.LFD.2.00.0810201451190.3287@nehalem.linux-foundation.org> <48FD0633.70604@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:25864 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163AbYJUSLG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Oct 2008 14:11:06 -0400
In-Reply-To: <48FD0633.70604@zytor.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, john stultz <johnstul@us.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, "Luck, Tony" <tony.luck@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>

On Monday 20 October 2008 04:29:07 pm H. Peter Anvin wrote:
> Linus Torvalds wrote:
> > 
> > But it's not going to solve the "hey, I have 512 CPU's, they are all on 
> > different boards, and no, they are _not_ synchronized to one global 
> > clock!".
> > 
> > That's why I'd suggest making _purely_ local time, and then aiming for 
> > something NTP-like. But maybe there are better solutions out there.
> 
> At the same time, it would definitely be nice to encourage vendors of 
> large SMP systems to provide a common root crystal (frequency standard) 
> for a single SMP domain.  Preferrably a really good one, TCXO or better.

A single root crystal is nice for us software guys.  But it often
also turns into a single point of failure, which the hardware guys
are always trying to eliminate.  So I think multiple crystals are
inevitable for the really large machines.

Bjorn
