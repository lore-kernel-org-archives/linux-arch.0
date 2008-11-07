From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC patch 08/18] cnt32_to_63 should use smp_rmb()
Date: Fri, 07 Nov 2008 17:04:57 +0000
Message-ID: <8481.1226077497@redhat.com>
References: <20081107164758.GB22134@Krystal> <20081107003816.9b0f947a.akpm@linux-foundation.org> <20081107052336.652868737@polymtl.ca> <20081107053349.861709786@polymtl.ca> <20081106220530.5b0e3a96.akpm@linux-foundation.org> <alpine.LFD.2.00.0811070256450.13034@xanadu.home> <25363.1226056819@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:52439 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016AbYKGRFj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 7 Nov 2008 12:05:39 -0500
In-Reply-To: <20081107164758.GB22134@Krystal>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org

Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> First off, using this macro with get_cycles() is simply buggy, because the
> macro expects _perfect_ order of timestamps, no skew whatsoever, or
> otherwise time could jump.

Erm...  Why can't I pass it get_cycles()?  Are you saying that sched_clock()
in MN10300 is wrong for it's use of get_cycles() with cnt32_to_63()?

> 	__x.lo = readl(cnt_lo); /* mmio read */

readl() might insert an extra barrier instruction.  Not only that, io_addr
must be unsigned long.

David
