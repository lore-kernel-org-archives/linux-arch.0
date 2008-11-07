From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC patch 08/18] cnt32_to_63 should use smp_rmb()
Date: Fri, 07 Nov 2008 16:55:59 +0000
Message-ID: <8445.1226076959@redhat.com>
References: <alpine.LFD.2.00.0811071129440.13034@xanadu.home> <20081107003816.9b0f947a.akpm@linux-foundation.org> <20081107052336.652868737@polymtl.ca> <20081107053349.861709786@polymtl.ca> <20081106220530.5b0e3a96.akpm@linux-foundation.org> <alpine.LFD.2.00.0811070256450.13034@xanadu.home> <25363.1226056819@redhat.com> <alpine.LFD.2.00.0811070952150.13034@xanadu.home> <20081107075003.fa93ccf4.akpm@linux-foundation.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:57363 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595AbYKGQ4t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 7 Nov 2008 11:56:49 -0500
In-Reply-To: <alpine.LFD.2.00.0811071129440.13034@xanadu.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
Cc: dhowells@redhat.com, Andrew Morton <akpm@linux-foundation.org>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:

> > Well I'm glad it wasn't designed to demonstrate tastefulness.
> 
> Fast tricks aren't always meant to be beautiful.  That,s why we have 
> abstraction layers.

And comments.  The comment attached to cnt32_to_63() is well written and
informative.

> I know nothing about mn10300.

That's aimed my way.

David
