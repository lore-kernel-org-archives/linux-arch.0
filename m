From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 0/9] qspinlock stuff -v15
Date: Wed, 25 Mar 2015 15:47:39 -0400
Message-ID: <20150325194739.GK25884@l.oracle.com>
References: <20150316131613.720617163@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39849 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbbCYTsa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Mar 2015 15:48:30 -0400
Content-Disposition: inline
In-Reply-To: <20150316131613.720617163@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman.Long@hp.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net

On Mon, Mar 16, 2015 at 02:16:13PM +0100, Peter Zijlstra wrote:
> Hi Waiman,
> 
> As promised; here is the paravirt stuff I did during the trip to BOS last week.
> 
> All the !paravirt patches are more or less the same as before (the only real
> change is the copyright lines in the first patch).
> 
> The paravirt stuff is 'simple' and KVM only -- the Xen code was a little more
> convoluted and I've no real way to test that but it should be stright fwd to
> make work.
> 
> I ran this using the virtme tool (thanks Andy) on my laptop with a 4x
> overcommit on vcpus (16 vcpus as compared to the 4 my laptop actually has) and
> it both booted and survived a hackbench run (perf bench sched messaging -g 20
> -l 5000).
> 
> So while the paravirt code isn't the most optimal code ever conceived it does work.
> 
> Also, the paravirt patching includes replacing the call with "movb $0, %arg1"
> for the native case, which should greatly reduce the cost of having
> CONFIG_PARAVIRT_SPINLOCKS enabled on actual hardware.

Ah nice. That could be spun out as a seperate patch to optimize the existing
ticket locks I presume.

Now with the old pv ticketlock code an vCPU would only go to sleep once and
be woken up when it was its turn. With this new code it is woken up twice 
(and twice it goes to sleep). With an overcommit scenario this would imply
that we will have at least twice as many VMEXIT as with the previous code.

I presume when you did benchmarking this did not even register? Thought
I wonder if it would if you ran the benchmark for a week or so.

> 
> I feel that if someone were to do a Xen patch we can go ahead and merge this
> stuff (finally!).
> 
> These patches do not implement the paravirt spinlock debug stats currently
> implemented (separately) by KVM and Xen, but that should not be too hard to do
> on top and in the 'generic' code -- no reason to duplicate all that.
> 
> Of course; once this lands people can look at improving the paravirt nonsense.
> 
