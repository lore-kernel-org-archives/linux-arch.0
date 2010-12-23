From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + kthread-numa-aware-kthread_create_on_cpu.patch added to -mm
 tree
Date: Thu, 23 Dec 2010 13:45:54 -0800
Message-ID: <20101223134554.ec66e229.akpm@linux-foundation.org>
References: <201012100044.oBA0ivp3016990@imap1.linux-foundation.org>
	<1293131522.2170.798.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36412 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751186Ab0LWVwW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Dec 2010 16:52:22 -0500
In-Reply-To: <1293131522.2170.798.camel@laptop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: eric.dumazet@gmail.com, ak@linux.intel.com, davem@davemloft.net, dhowells@redhat.com, fenghua.yu@intel.com, linux-arch@vger.kernel.org, rusty@rustcorp.com.au, tj@kernel.org, tony.luck@intel.com

On Thu, 23 Dec 2010 20:12:02 +0100 Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, 2010-12-09 at 16:44 -0800, akpm@linux-foundation.org wrote:
> > +struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
> > +                                         void *data,
> > +                                         int cpu,
> > +                                         const char namefmt[],
> > +                                         ...)
> 
> I thought it was agreed that name sucked too much to live?
> 
> All other *_on_cpu() interfaces actually do stuff on that cpu, but this
> does not in fact create a cpu affine task.

Agree.  I'd assumed that a new version was brewing in Dumazet Labs.
