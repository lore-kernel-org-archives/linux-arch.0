From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 00/41] cpu alloc / cpu ops v3: Optimize per cpu access
Date: Fri, 30 May 2008 20:19:34 +0200
Message-ID: <1212171574.24826.12.camel@lappy.programming.kicks-ass.net>
References: <20080530035620.587204923@sgi.com>
	 <1212138752.12349.227.camel@twins>
	 <Pine.LNX.4.64.0805301101490.14564@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:54364 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752601AbYE3SUo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 14:20:44 -0400
In-Reply-To: <Pine.LNX.4.64.0805301101490.14564@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>

On Fri, 2008-05-30 at 11:06 -0700, Christoph Lameter wrote:
> On Fri, 30 May 2008, Peter Zijlstra wrote:
> 
> > For one the fixed size alloction limit as pointed out by Andrew.
> 
> Ok.
> 
> > What this does is make a strong connection between data and concurrency
> > control. Your proposed scheme weakens the data<->concurrency relation
> > instead of making it stronger.
> > 
> > One sign of that is that you replace things like get_cpu with explicit
> > preempt_disable().
> 
> That is a side effect of trying to make transformation of source code 
> easily visible. Its not necessary if some changes are made to the code.
>  
> > We're trying to get rid of as many explicit preempt_disable()s as
> > possible - in the light of -rt, preempt_disable() is as bad as the BKL
> > in that its opaque - unrelated to a specific data set.
> 
> The cpu ops patches get rid of lots of preempt enable /disable and 
> get_cpu/put_cpu() because the per cpu address determination no longer 
> needs to be protected. See some of the other patches. Some code may need 
> to be a bit rewritten to take advantage. The SLUB fastpath f.e. (and 
> likely the page allocator too) can be done exclusively with CPU_OPS 
> thereby avoiding locks and preemption issues.

Sure, that's good stuff, and I'm not objecting to that.

But for example the perpcu_counter, workqueue, (nfs), module handling,
slub and page allocator can use the scheme I proposed.

Please consider adding this get/put interface.
