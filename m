From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC patch 08/18] cnt32_to_63 should use smp_rmb()
Date: Fri, 7 Nov 2008 09:21:15 -0800
Message-ID: <20081107092115.7c3c4a49.akpm@linux-foundation.org>
References: <20081107003816.9b0f947a.akpm@linux-foundation.org>
	<20081107052336.652868737@polymtl.ca>
	<20081107053349.861709786@polymtl.ca>
	<20081106220530.5b0e3a96.akpm@linux-foundation.org>
	<alpine.LFD.2.00.0811070256450.13034@xanadu.home>
	<25363.1226056819@redhat.com>
	<alpine.LFD.2.00.0811070952150.13034@xanadu.home>
	<20081107075003.fa93ccf4.akpm@linux-foundation.org>
	<alpine.LFD.2.00.0811071129440.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52463 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750879AbYKGRW2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Nov 2008 12:22:28 -0500
In-Reply-To: <alpine.LFD.2.00.0811071129440.13034@xanadu.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
Cc: David Howells <dhowells@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, benh@kernel.crashing.org, paulus@samba.org, David Miller <davem@davemloft.net>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org

On Fri, 07 Nov 2008 11:47:47 -0500 (EST) Nicolas Pitre <nico@cam.org> wrote:

> > btw, do you know how damned irritating and frustrating it is for a code
> > reviewer to have his comments deliberately ignored and deleted in
> > replies?
> 
> Do you know how irritating and frustrating it is when reviewers don't 
> care reading the damn comments along with the code?

As you still seek to ignore it, I shall repeat my earlier question. 
Please do not delete it again.

   It apparently tries to avoid races via ordering tricks, as long
   as it is called with sufficient frequency.  But nothing guarantees
   that it _is_ called sufficiently frequently?

Things like tickless kernels and SCHED_RR can surely cause
sched_clock() to not be called for arbitrary periods.

Userspace cli() will definitely do this, but it is expected to break
stuff and is not as legitiate a thing to do.


I'm just giving up on the tastefulness issue.
