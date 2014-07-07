From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/11] qspinlock: Optimize for smaller NR_CPUS
Date: Mon, 07 Jul 2014 18:10:30 +0200
Message-ID: <53BAC676.5030804@redhat.com>
References: <20140615124657.264658593@chello.nl>
	<20140615130153.483502389@chello.nl> <53A17A88.7090705@redhat.com>
	<20140707143503.GS6758@twins.programming.kicks-ass.net>
	<53BAB7E1.4010506@redhat.com>
	<20140707153552.GE19379@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140707153552.GE19379@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman.Long@hp.com, linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

Il 07/07/2014 17:35, Peter Zijlstra ha scritto:
>> > Unlike the change in patch 4, clear_pending_set_locked doesn't change how
>> > qspinlock moves from a state to the next.
> True, but its where we start to break up into smaller functions. And the
> only reason we break them out is because we'll get different
> implementations depending on NR_CPUS.
>
> So we can view the breakout of xchg_tail and clear_and_set_pending as
> preparatory work for introducing the NR_CPUS thing.

That's a different reasoning, but it's fine by me too.

Paolo
