From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/9] qspinlock stuff -v15
Date: Thu, 26 Mar 2015 21:21:53 +0100
Message-ID: <20150326202153.GD27490@worktop.programming.kicks-ass.net>
References: <20150316131613.720617163@infradead.org>
	<20150325194739.GK25884@l.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20150325194739.GK25884@l.oracle.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Waiman.Long@hp.com, linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org, kvm@vger.kernel.org, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, oleg@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, david.vrabel@citrix.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, doug.hatch@hp.com
List-Id: linux-arch.vger.kernel.org

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
