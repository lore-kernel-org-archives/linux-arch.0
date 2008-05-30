From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 11:06:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805301101490.14564@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <1212138752.12349.227.camel@twins>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:38556 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750909AbYE3SGf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 May 2008 14:06:35 -0400
In-Reply-To: <1212138752.12349.227.camel@twins>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 30 May 2008, Peter Zijlstra wrote:

> For one the fixed size alloction limit as pointed out by Andrew.

Ok.

> What this does is make a strong connection between data and concurrency
> control. Your proposed scheme weakens the data<->concurrency relation
> instead of making it stronger.
> 
> One sign of that is that you replace things like get_cpu with explicit
> preempt_disable().

That is a side effect of trying to make transformation of source code 
easily visible. Its not necessary if some changes are made to the code.
 
> We're trying to get rid of as many explicit preempt_disable()s as
> possible - in the light of -rt, preempt_disable() is as bad as the BKL
> in that its opaque - unrelated to a specific data set.

The cpu ops patches get rid of lots of preempt enable /disable and 
get_cpu/put_cpu() because the per cpu address determination no longer 
needs to be protected. See some of the other patches. Some code may need 
to be a bit rewritten to take advantage. The SLUB fastpath f.e. (and 
likely the page allocator too) can be done exclusively with CPU_OPS 
thereby avoiding locks and preemption issues.
 
