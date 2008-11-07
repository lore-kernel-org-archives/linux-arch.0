From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC patch 08/18] cnt32_to_63 should use smp_rmb()
Date: Fri, 7 Nov 2008 10:36:27 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811071034520.3468@nehalem.linux-foundation.org>
References: <20081107003816.9b0f947a.akpm@linux-foundation.org> <20081107052336.652868737@polymtl.ca> <20081107053349.861709786@polymtl.ca> <20081106220530.5b0e3a96.akpm@linux-foundation.org> <alpine.LFD.2.00.0811070256450.13034@xanadu.home>
 <25363.1226056819@redhat.com> <alpine.LFD.2.00.0811070952150.13034@xanadu.home> <8189.1226074915@redhat.com> <8509.1226077800@redhat.com> <20081107092643.0bd9bb4e.akpm@linux-foundation.org> <20081107180041.GG22134@Krystal>
 <20081107102148.6eb53dea.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52925 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751082AbYKGShv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Nov 2008 13:37:51 -0500
In-Reply-To: <20081107102148.6eb53dea.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, dhowells@redhat.com, nico@cam.org, mingo@elte.hu, a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org, davem@davemloft.net, mingo@redhat.com, tglx@linutronix.de, rostedt@goodmis.org, linux-arch@vger.kernel.org



On Fri, 7 Nov 2008, Andrew Morton wrote:
> 
> Referring to include/linux/tracepoint.h:DEFINE_TRACE()?
> 
> It does look a bit fragile.  Does every .c file which included
> include/trace/block.h get a copy of __tracepoint_block_rq_issue,
> whether or not it used that tracepoint? Hopefully not.

Look at "ratelimit()" too. Broken, broken.  Of course, I don't think it's 
actually _used_ anywhere, so..

		Linus
