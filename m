From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC patch 15/15] LTTng timestamp x86
Date: Fri, 24 Oct 2008 08:54:43 +1100
Message-ID: <18688.62115.341529.412042@cargo.ozlabs.ibm.com>
References: <20081016232729.699004293@polymtl.ca>
	<alpine.LFD.2.00.0810201451190.3287@nehalem.linux-foundation.org>
	<48FD0633.70604@zytor.com>
	<200810211211.00332.bjorn.helgaas@hp.com>
	<alpine.LFD.2.00.0810230838410.3287@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:51349 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366AbYJWVyu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Oct 2008 17:54:50 -0400
In-Reply-To: <alpine.LFD.2.00.0810230838410.3287@nehalem.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, "H. Peter Anvin" <hpa@zytor.com>, john stultz <johnstul@us.ibm.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, "Luck, Tony" <tony.luck@intel.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>

Linus Torvalds writes:

> They are almost inevitable for another reason too: the interconnect seldom 
> has a concept of "clock signal" other than for the signalling itself, and 
> the signal clock is designed for the signal itself and is designed for 
> signal integrity rather than "stable clock".
> 
> Does _any_ common interconnect have integral support for clock 
> distribution?

I realize you're asking about x86, but just for interest, this is what
POWER6 does to give us a timebase register that increments at 512MHz
and is synchronized across the machine (i.e. sufficiently well
synchronized that the difference between the timebases on any two
cores is less than the time taken for them to synchronize via a memory
location).

The hardware distributes a 32MHz clock pulse to all nodes, which
increments the upper 60 bits of the timebase and clears the bottom 4
bits.  The bottom 4 bits are then incremented at a rate that is the
processor clock speed divided by some number N set by the hypervisor.
The bottom 4 bits also stop incrementing once they reach 0xf.

This seems to work pretty well in practice and avoids the need for
hardware to distribute a synchronous 512MHz clock everywhere.

Paul.
