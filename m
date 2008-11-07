From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [RFC patch 08/18] cnt32_to_63 should use smp_rmb()
Date: Fri, 07 Nov 2008 10:30:24 -0800
Message-ID: <1226082624.11596.28.camel@brick>
References: <20081107003816.9b0f947a.akpm@linux-foundation.org>
	 <20081107052336.652868737@polymtl.ca> <20081107053349.861709786@polymtl.ca>
	 <20081106220530.5b0e3a96.akpm@linux-foundation.org>
	 <alpine.LFD.2.00.0811070256450.13034@xanadu.home>
	 <25363.1226056819@redhat.com>
	 <alpine.LFD.2.00.0811070952150.13034@xanadu.home>
	 <8189.1226074915@redhat.com> <8509.1226077800@redhat.com>
	 <20081107092643.0bd9bb4e.akpm@linux-foundation.org>
	 <20081107180041.GG22134@Krystal>
	 <20081107102148.6eb53dea.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.190]:49025 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbYKGSa1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Nov 2008 13:30:27 -0500
In-Reply-To: <20081107102148.6eb53dea.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>, dhowells@redhat.com, nico@cam.org, torvalds@linux-foundation.org, mingo@elte.hu, a.p.zijlstra@chello.nl, linux-kernel@vger.kernel.org, ralf@linux-mips.org, benh@kernel.crashing.org, paulus@samba.org, davem@davemloft.net, mingo@redhat.com, tglx@linutronix.de, rostedt@goodmis.org, linux-arch@vger.kernel.org

On Fri, 2008-11-07 at 10:21 -0800, Andrew Morton wrote:
> On Fri, 7 Nov 2008 13:00:41 -0500
> Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:
> > > It's one of those things I hope I never need to know about, but perhaps
> > > we do somewhere have static storage in an inline.  Wouldn't surprise
> > > me, and I bet that if we do, it's a bug.
> > 
> > Tracepoints actually use that.
> 
> Referring to include/linux/tracepoint.h:DEFINE_TRACE()?
> 
> It does look a bit fragile.  Does every .c file which included
> include/trace/block.h get a copy of __tracepoint_block_rq_issue,
> whether or not it used that tracepoint? Hopefully not.
> 
> > It could be changed so they use :
> > 
> > DECLARE_TRACE() (in include/trace/group.h)
> > DEFINE_TRACE()  (in the appropriate kernel c file)
> > trace_somename(); (in the code)
> > 
> > instead. That would actually make more sense and remove the need for
> > multiple declarations when the same tracepoint name is used in many
> > spots (this is a problem kmemtrace has, it generates a lot of tracepoint
> > declarations).

Could this scheme also help with the thousands of sparse warnings that
kmemtrace produces because of the current arrangement, all of the form:

include/linux/kmemtrace.h:33:2: warning: Initializer entry defined twice
include/linux/kmemtrace.h:33:2:   also defined here

As you could have unique names for the tracepoints now, rather than the
'unique' static storage?  Or am I off-base here?

Harvey
