Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54755 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbbCZUWH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Mar 2015 16:22:07 -0400
Date: Thu, 26 Mar 2015 21:21:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/9] qspinlock stuff -v15
Message-ID: <20150326202153.GD27490@worktop.programming.kicks-ass.net>
References: <20150316131613.720617163@infradead.org>
 <20150325194739.GK25884@l.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150325194739.GK25884@l.oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Waiman.Long@hp.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150326202153.zuJq1fX8h-WiMuQbMsEbD0q-ERqr60pkIOnL-_4Tb-w@z>

On Wed, Mar 25, 2015 at 03:47:39PM -0400, Konrad Rzeszutek Wilk wrote:
> Ah nice. That could be spun out as a seperate patch to optimize the existing
> ticket locks I presume.

Yes I suppose we can do something similar for the ticket and patch in
the right increment. We'd need to restructure the code a bit, but
its not fundamentally impossible.

We could equally apply the head hashing to the current ticket
implementation and avoid the current bitmap iteration.

> Now with the old pv ticketlock code an vCPU would only go to sleep once and
> be woken up when it was its turn. With this new code it is woken up twice 
> (and twice it goes to sleep). With an overcommit scenario this would imply
> that we will have at least twice as many VMEXIT as with the previous code.

An astute observation, I had not considered that.

> I presume when you did benchmarking this did not even register? Thought
> I wonder if it would if you ran the benchmark for a week or so.

You presume I benchmarked :-) I managed to boot something virt and run
hackbench in it. I wouldn't know a representative virt setup if I ran
into it.

The thing is, we want this qspinlock for real hardware because its
faster and I really want to avoid having to carry two spinlock
implementations -- although I suppose that if we really really have to
we could.
